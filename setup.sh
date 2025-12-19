#!/bin/bash

# Aura Frog for Cursor IDE - Setup Script
# Version: 1.1.9
#
# This script installs Aura Frog to your project by copying
# the .cursor folder. MCP servers handle all integrations.

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'
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
            echo "  -f, --force    Force override existing .cursor folder"
            echo "  -h, --help     Show this help message"
            echo ""
            echo "Examples:"
            echo "  $0 /path/to/project"
            echo "  $0 --force /path/to/project"
            exit 0
            ;;
        *)
            TARGET_ARG="$1"
            shift
            ;;
    esac
done

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CURSOR_SOURCE="$SCRIPT_DIR/.cursor"

# Banner
echo -e "${CYAN}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🐸 AURA FROG for Cursor IDE - Setup v1.1.9"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${NC}"

# Check source exists
if [ ! -d "$CURSOR_SOURCE" ]; then
    echo -e "${RED}Error: .cursor folder not found at $CURSOR_SOURCE${NC}"
    exit 1
fi

# Get target path
if [ -n "$TARGET_ARG" ]; then
    TARGET_PROJECT="$TARGET_ARG"
else
    echo -e "${YELLOW}Enter the path to your target project:${NC}"
    read -r TARGET_PROJECT
fi

# Expand and validate path
TARGET_PROJECT="${TARGET_PROJECT/#\~/$HOME}"
TARGET_PROJECT="$(cd "$TARGET_PROJECT" 2>/dev/null && pwd)" || {
    echo -e "${RED}Error: Invalid path '$TARGET_PROJECT'${NC}"
    exit 1
}

echo ""
echo -e "${BLUE}Target:${NC} $TARGET_PROJECT"
echo ""

# Confirm
if [ -d "$TARGET_PROJECT/.cursor" ] && [ "$FORCE_OVERRIDE" = false ]; then
    echo -e "${YELLOW}Existing .cursor folder found. Will merge files.${NC}"
else
    echo -e "${GREEN}Will copy .cursor folder to target.${NC}"
fi
echo ""
read -p "Continue? (y/N): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}Cancelled.${NC}"
    exit 0
fi

# Step 1: Copy .cursor folder
echo ""
echo -e "${BLUE}[1/3] Copying .cursor folder...${NC}"

if [ -d "$TARGET_PROJECT/.cursor" ]; then
    if [ "$FORCE_OVERRIDE" = true ]; then
        rm -rf "$TARGET_PROJECT/.cursor"
        cp -r "$CURSOR_SOURCE" "$TARGET_PROJECT/.cursor"
        echo -e "${GREEN}  ✓ .cursor folder replaced${NC}"
    else
        # Merge: copy new files only
        rsync -a --ignore-existing "$CURSOR_SOURCE/" "$TARGET_PROJECT/.cursor/"
        echo -e "${GREEN}  ✓ .cursor folder merged${NC}"
    fi
else
    cp -r "$CURSOR_SOURCE" "$TARGET_PROJECT/.cursor"
    echo -e "${GREEN}  ✓ .cursor folder created${NC}"
fi

# Copy .cursorrules if exists
if [ -f "$SCRIPT_DIR/.cursorrules" ]; then
    if [ ! -f "$TARGET_PROJECT/.cursorrules" ] || [ "$FORCE_OVERRIDE" = true ]; then
        cp "$SCRIPT_DIR/.cursorrules" "$TARGET_PROJECT/.cursorrules"
        echo -e "${GREEN}  ✓ .cursorrules copied${NC}"
    fi
fi

# Step 2: Setup .envrc
echo ""
echo -e "${BLUE}[2/3] Setting up environment...${NC}"

ENVRC_TEMPLATE="$TARGET_PROJECT/.cursor/.envrc.template"
ENVRC_TARGET="$TARGET_PROJECT/.envrc"

if [ ! -f "$ENVRC_TARGET" ]; then
    if [ -f "$ENVRC_TEMPLATE" ]; then
        cp "$ENVRC_TEMPLATE" "$ENVRC_TARGET"
        echo -e "${GREEN}  ✓ .envrc created from template${NC}"
    fi
else
    echo -e "${YELLOW}  .envrc exists, skipping${NC}"
fi

# Step 3: Update .gitignore
echo ""
echo -e "${BLUE}[3/3] Updating .gitignore...${NC}"

GITIGNORE="$TARGET_PROJECT/.gitignore"
ENTRIES=(".envrc" ".cursor/logs/" ".cursor/.envrc")

for entry in "${ENTRIES[@]}"; do
    if [ -f "$GITIGNORE" ]; then
        if ! grep -qF "$entry" "$GITIGNORE"; then
            echo "$entry" >> "$GITIGNORE"
        fi
    else
        echo "$entry" >> "$GITIGNORE"
    fi
done
echo -e "${GREEN}  ✓ .gitignore updated${NC}"

# Summary
echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}${BOLD}  ✓ Aura Frog installed!${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${BOLD}Installed:${NC} $TARGET_PROJECT/.cursor"
echo ""
echo -e "${BOLD}MCP Servers (auto-install on first use):${NC}"
echo "  ✓ context7     - Library docs"
echo "  ✓ playwright   - E2E testing"
echo "  ✓ filesystem   - File operations"
echo "  ✓ memory       - Persistent context"
echo "  ○ github       - Git/GitHub (needs GITHUB_TOKEN)"
echo "  ○ vitest       - Unit testing"
echo "  ○ atlassian    - JIRA/Confluence (needs credentials)"
echo "  ○ figma        - Design tokens (needs FIGMA_API_KEY)"
echo "  ○ slack        - Notifications (needs SLACK_BOT_TOKEN)"
echo ""
echo -e "${BOLD}To enable optional MCP servers:${NC}"
echo "  1. Edit ${CYAN}.envrc${NC} - add your API credentials"
echo "  2. Edit ${CYAN}.cursor/mcp.json${NC} - set \"disabled\": false"
echo "  3. Restart Cursor"
echo ""
echo -e "${BOLD}Quick Start:${NC}"
echo "  - Docs: ${CYAN}cat .cursor/GET_STARTED.md${NC}"
echo "  - Commands: ${CYAN}cat .cursor/commands/QUICK_REFERENCE.md${NC}"
echo ""
echo -e "🐸 ${GREEN}Ready to code!${NC}"
echo ""
