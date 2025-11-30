# Workflow Quick Reference

Visual guide and cheat sheet for the 9-phase Aura Frog workflow system.

---

## Visual Workflow Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                    AURA FROG 9-PHASE WORKFLOW                    │
└─────────────────────────────────────────────────────────────────┘

┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  GROUP 1: PLANNING & PREPARATION (2-3 hours, ~135K tokens)     ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  ┌───────────────────────────────────────────┐
  │  Phase 1: Understand 🎯                   │
  │  "What are we building?"                  │
  │  ─────────────────────────────────────    │
  │  Duration: 30-60 min  │  Tokens: ~25K     │
  │  Agent: pm-operations-orchestrator        │
  │  Deliverables: Requirements, User Stories │
  └───────────────────────────────────────────┘
                    ↓ [APPROVAL GATE] ↓
  ┌───────────────────────────────────────────┐
  │  Phase 2: Design 🏗️                       │
  │  "How will we build it?"                  │
  │  ─────────────────────────────────────    │
  │  Duration: 1-2 hours  │  Tokens: ~45K     │
  │  Agent: Development (e.g., mobile-RN)     │
  │  Deliverables: Tech Design, Architecture  │
  └───────────────────────────────────────────┘
                    ↓ [APPROVAL GATE] ↓
  ┌───────────────────────────────────────────┐
  │  Phase 3: UI Breakdown 🎨                 │
  │  "What does it look like?"                │
  │  ─────────────────────────────────────    │
  │  Duration: 30-60 min  │  Tokens: ~30K     │
  │  Agent: ui-designer                       │
  │  Deliverables: Components, Design Tokens  │
  │  [SKIPPABLE if no UI changes]             │
  └───────────────────────────────────────────┘
                    ↓ [APPROVAL GATE] ↓
  ┌───────────────────────────────────────────┐
  │  Phase 4: Plan Tests 🧪                   │
  │  "How will we test it?"                   │
  │  ─────────────────────────────────────    │
  │  Duration: 30-60 min  │  Tokens: ~35K     │
  │  Agent: qa-automation                     │
  │  Deliverables: Test Plan, Test Cases      │
  └───────────────────────────────────────────┘

┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  GROUP 2: BUILD & POLISH (5-9 hours, ~130K tokens)             ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

                    ↓ [APPROVAL GATE] ↓
  ┌───────────────────────────────────────────┐
  │  Phase 5a: TDD RED 🔴                     │
  │  "Write failing tests first!"             │
  │  ─────────────────────────────────────    │
  │  Duration: 2-4 hours  │  Tokens: ~40K     │
  │  Agent: Development                       │
  │  Success: ALL tests FAIL (not found)      │
  │  🚫 BLOCKING: No implementation allowed!  │
  └───────────────────────────────────────────┘
                    ↓ [APPROVAL GATE] ↓
  ┌───────────────────────────────────────────┐
  │  Phase 5b: TDD GREEN 🟢                   │
  │  "Make tests pass!"                       │
  │  ─────────────────────────────────────    │
  │  Duration: 3-6 hours  │  Tokens: ~55K     │
  │  Agent: Development                       │
  │  Success: ALL tests PASS, Coverage ≥80%   │
  │  🚫 BLOCKING: Tests must pass!            │
  └───────────────────────────────────────────┘
                    ↓ [APPROVAL GATE] ↓
  ┌───────────────────────────────────────────┐
  │  Phase 5c: TDD REFACTOR ♻️                │
  │  "Make it better!"                        │
  │  ─────────────────────────────────────    │
  │  Duration: 1-2 hours  │  Tokens: ~35K     │
  │  Agent: Development                       │
  │  Success: Tests STILL pass, Code cleaner  │
  │  🚫 BLOCKING: Coverage must not decrease! │
  └───────────────────────────────────────────┘

┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  GROUP 3: REVIEW & VERIFY (1-2 hours, ~55K tokens)             ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

                    ↓ [APPROVAL GATE] ↓
  ┌───────────────────────────────────────────┐
  │  Phase 6: Review 👀                       │
  │  "Does it look good?"                     │
  │  ─────────────────────────────────────    │
  │  Duration: 45-90 min  │  Tokens: ~30K     │
  │  Agent: code-reviewer                     │
  │  Checks: Linter, Security, Quality        │
  │  🚫 BLOCKING: 0 linter errors required!   │
  └───────────────────────────────────────────┘
                    ↓ [APPROVAL GATE] ↓
  ┌───────────────────────────────────────────┐
  │  Phase 7: Verify ✅                       │
  │  "Does it work well?"                     │
  │  ─────────────────────────────────────    │
  │  Duration: 30-60 min  │  Tokens: ~25K     │
  │  Agent: qa-automation                     │
  │  Validates: Acceptance criteria, E2E      │
  │  🚫 BLOCKING: All criteria must pass!     │
  └───────────────────────────────────────────┘

┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  GROUP 4: DOCUMENT & SHARE (1-2 hours, ~25K tokens)            ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

                    ↓ [APPROVAL GATE] ↓
  ┌───────────────────────────────────────────┐
  │  Phase 8: Document 📚                     │
  │  "Explain what we built"                  │
  │  ─────────────────────────────────────    │
  │  Duration: 45-90 min  │  Tokens: ~20K     │
  │  Agent: Development                       │
  │  Deliverables: Docs, Deployment Guide     │
  └───────────────────────────────────────────┘
                    ↓ [APPROVAL GATE] ↓
  ┌───────────────────────────────────────────┐
  │  Phase 9: Share 🔔                        │
  │  "Tell the team!" (AUTO-EXECUTES)         │
  │  ─────────────────────────────────────    │
  │  Duration: 15-30 min  │  Tokens: ~5K      │
  │  Agent: Development                       │
  │  Actions: JIRA, Slack, Archive            │
  │  ⚡ NO APPROVAL NEEDED                    │
  └───────────────────────────────────────────┘

                         🎉 COMPLETE! 🎉

┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  TOTAL: ~345K tokens (Requires handoff at ~150K!)              ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

---

## Phase Checklist

### Planning Phases (1-4)

- [ ] **Phase 1: Understand**
  - [ ] Requirements gathered
  - [ ] User stories extracted
  - [ ] Acceptance criteria defined
  - [ ] Edge cases identified
  - [ ] Cross-review complete (Dev + QA + UI)
  - [ ] User approved

- [ ] **Phase 2: Design**
  - [ ] Architecture designed
  - [ ] Component structure defined
  - [ ] Data models created
  - [ ] Technical decisions documented
  - [ ] Cross-review complete (Secondary Dev + QA)
  - [ ] User approved

- [ ] **Phase 3: UI Breakdown** (skip if no UI)
  - [ ] Design tokens extracted
  - [ ] Components broken down
  - [ ] Layout strategy defined
  - [ ] Accessibility planned
  - [ ] User approved

- [ ] **Phase 4: Plan Tests**
  - [ ] Test strategy defined
  - [ ] Unit test cases planned
  - [ ] Integration test cases planned
  - [ ] E2E test cases planned
  - [ ] Coverage goals set (≥80%)
  - [ ] Cross-review complete (Dev)
  - [ ] User approved

### Build Phase (5)

- [ ] **Phase 5a: TDD RED**
  - [ ] All test files created
  - [ ] ALL tests FAIL ❌
  - [ ] Failures are "not found" errors ✅
  - [ ] NO implementation code ✅
  - [ ] User approved

- [ ] **Phase 5b: TDD GREEN**
  - [ ] Implementation complete
  - [ ] ALL tests PASS ✅
  - [ ] Coverage ≥80% ✅
  - [ ] No linter errors ✅
  - [ ] User approved

- [ ] **Phase 5c: TDD REFACTOR**
  - [ ] Code refactored
  - [ ] Tests STILL PASS ✅
  - [ ] Coverage maintained ✅
  - [ ] Code quality improved
  - [ ] User approved

### Quality Phases (6-7)

- [ ] **Phase 6: Review**
  - [ ] Linter: 0 errors, 0 warnings
  - [ ] TypeScript: 0 errors
  - [ ] Security: No critical issues
  - [ ] Cross-review complete (Dev + QA)
  - [ ] User approved

- [ ] **Phase 7: Verify**
  - [ ] All tests passing
  - [ ] All acceptance criteria validated
  - [ ] Edge cases tested
  - [ ] Performance acceptable
  - [ ] Accessibility compliant
  - [ ] User approved

### Shipping Phases (8-9)

- [ ] **Phase 8: Document**
  - [ ] Implementation summary created
  - [ ] Technical documentation complete
  - [ ] Deployment guide written
  - [ ] Changelog updated
  - [ ] User approved

- [ ] **Phase 9: Share**
  - [ ] JIRA updated (auto)
  - [ ] PR created (auto)
  - [ ] Team notified (auto)
  - [ ] Workflow archived (auto)
  - [ ] No approval needed ✅

---

## Common Patterns

### Quick Bug Fix (Skip Phases)

For simple bug fixes, use `bugfix:quick` instead of full workflow:

```bash
# Instead of workflow:start
bugfix:quick "Fix login button not responding"

# Executes simplified flow:
# 1. Understand bug
# 2. Write failing test
# 3. Fix bug
# 4. Verify test passes
# 5. Create PR
```

### Feature Development (Full Workflow)

For new features, use full 9-phase workflow:

```bash
workflow:start "Add social media sharing"

# Goes through all phases
# Comprehensive planning and testing
# High quality output
```

### Refactoring (Modified Flow)

For refactoring, some phases can be lighter:

```bash
workflow:start "Refactor UserProfile component"

# Phase 1: Light (understand refactoring goal)
# Phase 2: Detailed (plan new structure)
# Phase 3: Skip (no UI changes)
# Phase 4-5: Standard (TDD for refactoring)
# Phase 6-9: Standard (quality and shipping)
```

---

## Token Management Strategy

### Token Budget by Phase Group

| Group | Phases | Avg Tokens | % of Total |
|-------|--------|------------|------------|
| Planning | 1-4 | ~135K | 39% |
| Build | 5a-5c | ~130K | 38% |
| Quality | 6-7 | ~55K | 16% |
| Shipping | 8-9 | ~25K | 7% |
| **Total** | **1-9** | **~345K** | **100%** |

### Handoff Strategy

**Cursor limit: 200K tokens**

**Recommended handoff points:**

1. **After Phase 4** (Planning complete)
   - Token usage: ~135K (67.5%)
   - Resume at Phase 5a (TDD RED)
   - ✅ Good stopping point

2. **After Phase 5b** (Implementation complete)
   - Token usage: ~230K (115%) - **EXCEEDS LIMIT!**
   - Resume at Phase 5c (Refactor)
   - ⚠️ Too late! Should have handed off earlier

3. **After Phase 5c** (Build complete)
   - Token usage: ~265K (132.5%) - **EXCEEDS LIMIT!**
   - Resume at Phase 6 (Review)
   - ❌ Way too late!

**Best practice:** Handoff after Phase 4 or during Phase 5 if approaching 150K.

---

## Phase Skipping Rules

### Phases You CAN Skip

**Phase 3 (UI Breakdown)** - Skip if:
- Backend-only changes (API, database, services)
- No visual changes (refactoring, bug fixes)
- Data migration or scripts
- Infrastructure changes

**How to skip:**
```bash
# Auto-detected by workflow orchestrator
# Or manually request:
"Skip UI phase - no visual changes"
```

### Phases You CANNOT Skip

- ❌ Phase 1 (Understand) - Always required
- ❌ Phase 2 (Design) - Always required
- ❌ Phase 4 (Test Planning) - Always required
- ❌ Phase 5 (TDD) - Always required (RED → GREEN → REFACTOR)
- ❌ Phases 6-9 - Always required

---

## Quality Principles Quick Guide

### KISS (Keep It Simple, Stupid)

**Do:**
- ✅ Simple solutions
- ✅ Standard patterns
- ✅ Readable code
- ✅ Solve today's problem

**Don't:**
- ❌ Over-engineer
- ❌ Premature abstraction
- ❌ Complex configurations
- ❌ Solve tomorrow's problem

### DRY (Don't Repeat Yourself) - Rule of Three

```
1st time: Write it
2nd time: Duplicate (wince)
3rd time: Refactor and abstract
```

**Why?** Premature abstraction is worse than duplication!

### TDD (Test-Driven Development)

```
RED   → Write failing test ❌
GREEN → Write minimal code ✅
REFACTOR → Improve code quality ♻️
```

**Critical:** RED → GREEN → REFACTOR is non-negotiable!

### Cross-Review

**Phase 1:** PM creates → Dev + QA + UI review
**Phase 2:** Dev creates → Secondary Dev + QA review
**Phase 4:** QA creates → Dev reviews
**Phase 6:** Code → Multi-agent review

**Why?** Catch issues early, knowledge sharing, quality assurance

---

## Approval Gate Response Guide

### Valid Responses

| Response | Action | Example |
|----------|--------|---------|
| `approve` | Continue to next phase | "approve" |
| `yes` | Same as approve | "yes" |
| `reject: [reason]` | Restart with feedback | "reject: missing edge cases" |
| `modify: [changes]` | Adjust without restart | "modify: add tablet support" |
| `stop` | Cancel workflow | "stop" |
| `cancel` | Same as stop | "cancel" |

### After Approval

**AUTO-CONTINUE behavior:**
- Immediately execute next phase
- No waiting for user input
- Continue until:
  - Phase 5c complete (implementation done)
  - User rejection
  - Blocking error
  - Token limit reached

---

## Commands Quick Reference

### Workflow Management

```bash
# Start new workflow
workflow:start "Feature name"

# Show status
workflow:status

# Show token usage
workflow:tokens

# List all workflows
workflow:list

# Switch workflow
workflow:switch [workflow-id]
```

### Session Continuation

```bash
# Save state (at 150K tokens!)
workflow:handoff

# Resume in new session
workflow:resume [workflow-id]
```

### Quick Commands

```bash
# Quick bug fix (skip phases)
bugfix:quick "Description"

# Refactoring
refactor [file]

# Add tests
test:unit [file]
test:e2e [flow]

# Documentation
document [type] [name]
```

---

## Blocking Conditions Summary

| Phase | Cannot Proceed If... |
|-------|---------------------|
| 5a (RED) | • Any test passes<br>• Implementation exists |
| 5b (GREEN) | • Any test fails<br>• Coverage <80% |
| 5c (REFACTOR) | • Tests fail<br>• Coverage decreased |
| 6 (Review) | • Linter errors<br>• Security issues |
| 7 (Verify) | • Tests fail<br>• Criteria not validated |

---

## File Locations Reference

```
.cursor/
├── workflows/
│   ├── phases/
│   │   ├── phase-1-understand.md
│   │   ├── phase-2-design.md
│   │   ├── phase-3-ui.md
│   │   ├── phase-4-plan-tests.md
│   │   ├── phase-5a-red.md
│   │   ├── phase-5b-green.md
│   │   ├── phase-5c-refactor.md
│   │   ├── phase-6-review.md
│   │   ├── phase-7-verify.md
│   │   ├── phase-8-document.md
│   │   └── phase-9-share.md
│   ├── STATE_MANAGEMENT.md
│   └── QUICK_REFERENCE.md (this file)
├── rules/
│   └── core/
│       └── workflow-system.mdc
└── logs/
    ├── active-workflow.txt
    └── workflows/
        └── [workflow-id]/
            ├── workflow-state.json
            ├── deliverables/
            ├── backup/
            └── HANDOFF_CONTEXT.md
```

---

## Next Steps

1. **Read Full Phase Guides**
   - See `.cursor/workflows/phases/` for detailed guides
   - Each phase has complete execution steps

2. **Understand State Management**
   - Read `.cursor/workflows/STATE_MANAGEMENT.md`
   - Learn handoff/resume strategies

3. **Review Workflow System**
   - Read `.cursor/rules/core/workflow-system.mdc`
   - Understand orchestration rules

4. **Start Your First Workflow**
   ```bash
   workflow:start "Your feature name"
   ```

---

**Happy coding with Aura Frog! 🐸✨**
