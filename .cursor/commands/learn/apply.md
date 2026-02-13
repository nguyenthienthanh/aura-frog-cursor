# /learn:apply

**Category:** Learning
**Purpose:** Apply learned improvements to the system

---

## Usage

```bash
/learn:apply                    # Interactive review and apply
/learn:apply --auto             # Auto-apply high-confidence (≥0.8)
/learn:apply --preview          # Preview without applying
/learn:apply --id <pattern_id>  # Apply specific improvement
```

---

## CRITICAL: Cursor MUST Execute

When user runs `/learn:apply`, Cursor **MUST actually query Supabase for pending improvements**.

**DO NOT** just show example suggestions. **DO** run the curl commands and show REAL pending improvements.

```bash
# ALWAYS source env first
source .envrc 2>/dev/null || source .cursor/.envrc 2>/dev/null || true
```

---

## Execution Steps

When user runs `/learn:apply`, Cursor should:

### Step 1: Fetch Pending Improvements

Query Supabase for unapplied suggestions:

```bash
curl -s "${SUPABASE_URL}/rest/v1/v_improvement_suggestions?applied=eq.false&order=confidence.desc" \
  -H "apikey: ${SUPABASE_SECRET_KEY}" \
  -H "Authorization: Bearer ${SUPABASE_SECRET_KEY}"
```

If empty array `[]`, report "No pending improvements".

### Step 2: Display Each Suggestion

For each suggestion:

```markdown
## Improvement 1/3: Route React to react-expert

**ID:** abc123
**Confidence:** 92% ████████████████████░░
**Frequency:** 28 occurrences
**Category:** agent

### Suggestion
Route .tsx files to react-expert by default

### Proposed Change
File: `.cursor/rules/agents/smart-agent-detector.mdc`

```diff
+ - extension: [.tsx, .jsx]
+   agent: react-expert
+   confidence: 90
```

**Action:** [a]pply | [s]kip | [q]uit
```

### Step 3: Apply Changes (if user approves)

1. **Create backup:**
```bash
mkdir -p backups
cp .cursor/rules/agents/smart-agent-detector.mdc "backups/smart-agent-detector.mdc.$(date +%Y%m%d)"
```

2. **Make the edit** using Edit tool

3. **Mark as applied in Supabase:**
```bash
curl -X PATCH "${SUPABASE_URL}/rest/v1/af_learned_patterns?id=eq.abc123" \
  -H "apikey: ${SUPABASE_SECRET_KEY}" \
  -H "Authorization: Bearer ${SUPABASE_SECRET_KEY}" \
  -H "Content-Type: application/json" \
  -d '{"applied": true, "applied_at": "2026-01-07T10:30:00Z"}'
```

4. **Confirm to user:**
```
✅ Applied: Route React to react-expert
   Backup: backups/smart-agent-detector.mdc.20260107
```

---

## Auto Mode (--auto)

Automatically applies improvements that meet ALL criteria:
- Confidence ≥ 0.8 (80%)
- Frequency ≥ 5 occurrences
- Not already applied
- Daily limit not exceeded (default: 10)

---

## Preview Mode (--preview)

Show what would be applied without making changes:

```markdown
## Preview: Pending Improvements

### Would Apply (high confidence)
1. Route React to react-expert (92%)
2. Increase Phase 5a timeout (85%)

### Would Skip (low confidence)
3. Add test batching (62%) - needs more data

**Total:** 2 would apply, 1 would skip
```

---

## Improvement Types & Target Files

| Category | Target File | Change Type |
|----------|-------------|-------------|
| `agent` | `.cursor/rules/agents/*.mdc` | Add routing rule |
| `workflow` | `.cursor/rules/skills/*.mdc` | Update phase config |
| `rule` | `.cursor/rules/core/*.mdc` | Add/modify rule |
| `knowledge` | Supabase `af_knowledge_base` | Insert entry |

---

## Rollback

If an applied change causes issues:

```bash
/learn:rollback --id <change_id>    # Rollback specific
/learn:rollback --last              # Rollback most recent
```

Rollback process:
1. Find backup file
2. Restore original content
3. Update Supabase: `applied = false`
4. Log rollback

---

## Example Session

```
User: /learn:apply

🐸 Learning: Found 3 pending improvements

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## Improvement 1/3: Route React to react-expert

ID: abc12345
Confidence: 92% ████████████████████░░░░
Frequency: 28 occurrences

### Description
Default react-expert agent for React component files

### Evidence
- 28 React component tasks analyzed
- react-expert: 96% success rate
- web-expert (current): 78% success rate

[a]pply | [s]kip | [m]odify | [q]uit: a

✅ Applied improvement
   Backup: backups/smart-agent-detector.mdc.2026-01-07

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

**Version:** 1.11.0
