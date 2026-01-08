#!/bin/bash
#
# Aura Frog - Memory Loader
#
# Loads learned patterns from Supabase and caches locally.
# Cursor reads the cached file to apply learned insights.
#
# Usage:
#   ./scripts/learn/memory-load.sh          # Load/refresh memory
#   ./scripts/learn/memory-load.sh --force  # Force refresh (bypass cache)
#   ./scripts/learn/memory-load.sh --status # Show cache status
#
# Version: 1.6.0

set -e

# Load environment
source .envrc 2>/dev/null || source .cursor/.envrc 2>/dev/null || true

# Configuration
CACHE_DIR=".cursor/cache"
CACHE_FILE="${CACHE_DIR}/memory-context.md"
CACHE_MAX_AGE=3600  # 1 hour in seconds

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Ensure cache directory exists
mkdir -p "$CACHE_DIR"

# Check if learning is enabled
check_config() {
  if [[ "$AF_LEARNING_ENABLED" != "true" ]]; then
    echo -e "${YELLOW}⚠️  Learning system not enabled${NC}"
    echo "Set AF_LEARNING_ENABLED=true in .envrc"
    exit 0
  fi

  if [[ -z "$SUPABASE_URL" || -z "$SUPABASE_SECRET_KEY" ]]; then
    echo -e "${RED}❌ Missing Supabase credentials${NC}"
    echo "Set SUPABASE_URL and SUPABASE_SECRET_KEY in .envrc"
    exit 1
  fi
}

# Check if cache is fresh
is_cache_fresh() {
  if [[ ! -f "$CACHE_FILE" ]]; then
    return 1
  fi

  local now=$(date +%s)
  local modified=$(stat -f %m "$CACHE_FILE" 2>/dev/null || stat -c %Y "$CACHE_FILE" 2>/dev/null)
  local age=$((now - modified))

  if [[ $age -lt $CACHE_MAX_AGE ]]; then
    return 0
  fi
  return 1
}

# Show cache status
show_status() {
  if [[ -f "$CACHE_FILE" ]]; then
    local now=$(date +%s)
    local modified=$(stat -f %m "$CACHE_FILE" 2>/dev/null || stat -c %Y "$CACHE_FILE" 2>/dev/null)
    local age=$((now - modified))
    local items=$(grep -c "^- " "$CACHE_FILE" 2>/dev/null || echo 0)

    echo "📁 Cache: $CACHE_FILE"
    echo "📊 Items: $items"
    echo "⏰ Age: ${age}s (max: ${CACHE_MAX_AGE}s)"

    if [[ $age -lt $CACHE_MAX_AGE ]]; then
      echo -e "${GREEN}✓ Cache is fresh${NC}"
    else
      echo -e "${YELLOW}⚠ Cache is stale${NC}"
    fi
  else
    echo -e "${YELLOW}⚠ No cache file exists${NC}"
  fi
}

# Query Supabase endpoint
query_supabase() {
  local endpoint="$1"

  curl -s \
    "${SUPABASE_URL}/rest/v1/${endpoint}" \
    -H "apikey: ${SUPABASE_SECRET_KEY}" \
    -H "Authorization: Bearer ${SUPABASE_SECRET_KEY}" \
    -H "Content-Type: application/json" \
    --connect-timeout 5 \
    --max-time 10
}

# Load memory from Supabase
load_memory() {
  local force="${1:-false}"

  # Check cache unless forced
  if [[ "$force" != "true" ]] && is_cache_fresh; then
    local items=$(grep -c "^- " "$CACHE_FILE" 2>/dev/null || echo 0)
    echo -e "${GREEN}✓ Using cached memory (${items} items)${NC}"
    return 0
  fi

  echo "🔄 Loading memory from Supabase..."

  # Build memory content
  local content="# Loaded Memory Context\n\n"
  content+="_Loaded: $(date '+%Y-%m-%d %H:%M:%S')_\n\n"

  # Load learned patterns (high confidence, active)
  local patterns=$(query_supabase "af_learned_patterns?status=eq.active&confidence=gte.70&order=confidence.desc&limit=20")

  if [[ -n "$patterns" && "$patterns" != "[]" ]]; then
    content+="## Learned Patterns\n\n"

    # Parse JSON and format
    echo "$patterns" | jq -r '.[] | "- **\(.pattern_type)**: \(.description // "No description") (\(.confidence)% confidence)\n  → \(.recommendation // "No recommendation")"' 2>/dev/null >> /tmp/patterns.txt || true

    if [[ -s /tmp/patterns.txt ]]; then
      content+=$(cat /tmp/patterns.txt)
      content+="\n\n"
    fi
    rm -f /tmp/patterns.txt
  fi

  # Load agent stats
  local agents=$(query_supabase "v_agent_success_rates?limit=10")

  if [[ -n "$agents" && "$agents" != "[]" ]]; then
    content+="## Agent Performance\n\n"

    echo "$agents" | jq -r '.[] | "- \(.agent_name // "unknown"): \((.success_rate // 0) * 100 | floor)% success (\(.total_tasks // 0) tasks)"' 2>/dev/null >> /tmp/agents.txt || true

    if [[ -s /tmp/agents.txt ]]; then
      content+=$(cat /tmp/agents.txt)
      content+="\n\n"
    fi
    rm -f /tmp/agents.txt
  fi

  # Load recent corrections
  local thirty_days_ago=$(date -v-30d '+%Y-%m-%dT00:00:00' 2>/dev/null || date -d "30 days ago" '+%Y-%m-%dT00:00:00')
  local corrections=$(query_supabase "af_feedback?type=eq.correction&created_at=gte.${thirty_days_ago}&order=created_at.desc&limit=10")

  if [[ -n "$corrections" && "$corrections" != "[]" ]]; then
    content+="## Recent Corrections (Avoid These)\n\n"

    echo "$corrections" | jq -r '.[] | select(.context != null) | "- \(.context)"' 2>/dev/null >> /tmp/corrections.txt || true

    if [[ -s /tmp/corrections.txt ]]; then
      content+=$(cat /tmp/corrections.txt)
      content+="\n\n"
    fi
    rm -f /tmp/corrections.txt
  fi

  # Load recent insights
  local seven_days_ago=$(date -v-7d '+%Y-%m-%dT00:00:00' 2>/dev/null || date -d "7 days ago" '+%Y-%m-%dT00:00:00')
  local insights=$(query_supabase "af_knowledge_base?created_at=gte.${seven_days_ago}&order=created_at.desc&limit=10")

  if [[ -n "$insights" && "$insights" != "[]" ]]; then
    content+="## Recent Insights\n\n"

    echo "$insights" | jq -r '.[] | "- \(.insight // .content // "No content")"' 2>/dev/null >> /tmp/insights.txt || true

    if [[ -s /tmp/insights.txt ]]; then
      content+=$(cat /tmp/insights.txt)
      content+="\n"
    fi
    rm -f /tmp/insights.txt
  fi

  # Write cache file
  echo -e "$content" > "$CACHE_FILE"

  local items=$(grep -c "^- " "$CACHE_FILE" 2>/dev/null || echo 0)
  echo -e "${GREEN}✓ Memory loaded: ${items} items cached to ${CACHE_FILE}${NC}"
}

# Main
case "${1:-}" in
  --status)
    check_config
    show_status
    ;;
  --force)
    check_config
    load_memory true
    ;;
  --help)
    echo "Usage: ./scripts/learn/memory-load.sh [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --status  Show cache status"
    echo "  --force   Force refresh (bypass cache)"
    echo "  --help    Show this help"
    ;;
  *)
    check_config
    load_memory
    ;;
esac
