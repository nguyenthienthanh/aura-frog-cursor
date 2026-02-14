#!/usr/bin/env bash
#
# validate-rules.sh - CI validation for MDC rule files
#
# Checks:
#   1. All .mdc files have valid YAML frontmatter
#   2. alwaysApply: true count does not exceed 10 (warns if >8)
#   3. No duplicate rule filenames across directories
#   4. VERSION file matches latest CHANGELOG.md version header
#   5. alwaysApply: true files are under 100 lines
#
# Exit codes:
#   0 - All checks pass
#   1 - One or more checks failed

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RULES_DIR="$REPO_ROOT/.cursor/rules"
VERSION_FILE="$REPO_ROOT/VERSION"
CHANGELOG_FILE="$REPO_ROOT/CHANGELOG.md"

ERRORS=0
WARNINGS=0

# Color helpers (disabled when not a terminal)
if [ -t 1 ]; then
    RED='\033[0;31m'
    YELLOW='\033[1;33m'
    GREEN='\033[0;32m'
    BOLD='\033[1m'
    NC='\033[0m'
else
    RED=''
    YELLOW=''
    GREEN=''
    BOLD=''
    NC=''
fi

error() {
    echo -e "${RED}ERROR:${NC} $1"
    ERRORS=$((ERRORS + 1))
}

warn() {
    echo -e "${YELLOW}WARNING:${NC} $1"
    WARNINGS=$((WARNINGS + 1))
}

pass() {
    echo -e "${GREEN}PASS:${NC} $1"
}

separator() {
    echo ""
    echo -e "${BOLD}--- $1 ---${NC}"
}

# -------------------------------------------------------
# Check 1: Valid YAML frontmatter in all .mdc files
# -------------------------------------------------------
separator "Check 1: YAML Frontmatter Validation"

mdc_files=()
while IFS= read -r -d '' file; do
    mdc_files+=("$file")
done < <(find "$RULES_DIR" -name '*.mdc' -type f -print0)

if [ ${#mdc_files[@]} -eq 0 ]; then
    error "No .mdc files found in $RULES_DIR"
else
    echo "Found ${#mdc_files[@]} .mdc files to validate."
    frontmatter_errors=0

    for file in "${mdc_files[@]}"; do
        rel_path="${file#$REPO_ROOT/}"

        # Check that the file starts with ---
        first_line="$(head -n 1 "$file")"
        if [ "$first_line" != "---" ]; then
            error "$rel_path: Does not start with '---' (YAML frontmatter opening)"
            frontmatter_errors=$((frontmatter_errors + 1))
            continue
        fi

        # Find the closing --- (second occurrence, skipping line 1)
        closing_line=0
        line_num=0
        while IFS= read -r line; do
            line_num=$((line_num + 1))
            if [ "$line_num" -gt 1 ] && [ "$line" = "---" ]; then
                closing_line=$line_num
                break
            fi
        done < "$file"

        if [ "$closing_line" -eq 0 ]; then
            error "$rel_path: No closing '---' found for YAML frontmatter"
            frontmatter_errors=$((frontmatter_errors + 1))
            continue
        fi

        # Extract frontmatter content (between the two --- lines)
        frontmatter="$(sed -n "2,$((closing_line - 1))p" "$file")"

        # Check for 'description' field
        if ! echo "$frontmatter" | grep -qE '^description:'; then
            error "$rel_path: Missing 'description' field in frontmatter"
            frontmatter_errors=$((frontmatter_errors + 1))
        fi

        # Check for 'alwaysApply' field
        if ! echo "$frontmatter" | grep -qE '^alwaysApply:'; then
            error "$rel_path: Missing 'alwaysApply' field in frontmatter"
            frontmatter_errors=$((frontmatter_errors + 1))
        fi
    done

    if [ "$frontmatter_errors" -eq 0 ]; then
        pass "All ${#mdc_files[@]} .mdc files have valid YAML frontmatter."
    fi
fi

# -------------------------------------------------------
# Check 2: alwaysApply: true count
# -------------------------------------------------------
separator "Check 2: alwaysApply: true Count"

always_apply_count=0
always_apply_files=()

for file in "${mdc_files[@]}"; do
    # Extract frontmatter and check alwaysApply value
    closing_line=0
    line_num=0
    while IFS= read -r line; do
        line_num=$((line_num + 1))
        if [ "$line_num" -gt 1 ] && [ "$line" = "---" ]; then
            closing_line=$line_num
            break
        fi
    done < "$file"

    if [ "$closing_line" -gt 0 ]; then
        frontmatter="$(sed -n "2,$((closing_line - 1))p" "$file")"
        if echo "$frontmatter" | grep -qE '^alwaysApply:\s*true'; then
            always_apply_count=$((always_apply_count + 1))
            always_apply_files+=("$file")
        fi
    fi
done

echo "Files with alwaysApply: true = $always_apply_count"

if [ "$always_apply_count" -gt 10 ]; then
    error "alwaysApply: true count ($always_apply_count) exceeds maximum of 10"
elif [ "$always_apply_count" -gt 8 ]; then
    warn "alwaysApply: true count ($always_apply_count) is approaching the limit of 10"
    pass "alwaysApply: true count is within limit (max 10)."
else
    pass "alwaysApply: true count is within limit (max 10)."
fi

# -------------------------------------------------------
# Check 3: No duplicate rule filenames across directories
# -------------------------------------------------------
separator "Check 3: Duplicate Filename Detection"

declare -A filename_map
duplicate_found=0

for file in "${mdc_files[@]}"; do
    basename="$(basename "$file")"
    rel_path="${file#$REPO_ROOT/}"

    if [ -n "${filename_map[$basename]+x}" ]; then
        if [ "$duplicate_found" -eq 0 ] || ! echo "${filename_map[$basename]}" | grep -q "DUPLICATE"; then
            # First duplicate detected for this filename
            error "Duplicate filename '$basename' found:"
            error "  - ${filename_map[$basename]}"
            error "  - $rel_path"
            filename_map[$basename]="${filename_map[$basename]} DUPLICATE"
        else
            error "  - $rel_path"
        fi
        duplicate_found=1
    else
        filename_map[$basename]="$rel_path"
    fi
done

if [ "$duplicate_found" -eq 0 ]; then
    pass "No duplicate filenames found across directories."
fi

# -------------------------------------------------------
# Check 4: Version consistency (VERSION vs CHANGELOG.md)
# -------------------------------------------------------
separator "Check 4: Version Consistency"

if [ ! -f "$VERSION_FILE" ]; then
    error "VERSION file not found at $VERSION_FILE"
elif [ ! -f "$CHANGELOG_FILE" ]; then
    error "CHANGELOG.md not found at $CHANGELOG_FILE"
else
    version="$(tr -d '[:space:]' < "$VERSION_FILE")"
    # Extract first version header from CHANGELOG: ## [X.Y.Z] - YYYY-MM-DD
    changelog_version="$(grep -m 1 -oP '## \[\K[0-9]+\.[0-9]+\.[0-9]+' "$CHANGELOG_FILE" || true)"

    if [ -z "$version" ]; then
        error "VERSION file is empty"
    elif [ -z "$changelog_version" ]; then
        error "Could not find a version header in CHANGELOG.md (expected format: ## [X.Y.Z] - YYYY-MM-DD)"
    elif [ "$version" != "$changelog_version" ]; then
        error "Version mismatch: VERSION file says '$version' but CHANGELOG.md latest entry says '$changelog_version'"
    else
        pass "Version is consistent: $version (VERSION) matches $changelog_version (CHANGELOG.md)."
    fi
fi

# -------------------------------------------------------
# Check 5: alwaysApply: true files under 100 lines
# -------------------------------------------------------
separator "Check 5: alwaysApply: true File Size"

oversize_found=0

for file in "${always_apply_files[@]}"; do
    rel_path="${file#$REPO_ROOT/}"
    line_count="$(wc -l < "$file")"

    if [ "$line_count" -ge 100 ]; then
        error "$rel_path: Has alwaysApply: true but is $line_count lines (must be under 100)"
        oversize_found=1
    fi
done

if [ "$oversize_found" -eq 0 ]; then
    pass "All alwaysApply: true files are under 100 lines."
fi

# -------------------------------------------------------
# Summary
# -------------------------------------------------------
echo ""
echo -e "${BOLD}========== VALIDATION SUMMARY ==========${NC}"
echo "  Total .mdc files checked: ${#mdc_files[@]}"
echo "  alwaysApply: true files:  $always_apply_count"
echo "  Errors:   $ERRORS"
echo "  Warnings: $WARNINGS"
echo -e "${BOLD}=========================================${NC}"

if [ "$ERRORS" -gt 0 ]; then
    echo ""
    echo -e "${RED}Validation FAILED with $ERRORS error(s).${NC}"
    exit 1
else
    echo ""
    echo -e "${GREEN}Validation PASSED.${NC}"
    exit 0
fi
