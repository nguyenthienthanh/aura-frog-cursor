#!/bin/bash
#
# Aura Frog - Version Sync Script
# Syncs version from VERSION file to all project files
#
# Usage:
#   ./scripts/sync-version.sh              # Sync version only
#   ./scripts/sync-version.sh --with-date  # Sync version + update dates
#   ./scripts/sync-version.sh --dry-run    # Preview changes without applying
#   ./scripts/sync-version.sh --bump patch # Bump version (patch/minor/major)
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get script directory and project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
VERSION_FILE="$PROJECT_ROOT/VERSION"

# Options
DRY_RUN=false
WITH_DATE=false
BUMP_TYPE=""

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --with-date)
            WITH_DATE=true
            shift
            ;;
        --bump)
            BUMP_TYPE="$2"
            shift 2
            ;;
        -h|--help)
            echo "Usage: $0 [options]"
            echo ""
            echo "Options:"
            echo "  --dry-run     Preview changes without applying"
            echo "  --with-date   Also update 'Last Updated' dates to today"
            echo "  --bump TYPE   Bump version before syncing (patch|minor|major)"
            echo "  -h, --help    Show this help message"
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            exit 1
            ;;
    esac
done

# Check VERSION file exists
if [[ ! -f "$VERSION_FILE" ]]; then
    echo -e "${RED}ERROR: VERSION file not found at $VERSION_FILE${NC}"
    exit 1
fi

# Read current version
CURRENT_VERSION=$(cat "$VERSION_FILE" | tr -d '[:space:]')

# Bump version if requested
if [[ -n "$BUMP_TYPE" ]]; then
    IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"

    case $BUMP_TYPE in
        patch)
            PATCH=$((PATCH + 1))
            ;;
        minor)
            MINOR=$((MINOR + 1))
            PATCH=0
            ;;
        major)
            MAJOR=$((MAJOR + 1))
            MINOR=0
            PATCH=0
            ;;
        *)
            echo -e "${RED}Invalid bump type: $BUMP_TYPE (use patch, minor, or major)${NC}"
            exit 1
            ;;
    esac

    NEW_VERSION="$MAJOR.$MINOR.$PATCH"

    if [[ "$DRY_RUN" == true ]]; then
        echo -e "${YELLOW}[DRY RUN] Would bump version: $CURRENT_VERSION -> $NEW_VERSION${NC}"
    else
        echo "$NEW_VERSION" > "$VERSION_FILE"
        echo -e "${GREEN}Bumped version: $CURRENT_VERSION -> $NEW_VERSION${NC}"
        CURRENT_VERSION="$NEW_VERSION"
    fi
fi

echo -e "${BLUE}======================================${NC}"
echo -e "${BLUE}  Aura Frog Version Sync${NC}"
echo -e "${BLUE}======================================${NC}"
echo ""
echo -e "Version: ${GREEN}$CURRENT_VERSION${NC}"
if [[ "$DRY_RUN" == true ]]; then
    echo -e "Mode: ${YELLOW}DRY RUN (no changes will be made)${NC}"
fi
if [[ "$WITH_DATE" == true ]]; then
    echo -e "Update dates: ${GREEN}Yes${NC}"
fi
echo ""

# Get today's date
TODAY=$(date +%Y-%m-%d)

# Counter for updated files
UPDATED_COUNT=0
SKIPPED_COUNT=0

# Function to update version in a file
update_file() {
    local file="$1"
    local relative_path="${file#$PROJECT_ROOT/}"

    # Skip VERSION file itself
    if [[ "$file" == "$VERSION_FILE" ]]; then
        return
    fi

    # Check if file contains version pattern
    if grep -q "Version.*[0-9]\+\.[0-9]\+\.[0-9]\+" "$file" 2>/dev/null || \
       grep -q "version.*[0-9]\+\.[0-9]\+\.[0-9]\+" "$file" 2>/dev/null; then

        if [[ "$DRY_RUN" == true ]]; then
            echo -e "  ${YELLOW}[WOULD UPDATE]${NC} $relative_path"
        else
            # Update version patterns
            # Pattern: **Version:** X.Y.Z or Version: X.Y.Z
            sed -i '' -E "s/(Version:?\*?\*?[[:space:]]*)[0-9]+\.[0-9]+\.[0-9]+/\1$CURRENT_VERSION/g" "$file"

            # Update "Last Updated" if requested
            if [[ "$WITH_DATE" == true ]]; then
                sed -i '' -E "s/(Last Updated:?\*?\*?[[:space:]]*)[0-9]{4}-[0-9]{2}-[0-9]{2}/\1$TODAY/g" "$file"
            fi

            echo -e "  ${GREEN}[UPDATED]${NC} $relative_path"
        fi
        UPDATED_COUNT=$((UPDATED_COUNT + 1))
    else
        SKIPPED_COUNT=$((SKIPPED_COUNT + 1))
    fi
}

# Find and process all markdown and mdc files
echo -e "${BLUE}Processing files...${NC}"
echo ""

# Process .md files
while IFS= read -r -d '' file; do
    update_file "$file"
done < <(find "$PROJECT_ROOT" -type f -name "*.md" -not -path "*/.git/*" -not -path "*/node_modules/*" -print0)

# Process .mdc files
while IFS= read -r -d '' file; do
    update_file "$file"
done < <(find "$PROJECT_ROOT" -type f -name "*.mdc" -not -path "*/.git/*" -not -path "*/node_modules/*" -print0)

echo ""
echo -e "${BLUE}======================================${NC}"
echo -e "${GREEN}Summary:${NC}"
echo -e "  Files updated: ${GREEN}$UPDATED_COUNT${NC}"
echo -e "  Files skipped: ${YELLOW}$SKIPPED_COUNT${NC}"
echo -e "${BLUE}======================================${NC}"

if [[ "$DRY_RUN" == true ]]; then
    echo ""
    echo -e "${YELLOW}This was a dry run. Run without --dry-run to apply changes.${NC}"
fi
