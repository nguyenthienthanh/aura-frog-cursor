# Workflow State Management

Comprehensive guide for managing workflow state, session continuation, and recovery in Cursor IDE.

---

## Overview

Aura Frog workflows support **multiple concurrent workflows** with independent state management, enabling you to work on multiple features simultaneously without conflicts.

---

## State Structure

### Directory Layout

```
.cursor/
└── logs/
    ├── active-workflow.txt              # Points to current active workflow
    └── workflows/
        ├── workflow-1/
        │   ├── workflow-state.json      # Workflow 1 state
        │   ├── execution.log
        │   ├── tokens.log
        │   ├── deliverables/            # All phase outputs
        │   ├── backup/                  # Code snapshots
        │   └── HANDOFF_CONTEXT.md
        ├── workflow-2/
        │   ├── workflow-state.json      # Workflow 2 state
        │   └── ...
        └── workflow-3/
            ├── workflow-state.json      # Workflow 3 state
            └── ...
```

### Benefits
- ✅ Multiple workflows simultaneously
- ✅ Independent state per workflow
- ✅ Easy switching between workflows
- ✅ No state conflicts
- ✅ Persistent across sessions

---

## Workflow State File

### Location
```
.cursor/logs/workflows/[workflow-id]/workflow-state.json
```

### Structure
```json
{
  "workflow_id": "add-user-auth-20251130-120000",
  "workflow_name": "add-user-authentication",
  "created_at": "2025-11-30T12:00:00Z",
  "updated_at": "2025-11-30T14:30:00Z",
  "status": "in_progress",
  "current_phase": 5,
  "current_phase_name": "05-tdd-implementation",
  "total_tokens_used": 155000,
  "total_tokens_remaining": 45000,
  "auto_continue": true,

  "git": {
    "initial_branch": "feature/user-auth",
    "current_branch": "feature/user-auth",
    "base_branch": "main",
    "initial_commit": "abc1234",
    "latest_commit": "def5678",
    "commits": [
      {
        "hash": "abc1234",
        "message": "chore: start user auth workflow",
        "phase": 1,
        "timestamp": "2025-11-30T12:00:00Z"
      }
    ],
    "uncommitted_changes": [
      "src/auth/Login.tsx"
    ],
    "stash_id": null
  },

  "change_log": {
    "files_created": [
      {
        "path": "src/auth/Login.tsx",
        "phase": 5,
        "commit": "def5678",
        "lines": 150
      }
    ],
    "files_modified": [],
    "files_deleted": [],
    "total_lines_added": 450,
    "total_lines_removed": 20
  },

  "phases": {
    "1": {
      "name": "Requirements Analysis",
      "status": "completed",
      "started_at": "2025-11-30T12:00:00Z",
      "completed_at": "2025-11-30T12:30:00Z",
      "tokens": {
        "start": 5000,
        "end": 30000,
        "phase_tokens": 25000,
        "cumulative_tokens": 25000
      },
      "deliverables": ["requirements.md", "user-stories.md"]
    }
    // ... phases 2-9
  },

  "handoffs": [
    {
      "at_phase": 4,
      "at_tokens": 155000,
      "timestamp": "2025-11-30T14:30:00Z",
      "handoff_file": "HANDOFF_CONTEXT.md",
      "git_state": {
        "branch": "feature/user-auth",
        "commit": "def5678",
        "has_uncommitted": true
      }
    }
  ]
}
```

---

## Active Workflow Management

### Get Active Workflow

```bash
# Read active workflow ID
cat .cursor/logs/active-workflow.txt
# Output: add-user-auth-20251130-120000
```

### Switch Workflow

```bash
# Change active workflow
echo "another-workflow-id" > .cursor/logs/active-workflow.txt

# Or use command
workflow:switch another-workflow-id
```

### List All Workflows

```bash
workflow:list

# Output:
📋 All Workflows:

⏳ add-user-authentication [ACTIVE]
   ID: add-user-auth-20251130-120000
   Phase: 5/9 | Status: in_progress
   Created: 2025-11-30T12:00:00Z

✅ refactor-userprofile
   ID: refactor-userprofile-20251130-100000
   Phase: 9/9 | Status: completed
   Created: 2025-11-30T10:00:00Z
```

---

## Session Continuation (Handoff/Resume)

### When to Use Handoff

**Token Thresholds:**
- **150K (75%)**: ⚠️ Warning - plan handoff soon
- **175K (87.5%)**: 🚨 CRITICAL - run handoff NOW
- **200K (100%)**: Hard limit - session ends

**Other Reasons:**
- Taking a break on long workflow
- Need to close session
- Switching computers
- Sharing work with teammate

### How to Handoff

```bash
workflow:handoff

# Output:
✅ Workflow state saved
✅ Context saved to HANDOFF_CONTEXT.md
✅ Git state captured
✅ Backup created

📋 To resume in new session:
   workflow:resume add-user-auth-20251130-120000

🔗 Handoff file: .cursor/logs/workflows/add-user-auth-20251130-120000/HANDOFF_CONTEXT.md
```

### What Gets Saved

1. **Workflow State**
   - Current phase
   - Token usage
   - Phase history
   - Deliverables list

2. **Git State**
   - Current branch
   - Latest commit
   - Uncommitted files
   - Stash (if any)

3. **Code Backup**
   - Modified files copied to backup/
   - Git diff saved
   - File checksums

4. **Context Document**
   - Summary of work done
   - Next steps
   - Important decisions
   - Known issues

### How to Resume

**In New Session:**

```bash
workflow:resume add-user-auth-20251130-120000
```

**Resume Process:**

1. **Load State**
   - Read workflow-state.json
   - Parse phase history
   - Load deliverables

2. **Verify Git State**
   - Check current branch matches
   - Verify commits exist
   - Check for file changes

3. **Show Context**
   ```markdown
   📊 Resuming Workflow: add-user-authentication

   **Last Active:** 2025-11-30T14:30:00Z (2 hours ago)
   **Current Phase:** 5b (TDD GREEN)
   **Progress:** 5/9 phases complete (55%)
   **Tokens Used:** 155K / 200K (77.5%)

   **Git State:**
   - Branch: feature/user-auth ✅
   - Latest commit: def5678 ✅
   - Uncommitted: 1 file (src/auth/Login.tsx)

   **What's Done:**
   ✅ Phase 1: Requirements Analysis
   ✅ Phase 2: Technical Design
   ✅ Phase 3: UI Breakdown
   ✅ Phase 4: Test Planning
   ✅ Phase 5a: TDD RED (53 tests failing)

   **Next Up:**
   ⏭️ Phase 5b: TDD GREEN (Implement code to pass tests)

   **Continue?** (yes/no)
   ```

4. **Continue Workflow**
   - Proceed from last phase
   - Maintain token count
   - Continue deliverables

---

## Git Integration

### Why Git Tracking is Critical

When working on multiple workflows, each may be on different branches:

```
Workflow 1: feature/user-auth     (Phase 5)
Workflow 2: feature/dark-mode     (Phase 2)
Workflow 3: fix/login-crash       (Phase 7)
```

**Without branch tracking:**
- Resume to wrong branch → Code conflicts
- Lost commits → Work duplication
- Uncommitted changes lost → Progress lost

### Automatic Git Management

**On Workflow Start:**
```bash
# Automatically captured:
git branch --show-current              # → initial_branch
git rev-parse HEAD                      # → initial_commit
git rev-parse --abbrev-ref @{u}        # → remote tracking
```

**At Each Phase:**
```bash
# Logged automatically:
- Current branch
- Commit before/after phase
- Uncommitted file list
```

**On Handoff:**
```bash
# Automatic backup:
git stash push -m "workflow-handoff-[id]"
git branch backup/[workflow]-[timestamp]
cp -r src/ .cursor/logs/workflows/[id]/backup/
```

### Branch Verification on Resume

**Process:**

1. **Check Current Branch**
   ```bash
   current=$(git branch --show-current)
   expected="feature/user-auth"

   if [ "$current" != "$expected" ]; then
     echo "⚠️ Branch mismatch!"
   fi
   ```

2. **Offer Recovery Options**
   ```markdown
   ⚠️ Branch Mismatch Detected

   Expected: feature/user-auth
   Current: main

   Options:
   1. checkout → Switch to feature/user-auth
   2. continue → Continue on current branch (may cause conflicts)
   3. review → Show branch differences first
   ```

3. **Verify Commits**
   ```bash
   # Check if expected commits exist
   git log --oneline | grep "def5678"
   ```

---

## Change Log Tracking

### What Gets Tracked

| Category | Data | Purpose |
|----------|------|---------|
| Files Created | Path, phase, commit, lines | Know what was built |
| Files Modified | Path, phase, diff summary | Track changes |
| Files Deleted | Path, phase, reason | Avoid recreation |
| Commits | Hash, message, phase | Git history mapping |

### Usage on Resume

**Show Changes Since Handoff:**

```markdown
📊 Changes Since Handoff

**Git Status:**
- Branch: feature/user-auth ✅ (same)
- Commits: 2 new commits since handoff

**File Changes:**
- ✅ src/auth/Login.tsx (unchanged)
- ⚠️ src/App.tsx (modified externally)
- ❌ src/auth/types.ts (deleted!)

**Options:**
- continue → Proceed with current state
- diff → Show detailed differences
- restore → Restore from backup
```

---

## Recovery Scenarios

### Scenario 1: Branch Deleted

```markdown
❌ Recovery Required: Branch Not Found

Expected Branch: feature/user-auth
Status: Branch does not exist

Recovery Options:

1. Restore from backup branch:
   git checkout -b feature/user-auth backup/user-auth-20251130-143000

2. Restore from remote:
   git checkout -b feature/user-auth origin/feature/user-auth

3. Start fresh:
   - Deliverables preserved in .cursor/logs/workflows/[id]/
   - Can recreate code from deliverables
```

### Scenario 2: Uncommitted Changes Lost

```markdown
⚠️ Recovery Required: Uncommitted Work

At Handoff: 2 uncommitted files
- src/auth/Login.tsx
- src/auth/AuthContext.tsx

Current Status: Files not found

Recovery Options:

1. Restore from stash:
   git stash list | grep "workflow-handoff"
   git stash apply stash@{0}

2. Restore from backup directory:
   cp .cursor/logs/workflows/[id]/backup/src/auth/* src/auth/

3. Regenerate from deliverables:
   - Phase 5 deliverables contain code specs
   - Can regenerate implementation
```

### Scenario 3: Complete Repository Loss

```markdown
🚨 Critical Recovery: Repository Not Found

Workflow: add-user-authentication
Status: Project directory not found

Recovery:

1. Deliverables Preserved:
   .cursor/logs/workflows/[id]/
   ├── deliverables/          ← All phase outputs
   ├── HANDOFF_CONTEXT.md     ← Full context
   └── backup/                ← Code snapshots

2. Recovery Steps:
   - Clone repository fresh
   - Create branch from base
   - Use deliverables to guide reimplementation
   - Or copy backup files directly

3. Partial Recovery:
   - Requirements, specs, test plans preserved
   - Can restart from Phase 5 with existing planning
```

---

## Backup Strategy

### Automatic Backups on Handoff

```bash
# 1. Create backup branch
git branch backup/[workflow]-[timestamp]

# 2. Stash uncommitted changes
git stash push -m "workflow-handoff-[id]"

# 3. Copy changed files to backup dir
cp -r src/ .cursor/logs/workflows/[id]/backup/src/

# 4. Save git state
git log --oneline -20 > .cursor/logs/workflows/[id]/backup/git-log.txt
git diff HEAD > .cursor/logs/workflows/[id]/backup/uncommitted.patch
```

### Backup Locations

```
.cursor/logs/workflows/[workflow-id]/
├── backup/
│   ├── src/                    # Source code snapshot
│   ├── git-log.txt             # Recent commits
│   ├── uncommitted.patch       # Uncommitted changes
│   └── file-checksums.json     # Verification
├── RECOVERY.md                 # Recovery instructions
└── workflow-state.json         # Full state
```

### Recovery Priority

| Priority | Source | When to Use |
|----------|--------|-------------|
| 1 | Git branch | Branch exists, commits intact |
| 2 | Backup branch | Main branch modified |
| 3 | Stash | Uncommitted changes lost |
| 4 | Backup directory | Git history corrupted |
| 5 | Deliverables | Complete loss, rebuild needed |

---

## Best Practices

### 1. Name Workflows Clearly

```bash
# ✅ Good
workflow:start "Add JWT authentication"
workflow:start "Refactor UserProfile component"
workflow:start "Fix login crash on iOS"

# ❌ Bad
workflow:start "Update stuff"
workflow:start "Changes"
```

### 2. One Active Workflow at a Time

**At any moment:**
- One workflow = ACTIVE (being worked on)
- Others = PAUSED (saved state)

**Switch when:**
- Waiting for review
- Need to work on urgent fix
- Token limit approaching

### 3. Clean Up Completed Workflows

```bash
# After workflow complete
workflow:status  # Verify completed

# Archive for reference
workflow:archive [id]

# Or delete if not needed
workflow:delete [id]
```

### 4. Use Handoff Proactively

```bash
# At 150K tokens (not 190K!)
workflow:handoff

# New session
workflow:resume [id]
```

### 5. Commit Frequently

- Commit after each phase
- Meaningful commit messages
- Reference phase number
- Easy to track progress

---

## Workflow Commands

### Management

```bash
# List all workflows
workflow:list

# Show current workflow status
workflow:status

# Switch to different workflow
workflow:switch [workflow-id]

# Archive completed workflow
workflow:archive [workflow-id]

# Delete workflow
workflow:delete [workflow-id]
```

### Session Continuation

```bash
# Save current workflow state
workflow:handoff

# Resume saved workflow
workflow:resume [workflow-id]

# Show token usage
workflow:tokens
```

---

## Integration Points

### With Skills
- `workflow-orchestrator` - Manages workflow execution
- `phase-skipping` - Smart phase skip logic
- `project-context-loader` - Loads project conventions

### With Commands
- `/workflow:start` - Initialize workflow
- `/workflow:status` - Show progress
- `/workflow:handoff` - Save state
- `/workflow:resume` - Continue workflow

### With Rules
- `.cursor/rules/core/workflow-system.mdc` - Workflow orchestration
- `.cursor/rules/core/tdd-workflow.mdc` - TDD enforcement
- `.cursor/rules/core/kiss-principle.mdc` - Simplicity enforcement

---

## Token Tracking Integration

State management includes automatic token tracking:

```json
{
  "total_tokens_used": 155000,
  "total_tokens_remaining": 45000,
  "phases": {
    "1": {
      "tokens": {
        "start": 5000,
        "end": 30000,
        "phase_tokens": 25000,
        "cumulative_tokens": 25000
      }
    }
  }
}
```

**Benefits:**
- Know exact token usage
- Plan handoff timing
- Resume with accurate count
- Optimize future workflows

---

## References

- **Phase Guides**: `.cursor/workflows/phases/`
- **Workflow System**: `.cursor/rules/core/workflow-system.mdc`
- **Quick Reference**: `.cursor/workflows/QUICK_REFERENCE.md`
- **Aura Frog Guide**: `~/.cursor/plugins/marketplaces/aurafrog/aura-frog/SESSION_CONTINUATION_GUIDE.md`

---

**Multiple workflows = Better organization! 🎯**
