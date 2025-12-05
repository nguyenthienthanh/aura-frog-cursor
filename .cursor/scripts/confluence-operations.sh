#!/bin/bash
# Confluence Operations Script for Aura Frog (Cursor Version)
# Usage: ./confluence-operations.sh <command> [options]
# Commands: fetch, search, create, update
# Version: 1.0.0

set -e

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Log directory
if [ -d ".cursor/logs" ]; then
  LOG_DIR=".cursor/logs/confluence"
else
  LOG_DIR="${SCRIPT_DIR}/../logs/confluence"
fi

mkdir -p "$LOG_DIR"
LOG_FILE="${LOG_DIR}/confluence-$(date +%Y%m%d-%H%M%S).log"

# Logging function
log() {
  local level="$1"
  local message="$2"
  local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  echo "[$timestamp] [$level] $message" >> "$LOG_FILE"
  if [ "$level" = "ERROR" ]; then
    echo "Error: $message" >&2
  fi
}

# Source envrc files
source_envrc() {
  local file="$1"
  if [ -f "$file" ]; then
    log "INFO" "Found $file, attempting to load..."
    set +e
    while IFS= read -r line; do
      [[ "$line" =~ ^[[:space:]]*# ]] && continue
      [[ -z "$line" ]] && continue
      if [[ "$line" =~ ^[[:space:]]*export[[:space:]] ]]; then
        eval "$line" 2>/dev/null
      fi
    done < "$file"
    set -e
    return 0
  fi
  return 1
}

# Load environment variables
load_env() {
  local ENVRC_LOADED=false

  if [ -n "$CONFLUENCE_URL" ] && [ -n "$CONFLUENCE_EMAIL" ] && [ -n "$CONFLUENCE_API_TOKEN" ]; then
    log "INFO" "Confluence credentials already set in environment"
    ENVRC_LOADED=true
  fi

  if [ "$ENVRC_LOADED" = false ]; then
    if source_envrc ".cursor/.envrc"; then
      log "INFO" "Loaded from .cursor/.envrc"
      ENVRC_LOADED=true
    elif source_envrc ".envrc"; then
      log "INFO" "Loaded from current directory .envrc"
      ENVRC_LOADED=true
    elif source_envrc "$HOME/.envrc"; then
      log "INFO" "Loaded from home directory .envrc"
      ENVRC_LOADED=true
    fi
  fi

  if [ "$ENVRC_LOADED" = false ]; then
    log "ERROR" ".envrc not found in any location"
    echo "Error: .envrc not found"
    echo ""
    echo "Searched locations:"
    echo "  1. .cursor/.envrc"
    echo "  2. Current directory (.envrc)"
    echo "  3. Home directory (~/.envrc)"
    exit 1
  fi

  # Check required variables - fallback to JIRA credentials
  if [ -z "$CONFLUENCE_URL" ] && [ -n "$JIRA_URL" ]; then
    CONFLUENCE_URL="${JIRA_URL}/wiki"
    log "INFO" "Using JIRA_URL for Confluence: $CONFLUENCE_URL"
  fi
  if [ -z "$CONFLUENCE_EMAIL" ] && [ -n "$JIRA_EMAIL" ]; then
    CONFLUENCE_EMAIL="$JIRA_EMAIL"
    log "INFO" "Using JIRA_EMAIL for Confluence"
  fi
  if [ -z "$CONFLUENCE_API_TOKEN" ] && [ -n "$JIRA_API_TOKEN" ]; then
    CONFLUENCE_API_TOKEN="$JIRA_API_TOKEN"
    log "INFO" "Using JIRA_API_TOKEN for Confluence"
  fi

  if [ -z "$CONFLUENCE_URL" ] || [ -z "$CONFLUENCE_EMAIL" ] || [ -z "$CONFLUENCE_API_TOKEN" ]; then
    log "ERROR" "Confluence environment variables not set"
    echo "Error: Confluence environment variables not set"
    echo ""
    echo "Required variables in .cursor/.envrc:"
    echo "  - CONFLUENCE_URL (e.g., https://your-domain.atlassian.net/wiki)"
    echo "  - CONFLUENCE_EMAIL (your email)"
    echo "  - CONFLUENCE_API_TOKEN (API token from Atlassian)"
    echo ""
    echo "Or use JIRA credentials (same Atlassian account):"
    echo "  - JIRA_URL, JIRA_EMAIL, JIRA_API_TOKEN"
    exit 1
  fi

  log "INFO" "Confluence credentials loaded successfully"
}

# URL encode function
urlencode() {
  local string="$1"
  python3 -c "import urllib.parse; print(urllib.parse.quote('$string', safe=''))"
}

# FETCH COMMAND
cmd_fetch() {
  local page_id="$1"
  local space_key="$2"

  if [ -z "$page_id" ]; then
    echo "Error: Page ID or title required"
    echo "Usage: $0 fetch <page-id> [space-key]"
    exit 1
  fi

  echo "Fetching Confluence page..."
  log "INFO" "Fetching page: $page_id"

  local api_url
  if [[ "$page_id" =~ ^[0-9]+$ ]]; then
    api_url="${CONFLUENCE_URL}/rest/api/content/${page_id}?expand=body.storage,version,space"
  else
    if [ -z "$space_key" ]; then
      echo "Error: Space key required when fetching by title"
      exit 1
    fi
    local encoded_title=$(urlencode "$page_id")
    api_url="${CONFLUENCE_URL}/rest/api/content?spaceKey=${space_key}&title=${encoded_title}&expand=body.storage,version,space"
  fi

  local response=$(curl -s -w "\n%{http_code}" \
    -u "${CONFLUENCE_EMAIL}:${CONFLUENCE_API_TOKEN}" \
    -H "Accept: application/json" \
    "$api_url")

  local http_code=$(echo "$response" | tail -n1)
  local body=$(echo "$response" | sed '$d')

  if [ "$http_code" != "200" ]; then
    echo "Error: HTTP $http_code"
    echo "$body" | jq -r '.message // .' 2>/dev/null || echo "$body"
    exit 1
  fi

  if [[ ! "$page_id" =~ ^[0-9]+$ ]]; then
    local result_count=$(echo "$body" | jq '.results | length')
    if [ "$result_count" = "0" ]; then
      echo "Page not found: $page_id in space $space_key"
      exit 1
    fi
    body=$(echo "$body" | jq '.results[0]')
  fi

  local title=$(echo "$body" | jq -r '.title')
  local space=$(echo "$body" | jq -r '.space.key')
  local version=$(echo "$body" | jq -r '.version.number')
  local page_id_result=$(echo "$body" | jq -r '.id')
  local page_url="${CONFLUENCE_URL}/pages/viewpage.action?pageId=${page_id_result}"

  echo ""
  echo "CONFLUENCE PAGE"
  echo "==============="
  echo "Title:    $title"
  echo "Page ID:  $page_id_result"
  echo "Space:    $space"
  echo "Version:  $version"
  echo "URL:      $page_url"
  echo ""

  log "INFO" "Page fetched successfully: $title (ID: $page_id_result)"
}

# SEARCH COMMAND
cmd_search() {
  local query="$1"
  local space_key="$2"
  local limit="${3:-10}"

  if [ -z "$query" ]; then
    echo "Error: Search query required"
    echo "Usage: $0 search <query> [space-key] [limit]"
    exit 1
  fi

  echo "Searching Confluence..."
  log "INFO" "Searching: $query"

  local cql
  if [ -n "$space_key" ]; then
    cql="space = ${space_key} AND text ~ \"${query}\""
  else
    cql="text ~ \"${query}\""
  fi

  local encoded_cql=$(urlencode "$cql")
  local api_url="${CONFLUENCE_URL}/rest/api/content/search?cql=${encoded_cql}&limit=${limit}"

  local response=$(curl -s -w "\n%{http_code}" \
    -u "${CONFLUENCE_EMAIL}:${CONFLUENCE_API_TOKEN}" \
    -H "Accept: application/json" \
    "$api_url")

  local http_code=$(echo "$response" | tail -n1)
  local body=$(echo "$response" | sed '$d')

  if [ "$http_code" != "200" ]; then
    echo "Error: HTTP $http_code"
    exit 1
  fi

  local result_count=$(echo "$body" | jq '.results | length')

  echo ""
  echo "SEARCH RESULTS"
  echo "=============="
  echo "Query: $query"
  echo "Found: $result_count results"
  echo ""

  if [ "$result_count" = "0" ]; then
    echo "No results found."
    exit 0
  fi

  echo "$body" | jq -r '.results[] | "  \(.title)\n     ID: \(.id) | Space: \(.space.key // "N/A")\n"'

  log "INFO" "Search completed: $result_count results"
}

# HELP
show_help() {
  cat <<EOF
CONFLUENCE OPERATIONS - Aura Frog (Cursor)
===========================================

Usage: $0 <command> [options]

Commands:
  fetch   <page-id|title> [space]    Fetch a page by ID or title
  search  <query> [space] [limit]    Search for pages
  help                               Show this help

Examples:
  $0 fetch 123456
  $0 fetch 'API Documentation' DEV
  $0 search 'deployment guide'
  $0 search 'release notes' PROJ 20

Environment Variables (in .cursor/.envrc):
  CONFLUENCE_URL         Base URL (e.g., https://company.atlassian.net/wiki)
  CONFLUENCE_EMAIL       Your Atlassian email
  CONFLUENCE_API_TOKEN   API token from Atlassian

  Or use JIRA credentials (same Atlassian account):
  JIRA_URL, JIRA_EMAIL, JIRA_API_TOKEN
EOF
}

# MAIN
COMMAND="${1:-help}"
shift 2>/dev/null || true

log "INFO" "=== Confluence Operations Started ==="
log "INFO" "Command: $COMMAND"

case "$COMMAND" in
  fetch)
    load_env
    cmd_fetch "$@"
    ;;
  search)
    load_env
    cmd_search "$@"
    ;;
  help|--help|-h)
    show_help
    ;;
  *)
    echo "Unknown command: $COMMAND"
    show_help
    exit 1
    ;;
esac

log "INFO" "=== Confluence Operations Completed ==="
