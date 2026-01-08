#!/bin/bash
#
# Aura Frog - Auto-Learn Submit
#
# Submits auto-detected feedback to Supabase.
# Called by Cursor when it detects correction/approval patterns.
#
# Usage:
#   ./scripts/learn/auto-learn-submit.sh \
#     --type "correction" \
#     --category "code_style" \
#     --rule "minimal_comments" \
#     --reason "User said: stop adding docstrings" \
#     --confidence 0.9
#
# Version: 1.7.0

set -e

# Load environment
source .envrc 2>/dev/null || source .cursor/.envrc 2>/dev/null || true

# Configuration
CACHE_DIR=".cursor/cache"
CACHE_FILE="${CACHE_DIR}/auto-learn-cache.json"
PATTERNS_FILE="${CACHE_DIR}/learned-patterns.md"
DEDUP_WINDOW=86400  # 24 hours in seconds
PATTERN_THRESHOLD=3

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Parse arguments
TYPE=""
CATEGORY=""
RULE=""
REASON=""
CONFIDENCE="0.7"

while [[ $# -gt 0 ]]; do
  case $1 in
    --type) TYPE="$2"; shift 2 ;;
    --category) CATEGORY="$2"; shift 2 ;;
    --rule) RULE="$2"; shift 2 ;;
    --reason) REASON="$2"; shift 2 ;;
    --confidence) CONFIDENCE="$2"; shift 2 ;;
    *) shift ;;
  esac
done

# Validate required fields
if [[ -z "$TYPE" || -z "$CATEGORY" || -z "$RULE" || -z "$REASON" ]]; then
  echo "Usage: $0 --type TYPE --category CATEGORY --rule RULE --reason REASON [--confidence CONFIDENCE]"
  exit 1
fi

# Check if learning is enabled
if [[ "$AF_LEARNING_ENABLED" != "true" ]]; then
  echo -e "${YELLOW}Learning disabled${NC}"
  exit 0
fi

if [[ -z "$SUPABASE_URL" || -z "$SUPABASE_SECRET_KEY" ]]; then
  echo -e "${YELLOW}Supabase not configured${NC}"
  exit 0
fi

# Ensure cache directory exists
mkdir -p "$CACHE_DIR"

# Generate hash for deduplication
generate_hash() {
  echo -n "$1" | tr '[:upper:]' '[:lower:]' | tr -s ' ' | head -c 200 | md5 | head -c 12
}

HASH=$(generate_hash "$REASON")

# Load or initialize cache
if [[ -f "$CACHE_FILE" ]]; then
  CACHE=$(cat "$CACHE_FILE")
else
  CACHE='{"entries":[],"patterns":{}}'
fi

# Check for duplicate (within 24 hours)
NOW=$(date +%s)
CUTOFF=$((NOW - DEDUP_WINDOW))

# Clean old entries and check for duplicate
DUPLICATE=$(echo "$CACHE" | jq -r --arg hash "$HASH" --argjson cutoff "$CUTOFF" '
  .entries = [.entries[] | select(.timestamp > ($cutoff * 1000))] |
  if [.entries[] | select(.hash == $hash)] | length > 0 then "true" else "false" end
')

if [[ "$DUPLICATE" == "true" ]]; then
  echo "Skipping duplicate feedback"
  exit 0
fi

# Get and increment pattern count
PATTERN_KEY="${CATEGORY}:${RULE}"
PATTERN_COUNT=$(echo "$CACHE" | jq -r --arg key "$PATTERN_KEY" '.patterns[$key] // 0')
PATTERN_COUNT=$((PATTERN_COUNT + 1))

# Update cache
TIMESTAMP=$((NOW * 1000))
CACHE=$(echo "$CACHE" | jq \
  --arg hash "$HASH" \
  --arg type "$TYPE" \
  --arg category "$CATEGORY" \
  --arg rule "$RULE" \
  --argjson timestamp "$TIMESTAMP" \
  --arg key "$PATTERN_KEY" \
  --argjson count "$PATTERN_COUNT" \
  --argjson cutoff "$((CUTOFF * 1000))" \
  '
  .entries = [.entries[] | select(.timestamp > $cutoff)] |
  .entries += [{hash: $hash, type: $type, category: $category, rule: $rule, timestamp: $timestamp}] |
  .entries = .entries[-100:] |
  .patterns[$key] = $count
')

echo "$CACHE" > "$CACHE_FILE"

# Submit to Supabase
PAYLOAD=$(jq -n \
  --arg session_id "${AF_SESSION_ID:-}" \
  --arg project_name "${PROJECT_NAME:-${AF_PROJECT_NAME:-}}" \
  --arg feedback_type "$TYPE" \
  --arg reason "$REASON" \
  --argjson rating "$([ "$TYPE" = "approval" ] && echo 5 || echo 3)" \
  --arg source "auto_detect" \
  --argjson confidence "$CONFIDENCE" \
  --arg category "$CATEGORY" \
  --arg rule "$RULE" \
  --arg hash "$HASH" \
  --argjson pattern_count "$PATTERN_COUNT" \
  '{
    session_id: $session_id,
    project_name: $project_name,
    feedback_type: $feedback_type,
    reason: $reason,
    rating: $rating,
    metadata: {
      source: $source,
      confidence: $confidence,
      category: $category,
      rule: $rule,
      hash: $hash,
      patternCount: $pattern_count
    }
  }'
)

# Submit feedback
curl -s \
  "${SUPABASE_URL}/rest/v1/af_feedback" \
  -H "apikey: ${SUPABASE_SECRET_KEY}" \
  -H "Authorization: Bearer ${SUPABASE_SECRET_KEY}" \
  -H "Content-Type: application/json" \
  -H "Prefer: return=minimal" \
  -d "$PAYLOAD" \
  --connect-timeout 5 \
  --max-time 10 > /dev/null 2>&1 || true

# Update local patterns file
update_patterns_file() {
  local content=""
  local marker="<!-- PATTERN:${CATEGORY}:${RULE} -->"
  local short_reason="${REASON:0:100}"

  if [[ -f "$PATTERNS_FILE" ]]; then
    content=$(cat "$PATTERNS_FILE")
  else
    content="# Learned Patterns

Auto-generated from user corrections. Updated: $(date -u +%Y-%m-%dT%H:%M:%SZ)

---

"
  fi

  if echo "$content" | grep -q "$marker"; then
    # Update existing pattern
    content=$(echo "$content" | sed "s|$marker.*|$marker\n## ${CATEGORY}: ${RULE}\n\n**Occurrences:** ${PATTERN_COUNT}\n**Latest:** ${short_reason}...\n\n---|")
  else
    # Add new pattern
    content="${content}${marker}
## ${CATEGORY}: ${RULE}

**Occurrences:** ${PATTERN_COUNT}
**Latest:** ${short_reason}...

---

"
  fi

  # Update timestamp
  content=$(echo "$content" | sed "s|Updated: .*|Updated: $(date -u +%Y-%m-%dT%H:%M:%SZ)|")

  echo "$content" > "$PATTERNS_FILE"
}

update_patterns_file

# Auto-create pattern if threshold reached
if [[ "$PATTERN_COUNT" -eq "$PATTERN_THRESHOLD" && "$TYPE" == "correction" ]]; then
  # Submit pattern to Supabase
  PATTERN_PAYLOAD=$(jq -n \
    --arg type "preference" \
    --arg category "$CATEGORY" \
    --arg description "User prefers: ${RULE} (auto-detected from ${PATTERN_COUNT} corrections)" \
    '{
      p_pattern_type: $type,
      p_category: $category,
      p_description: $description,
      p_evidence: []
    }'
  )

  curl -s \
    "${SUPABASE_URL}/rest/v1/rpc/update_pattern_frequency" \
    -H "apikey: ${SUPABASE_SECRET_KEY}" \
    -H "Authorization: Bearer ${SUPABASE_SECRET_KEY}" \
    -H "Content-Type: application/json" \
    -d "$PATTERN_PAYLOAD" \
    --connect-timeout 5 \
    --max-time 10 > /dev/null 2>&1 || true

  echo -e "${GREEN}🧠 Learning: Pattern detected! \"${CATEGORY}:${RULE}\" (${PATTERN_COUNT} occurrences)${NC}"
elif [[ "$TYPE" == "correction" ]]; then
  echo -e "${GREEN}🧠 Learning: Captured ${TYPE} [${CATEGORY}:${RULE}] (${PATTERN_COUNT}x)${NC}"
fi
