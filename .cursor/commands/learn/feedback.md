# /learn:feedback

**Category:** Learning
**Purpose:** Manually submit feedback to the learning system

---

## Usage

```bash
/learn:feedback                           # Interactive feedback
/learn:feedback --type correction         # Report a correction
/learn:feedback --type success            # Report what worked well
/learn:feedback --type agent-issue        # Report agent selection issue
/learn:feedback --type workflow-issue     # Report workflow issue
```

**Script:** `./scripts/learn/submit-feedback.sh`

---

## CRITICAL: Cursor MUST Execute

When user runs `/learn:feedback`, Cursor **MUST actually submit to Supabase**.

**DO NOT** just show documentation. **DO** run the curl command to store feedback.

---

## Execution Steps

When user runs `/learn:feedback`, Cursor should:

### Step 1: Load Environment & Check

```bash
# Source .envrc first
source .envrc 2>/dev/null || source .cursor/.envrc 2>/dev/null || true

# Verify
if [ -z "$SUPABASE_URL" ] || [ -z "$SUPABASE_SECRET_KEY" ]; then
  echo "❌ Learning system not configured"
  echo "Run: source .envrc"
  exit 1
fi
```

### Step 2: Gather Feedback (Interactive)

Ask the user:

```markdown
## 📝 Submit Feedback

**What type of feedback?**

1. ✅ **Success** - Something worked really well
2. ❌ **Correction** - I had to fix/redo something
3. 🤖 **Agent Issue** - Wrong agent was selected
4. 🔄 **Workflow Issue** - Problem with workflow phases
5. 💡 **Suggestion** - General improvement idea

**Select (1-5):**
```

### Step 3: Collect Details Based on Type

#### For Success (type=success)
```markdown
**What worked well?**
- Agent used: [auto-detect or ask]
- Task type: [e.g., "React component", "API endpoint"]
- Why it worked: [user input]

**Rate effectiveness (1-5):**
```

#### For Correction (type=correction)
```markdown
**What needed correction?**
- What was the issue: [user input]
- What did you change: [user input]
- File(s) affected: [auto-detect recent edits or ask]
- Agent used: [auto-detect or ask]

**Severity (1-5):** 1=minor tweak, 5=complete redo
```

#### For Agent Issue (type=agent-issue)
```markdown
**Agent Selection Problem**
- Task description: [user input]
- Agent selected: [auto-detect or ask]
- Better agent would be: [user input or suggest from list]
- Why: [user input]
```

#### For Workflow Issue (type=workflow-issue)
```markdown
**Workflow Problem**
- Phase where issue occurred: [1-9]
- What happened: [user input]
- Expected behavior: [user input]
```

#### For Suggestion (type=suggestion)
```markdown
**Improvement Suggestion**
- Category: [agent/workflow/rule/skill/other]
- Suggestion: [user input]
- Expected benefit: [user input]
```

### Step 4: Submit to Supabase

```bash
# Determine feedback_type based on user selection
# success → approval
# correction → correction
# agent-issue → agent_override
# workflow-issue → rejection
# suggestion → suggestion

curl -X POST "${SUPABASE_URL}/rest/v1/af_feedback" \
  -H "apikey: ${SUPABASE_SECRET_KEY}" \
  -H "Authorization: Bearer ${SUPABASE_SECRET_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "feedback_type": "'"$feedback_type"'",
    "reason": "'"$message"'",
    "rating": '"$severity"',
    "metadata": {
      "task_type": "'"$task_type"'",
      "agent_used": "'"$agent_used"'"
    }
  }'
```

### Step 5: Confirm Submission

```markdown
✅ Feedback submitted!

**Type:** Correction
**Severity:** 3/5
**Agent:** react-expert
**Details:** Component state management approach was overcomplicated

💡 Run `/learn:analyze` to see how your feedback improves the system.
```

---

## Quick Feedback (Non-Interactive)

For fast feedback submission:

```bash
# Quick success
/learn:feedback --type success --message "TDD approach worked great for API"

# Quick correction
/learn:feedback --type correction --severity 3 --message "Had to simplify state logic"

# Quick agent issue
/learn:feedback --type agent-issue --agent react-expert --better nodejs-expert --message "Was backend task"
```

---

## Feedback Types Reference

| Type | feedback_type | When to Use |
|------|---------------|-------------|
| Success | `approval` | Agent/approach worked well |
| Correction | `correction` | You modified AI output |
| Agent Issue | `agent_override` | Wrong agent selected |
| Workflow Issue | `rejection` | Phase/workflow problem |
| Suggestion | `suggestion` | General improvement idea |

---

## Related Commands

- `/learn:status` - Check feedback count and system status
- `/learn:analyze` - Analyze feedback patterns
- `/learn:apply` - Apply improvements based on feedback

---

**Version:** 1.0.0
