# /learn:analyze

**Category:** Learning
**Purpose:** Analyze collected data and generate improvement insights

---

## Usage

```bash
/learn:analyze                      # Full analysis
/learn:analyze --period 30d         # Last 30 days
/learn:analyze --focus agents       # Agent performance focus
/learn:analyze --focus workflows    # Workflow patterns focus
/learn:analyze --focus feedback     # User feedback focus
```

---

## CRITICAL: Cursor MUST Execute

When user runs `/learn:analyze`, Cursor **MUST actually fetch and analyze real data from Supabase**.

**DO NOT** just show example analysis. **DO** run the curl commands, read the JSON, and analyze REAL data.

```bash
# ALWAYS source env first
source .envrc 2>/dev/null || source .cursor/.envrc 2>/dev/null || true
```

---

## Execution Steps

When user runs `/learn:analyze`, Cursor should:

### Step 1: Verify Connection

Check that learning system is configured:

```bash
if [ -z "$SUPABASE_URL" ] || [ -z "$SUPABASE_SECRET_KEY" ]; then
  echo "❌ Learning system not configured"
  echo "Set SUPABASE_URL and SUPABASE_SECRET_KEY in .envrc"
  exit 1
fi
```

### Step 2: Fetch Data from Supabase

Query all the learning views:

```bash
# Agent success rates
curl -s "${SUPABASE_URL}/rest/v1/v_agent_success_rates" \
  -H "apikey: ${SUPABASE_SECRET_KEY}" \
  -H "Authorization: Bearer ${SUPABASE_SECRET_KEY}" > /tmp/agent_rates.json

# Existing patterns
curl -s "${SUPABASE_URL}/rest/v1/v_common_patterns" \
  -H "apikey: ${SUPABASE_SECRET_KEY}" \
  -H "Authorization: Bearer ${SUPABASE_SECRET_KEY}" > /tmp/patterns.json
```

### Step 3: Analyze and Generate Insights

Based on the data, identify:

1. **Success Patterns** - What's working well?
2. **Failure Patterns** - What's causing issues?
3. **Optimization Opportunities** - Where can we improve?
4. **Recommendations** - Actionable suggestions

### Step 4: Save New Patterns to Supabase

```bash
curl -X POST "${SUPABASE_URL}/rest/v1/af_learned_patterns" \
  -H "apikey: ${SUPABASE_SECRET_KEY}" \
  -H "Authorization: Bearer ${SUPABASE_SECRET_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "pattern_type": "success",
    "category": "agent",
    "description": "react-expert has 95% success rate for React component tasks",
    "confidence": 0.85,
    "suggested_action": "Route React component tasks to react-expert by default"
  }'
```

---

## Output Format

```markdown
## 🐸 Learning Analysis Report
Generated: 2026-01-07
Period: Last 30 days
Data Points: 123 workflows, 47 feedback items

---

### 📊 Key Metrics

| Metric | Value | Trend |
|--------|-------|-------|
| Workflow Success | 81.3% | ↑ 3.2% |
| Avg Token Usage | 45,200 | ↓ 12% |
| Feedback Ratio | 0.38/workflow | → stable |

---

### ✅ Success Patterns

**1. TDD workflow for Next.js projects**
- Confidence: 89%
- Frequency: 15 workflows
- Evidence: 95% test pass rate when full TDD used
- Recommendation: Continue enforcing TDD for Next.js

---

### ❌ Failure Patterns

**1. Phase 5a timeout on large test suites**
- Frequency: 8 workflows
- Impact: Workflow stall
- Root Cause: Default 180s timeout insufficient
- Fix: Increase timeout to 300s

---

### 🤖 Agent Recommendations

| Task Type | Current | Recommended | Expected Gain |
|-----------|---------|-------------|---------------|
| React UI | web-expert | react-expert | +18% success |
| API routes | general | nodejs-expert | +10% success |

---

💡 Apply improvements: `/learn:apply`
```

---

## Focus Modes

### `--focus agents`

- Success/failure rates by agent
- Task type suitability
- User override patterns
- Token efficiency by agent

### `--focus workflows`

- Phase duration distribution
- Auto-stop triggers
- Success by project type

### `--focus feedback`

- Correction patterns
- Approval/rejection reasons
- Common user overrides

---

**Version:** 1.0.0
