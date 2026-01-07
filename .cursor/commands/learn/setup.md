# /learn:setup

**Category:** Learning
**Purpose:** Set up the Supabase learning system database schema

---

## Usage

```bash
/learn:setup           # Interactive setup
/learn:setup --check   # Check if schema exists
```

---

## CRITICAL: Cursor MUST Execute

When user runs `/learn:setup`, Cursor **MUST actually run the setup script or verify schema**.

**DO NOT** just show instructions. **DO** check if schema exists and run setup if needed.

```bash
# ALWAYS source env first
source .envrc 2>/dev/null || source .cursor/.envrc 2>/dev/null || true
```

---

## Setup Flow

### Step 1: Check Environment Variables

```bash
echo "Checking environment..."
echo "SUPABASE_URL: ${SUPABASE_URL:+✓ set}"
echo "SUPABASE_SECRET_KEY: ${SUPABASE_SECRET_KEY:+✓ set}"
```

If either is missing, tell user to:
1. Copy `.envrc.template` to `.envrc`
2. Set the Supabase credentials
3. Run `source .envrc`

### Step 2: Check if Schema Already Exists

```bash
# Test if af_feedback table exists
response=$(curl -s -w "%{http_code}" -o /tmp/schema_check.json \
  "${SUPABASE_URL}/rest/v1/af_feedback?limit=1" \
  -H "apikey: ${SUPABASE_SECRET_KEY}" \
  -H "Authorization: Bearer ${SUPABASE_SECRET_KEY}")

if [ "$response" = "200" ]; then
  echo "✅ Schema already exists"
  exit 0
fi
```

### Step 3: Run Schema SQL

Copy and paste `scripts/supabase/schema.sql` into Supabase SQL Editor.

---

## Tables Created

| Table | Purpose |
|-------|---------|
| `af_feedback` | User corrections, approvals, ratings |
| `af_workflow_metrics` | Workflow execution data |
| `af_agent_performance` | Agent success tracking |
| `af_learned_patterns` | Identified patterns |
| `af_knowledge_base` | Persistent learnings |

## Views Created

| View | Purpose |
|------|---------|
| `v_agent_success_rates` | Agent performance by task |
| `v_common_patterns` | Pattern summary |
| `v_improvement_suggestions` | Actionable suggestions |

---

## Troubleshooting

### "Permission denied"

- Verify `SUPABASE_SECRET_KEY` is the **Secret** key (not Publishable)
- Check RLS policies allow service role access

### "Table already exists"

Safe to ignore - the schema uses `CREATE TABLE IF NOT EXISTS`.

---

## Related Commands

- `/learn:status` - Check learning system status
- `/learn:analyze` - Run pattern analysis
- `/learn:apply` - Apply improvements

---

**Version:** 1.0.0
