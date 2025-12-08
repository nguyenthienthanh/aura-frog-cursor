#!/bin/bash

# Aura Frog for Cursor IDE - Setup Script
# Version: 1.1.4
#
# This script installs Aura Frog to your project by copying
# the .cursor folder and setting up integrations.

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Parse flags
FORCE_OVERRIDE=false
while [[ $# -gt 0 ]]; do
    case $1 in
        -f|--force)
            FORCE_OVERRIDE=true
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [OPTIONS] [TARGET_PATH]"
            echo ""
            echo "Options:"
            echo "  -f, --force    Force override all existing files (including .envrc)"
            echo "  -h, --help     Show this help message"
            echo ""
            echo "Examples:"
            echo "  $0 /path/to/project           # Install with merge"
            echo "  $0 --force /path/to/project   # Force override all files"
            exit 0
            ;;
        *)
            # Assume it's the target path
            TARGET_ARG="$1"
            shift
            ;;
    esac
done

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CURSOR_SOURCE="$SCRIPT_DIR/.cursor"

# Banner
echo -e "${CYAN}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🐸 AURA FROG for Cursor IDE - Setup Script v1.1.4"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${NC}"

# Check if .cursor source exists
if [ ! -d "$CURSOR_SOURCE" ]; then
    echo -e "${RED}Error: .cursor folder not found at $CURSOR_SOURCE${NC}"
    echo "Please run this script from the aura-frog-cursor repository root."
    exit 1
fi

# Get target project path
if [ -n "$TARGET_ARG" ]; then
    TARGET_PROJECT="$TARGET_ARG"
else
    echo -e "${YELLOW}Enter the path to your target project:${NC}"
    read -r TARGET_PROJECT
fi

# Expand ~ to home directory
TARGET_PROJECT="${TARGET_PROJECT/#\~/$HOME}"

# Convert to absolute path
TARGET_PROJECT="$(cd "$TARGET_PROJECT" 2>/dev/null && pwd)" || {
    echo -e "${RED}Error: Invalid path '$TARGET_PROJECT'${NC}"
    exit 1
}

echo ""
echo -e "${BLUE}Target project:${NC} $TARGET_PROJECT"
echo ""

# Confirm installation
echo -e "${YELLOW}This will copy .cursor folder to your project.${NC}"
if [ "$FORCE_OVERRIDE" = true ]; then
    echo -e "${RED}Mode: FORCE OVERRIDE - All existing files will be replaced.${NC}"
else
    echo -e "${GREEN}Mode: MERGE - Existing .envrc will be preserved, missing vars added.${NC}"
fi
echo ""
read -p "Continue? (y/N): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}Setup cancelled.${NC}"
    exit 0
fi

# Copy .cursor folder
echo ""
echo -e "${BLUE}[1/4] Copying .cursor folder...${NC}"

# Function to append missing content to existing file
append_missing_content() {
    local source="$1"
    local target="$2"
    local marker="# --- AURA FROG APPEND ---"

    # If target doesn't exist, just copy
    if [ ! -f "$target" ]; then
        cp "$source" "$target"
        return 0
    fi

    # Check if source content is already in target
    if grep -qF "AURA FROG" "$target" 2>/dev/null; then
        # Aura Frog content exists, skip
        return 1
    fi

    # Append source content to target with marker
    echo "" >> "$target"
    echo "$marker" >> "$target"
    echo "" >> "$target"
    cat "$source" >> "$target"
    return 0
}

# Function to smart merge files
smart_merge_files() {
    local source_dir="$1"
    local target_dir="$2"
    local files_copied=0
    local files_merged=0
    local files_skipped=0

    # Create target directory if it doesn't exist
    mkdir -p "$target_dir"

    # Process all files recursively
    find "$source_dir" -type f | while read -r source_file; do
        # Get relative path
        local rel_path="${source_file#$source_dir/}"
        local target_file="$target_dir/$rel_path"
        local target_subdir="$(dirname "$target_file")"

        # Create subdirectory if needed
        mkdir -p "$target_subdir"

        # Check if target file exists
        if [ -f "$target_file" ]; then
            if [ "$FORCE_OVERRIDE" = true ]; then
                # Force mode: override
                cp "$source_file" "$target_file"
            else
                # Merge mode: append if missing Aura Frog content
                # For key config files, try to append
                case "$rel_path" in
                    *.md|*.mdc)
                        # Check if Aura Frog content exists
                        if ! grep -qF "AURA FROG" "$target_file" 2>/dev/null && \
                           ! grep -qF "Aura Frog" "$target_file" 2>/dev/null; then
                            # Append content
                            echo "" >> "$target_file"
                            echo "# --- Appended from Aura Frog ---" >> "$target_file"
                            echo "" >> "$target_file"
                            cat "$source_file" >> "$target_file"
                        fi
                        ;;
                    *)
                        # For other files, only copy if target is empty or doesn't exist
                        if [ ! -s "$target_file" ]; then
                            cp "$source_file" "$target_file"
                        fi
                        ;;
                esac
            fi
        else
            # Target doesn't exist, copy it
            cp "$source_file" "$target_file"
        fi
    done
}

if [ -d "$TARGET_PROJECT/.cursor" ]; then
    echo -e "${YELLOW}  Existing .cursor folder found.${NC}"
    if [ "$FORCE_OVERRIDE" = true ]; then
        echo -e "${YELLOW}  Force mode: overriding all files...${NC}"
        rsync -av --progress "$CURSOR_SOURCE/" "$TARGET_PROJECT/.cursor/" > /dev/null 2>&1
    else
        echo -e "${GREEN}  Merge mode: copying new files, appending to existing...${NC}"
        smart_merge_files "$CURSOR_SOURCE" "$TARGET_PROJECT/.cursor"
    fi
else
    # No existing folder, just copy everything
    rsync -av --progress "$CURSOR_SOURCE/" "$TARGET_PROJECT/.cursor/" > /dev/null 2>&1
fi

# Handle .cursorrules separately (critical config file)
CURSORRULES_SOURCE="$SCRIPT_DIR/.cursorrules"
CURSORRULES_TARGET="$TARGET_PROJECT/.cursorrules"

if [ -f "$CURSORRULES_SOURCE" ]; then
    if [ -f "$CURSORRULES_TARGET" ]; then
        if [ "$FORCE_OVERRIDE" = true ]; then
            cp "$CURSORRULES_SOURCE" "$CURSORRULES_TARGET"
            echo -e "${GREEN}  ✓ .cursorrules overwritten${NC}"
        else
            # Check if Aura Frog content already exists
            if grep -qF "AURA FROG" "$CURSORRULES_TARGET" 2>/dev/null || \
               grep -qF "Aura Frog" "$CURSORRULES_TARGET" 2>/dev/null; then
                echo -e "${YELLOW}  .cursorrules already contains Aura Frog config${NC}"
            else
                # Append Aura Frog config
                echo "" >> "$CURSORRULES_TARGET"
                echo "" >> "$CURSORRULES_TARGET"
                echo "# ============================================" >> "$CURSORRULES_TARGET"
                echo "# AURA FROG CONFIGURATION (Appended)" >> "$CURSORRULES_TARGET"
                echo "# ============================================" >> "$CURSORRULES_TARGET"
                echo "" >> "$CURSORRULES_TARGET"
                cat "$CURSORRULES_SOURCE" >> "$CURSORRULES_TARGET"
                echo -e "${GREEN}  ✓ Aura Frog config appended to .cursorrules${NC}"
            fi
        fi
    else
        cp "$CURSORRULES_SOURCE" "$CURSORRULES_TARGET"
        echo -e "${GREEN}  ✓ .cursorrules created${NC}"
    fi
fi

echo -e "${GREEN}  ✓ .cursor folder installed${NC}"

# Setup .envrc
echo ""
echo -e "${BLUE}[2/4] Setting up environment file...${NC}"

ENVRC_TEMPLATE="$SCRIPT_DIR/.envrc.template"
ENVRC_TARGET="$TARGET_PROJECT/.cursor/.envrc"

# Function to merge missing env vars from template to existing file
merge_envrc() {
    local template="$1"
    local target="$2"
    local added=0

    # Get all export lines from template
    while IFS= read -r line; do
        # Extract variable name (e.g., JIRA_URL from "export JIRA_URL=...")
        if [[ "$line" =~ ^export[[:space:]]+([A-Z_]+)= ]]; then
            var_name="${BASH_REMATCH[1]}"
            # Check if this variable exists in target (commented or not)
            if ! grep -q "export $var_name=" "$target" 2>/dev/null; then
                # Variable not found, append it
                echo "" >> "$target"
                echo "$line" >> "$target"
                ((added++))
            fi
        fi
    done < "$template"

    echo $added
}

if [ -f "$ENVRC_TARGET" ] && [ "$FORCE_OVERRIDE" = false ]; then
    echo -e "${YELLOW}  .envrc already exists. Checking for missing variables...${NC}"

    # Determine which template to use for merging
    if [ -f "$ENVRC_TEMPLATE" ]; then
        MERGE_SOURCE="$ENVRC_TEMPLATE"
    else
        MERGE_SOURCE="$TARGET_PROJECT/.cursor/.envrc.template"
    fi

    if [ -f "$MERGE_SOURCE" ]; then
        added=$(merge_envrc "$MERGE_SOURCE" "$ENVRC_TARGET")
        if [ "$added" -gt 0 ]; then
            echo -e "${GREEN}  ✓ Added $added missing environment variables${NC}"
        else
            echo -e "${GREEN}  ✓ All environment variables present${NC}"
        fi
    else
        echo -e "${YELLOW}  No template found for merging${NC}"
    fi
elif [ -f "$ENVRC_TARGET" ] && [ "$FORCE_OVERRIDE" = true ]; then
    # Backup existing .envrc before overriding
    cp "$ENVRC_TARGET" "$ENVRC_TARGET.backup"
    echo -e "${YELLOW}  .envrc backed up to .envrc.backup${NC}"

    if [ -f "$ENVRC_TEMPLATE" ]; then
        cp "$ENVRC_TEMPLATE" "$ENVRC_TARGET"
        echo -e "${GREEN}  ✓ .envrc overwritten from template${NC}"
    fi
elif [ -f "$ENVRC_TEMPLATE" ]; then
    cp "$ENVRC_TEMPLATE" "$ENVRC_TARGET"
    echo -e "${GREEN}  ✓ .envrc created from template${NC}"
else
    # Create default .envrc if template doesn't exist
    cat > "$ENVRC_TARGET" << 'ENVRC'
# Aura Frog - Environment Configuration
# Generated by setup.sh

# ============================================
# JIRA Integration
# ============================================
export JIRA_URL=""
export JIRA_EMAIL=""
export JIRA_API_TOKEN=""

# ============================================
# Figma Integration
# ============================================
export FIGMA_API_TOKEN=""

# ============================================
# Slack Integration (Optional)
# ============================================
export SLACK_WEBHOOK_URL=""

# ============================================
# Confluence Integration (Optional)
# ============================================
export CONFLUENCE_URL=""
export CONFLUENCE_EMAIL=""
export CONFLUENCE_API_TOKEN=""

# ============================================
# ElevenLabs Voice (Optional)
# ============================================
export ELEVENLABS_API_KEY=""
export ELEVENLABS_VOICE_ID="21m00Tcm4TlvDq8ikWAM"
ENVRC
    echo -e "${GREEN}  ✓ .envrc created with default template${NC}"
fi

# Configure JIRA
echo ""
echo -e "${BLUE}[3/4] Configuring JIRA integration...${NC}"
echo ""
echo -e "${CYAN}JIRA API Token can be created at:${NC}"
echo -e "  https://id.atlassian.com/manage-profile/security/api-tokens"
echo ""

read -p "Enter JIRA URL (e.g., https://company.atlassian.net) [skip]: " JIRA_URL_INPUT
if [ -n "$JIRA_URL_INPUT" ]; then
    read -p "Enter JIRA Email: " JIRA_EMAIL_INPUT
    read -p "Enter JIRA API Token: " -s JIRA_API_TOKEN_INPUT
    echo ""

    # Update .envrc with JIRA credentials (handle both commented and uncommented formats)
    # First try to uncomment and replace, then try to replace empty values
    sed -i.bak "s|# export JIRA_URL=.*|export JIRA_URL=\"$JIRA_URL_INPUT\"|" "$ENVRC_TARGET"
    sed -i.bak "s|# export JIRA_EMAIL=.*|export JIRA_EMAIL=\"$JIRA_EMAIL_INPUT\"|" "$ENVRC_TARGET"
    sed -i.bak "s|# export JIRA_API_TOKEN=.*|export JIRA_API_TOKEN=\"$JIRA_API_TOKEN_INPUT\"|" "$ENVRC_TARGET"
    # Also handle already uncommented empty values
    sed -i.bak "s|export JIRA_URL=\"\"|export JIRA_URL=\"$JIRA_URL_INPUT\"|" "$ENVRC_TARGET"
    sed -i.bak "s|export JIRA_EMAIL=\"\"|export JIRA_EMAIL=\"$JIRA_EMAIL_INPUT\"|" "$ENVRC_TARGET"
    sed -i.bak "s|export JIRA_API_TOKEN=\"\"|export JIRA_API_TOKEN=\"$JIRA_API_TOKEN_INPUT\"|" "$ENVRC_TARGET"
    rm -f "$ENVRC_TARGET.bak"

    echo -e "${GREEN}  ✓ JIRA configured${NC}"

    # Auto-configure Confluence with JIRA credentials (same Atlassian account)
    CONFLUENCE_URL_DEFAULT="${JIRA_URL_INPUT}/wiki"
    sed -i.bak "s|# export CONFLUENCE_URL=.*|export CONFLUENCE_URL=\"$CONFLUENCE_URL_DEFAULT\"|" "$ENVRC_TARGET"
    sed -i.bak "s|# export CONFLUENCE_EMAIL=.*|export CONFLUENCE_EMAIL=\"$JIRA_EMAIL_INPUT\"|" "$ENVRC_TARGET"
    sed -i.bak "s|# export CONFLUENCE_API_TOKEN=.*|export CONFLUENCE_API_TOKEN=\"$JIRA_API_TOKEN_INPUT\"|" "$ENVRC_TARGET"
    rm -f "$ENVRC_TARGET.bak"
    echo -e "${GREEN}  ✓ Confluence auto-configured (using JIRA credentials)${NC}"
else
    echo -e "${YELLOW}  ⊘ JIRA skipped${NC}"
fi

# Configure Figma
echo ""
echo -e "${BLUE}[4/4] Configuring Figma integration...${NC}"
echo ""
echo -e "${CYAN}Figma Access Token can be created at:${NC}"
echo -e "  https://www.figma.com/developers/api#access-tokens"
echo ""

read -p "Enter Figma Access Token [skip]: " -s FIGMA_TOKEN_INPUT
echo ""

if [ -n "$FIGMA_TOKEN_INPUT" ]; then
    # Update .envrc with Figma token (handle both commented and uncommented formats)
    sed -i.bak "s|# export FIGMA_API_TOKEN=.*|export FIGMA_API_TOKEN=\"$FIGMA_TOKEN_INPUT\"|" "$ENVRC_TARGET"
    sed -i.bak "s|export FIGMA_API_TOKEN=\"\"|export FIGMA_API_TOKEN=\"$FIGMA_TOKEN_INPUT\"|" "$ENVRC_TARGET"
    rm -f "$ENVRC_TARGET.bak"

    echo -e "${GREEN}  ✓ Figma configured${NC}"
else
    echo -e "${YELLOW}  ⊘ Figma skipped${NC}"
fi

# Add .cursor/.envrc to .gitignore if not already there
GITIGNORE="$TARGET_PROJECT/.gitignore"
if [ -f "$GITIGNORE" ]; then
    if ! grep -q "^\.cursor/\.envrc$" "$GITIGNORE"; then
        echo "" >> "$GITIGNORE"
        echo "# Aura Frog environment (contains secrets)" >> "$GITIGNORE"
        echo ".cursor/.envrc" >> "$GITIGNORE"
        echo -e "${GREEN}  ✓ Added .cursor/.envrc to .gitignore${NC}"
    fi
else
    echo "# Aura Frog environment (contains secrets)" > "$GITIGNORE"
    echo ".cursor/.envrc" >> "$GITIGNORE"
    echo -e "${GREEN}  ✓ Created .gitignore with .cursor/.envrc${NC}"
fi

# Summary
echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}${BOLD}  ✓ Aura Frog installed successfully!${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${BOLD}Installed to:${NC} $TARGET_PROJECT/.cursor"
echo ""
echo -e "${BOLD}Files created:${NC}"
echo "  - .cursor/          (Aura Frog rules, commands, agents)"
echo "  - .cursor/.envrc    (Environment configuration)"
echo ""
echo -e "${BOLD}Next steps:${NC}"
echo "  1. Open your project in Cursor IDE"
echo "  2. Load environment: ${CYAN}source .cursor/.envrc${NC}"
echo "  3. Initialize project: ${CYAN}/project:init${NC}"
echo "  4. Start workflow: ${CYAN}/workflow:start \"Your task\"${NC}"
echo ""
echo -e "${BOLD}Documentation:${NC}"
echo "  - Quick Start: ${CYAN}cat .cursor/GET_STARTED.md${NC}"
echo "  - Commands: ${CYAN}cat .cursor/commands/QUICK_REFERENCE.md${NC}"
echo ""
echo -e "${YELLOW}Note: Run 'source .cursor/.envrc' to load environment variables.${NC}"
echo -e "${YELLOW}      Or use direnv for automatic loading.${NC}"
echo ""
echo -e "🐸 ${GREEN}Code with main character energy!${NC}"
echo ""
