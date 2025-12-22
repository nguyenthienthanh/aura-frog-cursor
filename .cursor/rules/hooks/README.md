# Aura Frog Workflow Hooks

This directory contains lifecycle hooks for the Aura Frog 9-phase structured workflow. These hooks guide Claude/Cursor AI through workflow execution, ensuring quality standards and proper phase transitions.

## What Are Hooks?

Hooks are **guidance documents** (not executable scripts) that instruct the AI agent on what to do at specific points in the workflow lifecycle. They ensure consistent workflow execution and maintain quality gates between phases.

## Available Hooks

### 1. on-start.mdc
**Trigger:** Before workflow begins (when `workflow:start` is executed)

**Purpose:** Validate project setup and configuration

**Actions:**
- Check for `.cursor/project-contexts/` directory
- Verify `ccpm-config.yaml` exists
- Check `.cursor/settings.local.json`
- Verify `.envrc` environment configuration
- Display setup reminder if incomplete
- Require user choice to proceed or cancel

**When It Runs:**
```
User: workflow:start "Add feature"
      ↓
[ON-START HOOK] ← Validates setup
      ↓
Phase 1: Requirements Analysis
```

---

### 2. pre-phase.mdc
**Trigger:** Before each phase begins (Phases 1-9)

**Purpose:** Prepare environment and context for phase execution

**Actions:**
- Load workflow state
- Verify previous phase approved
- Check required agents are active
- Initialize phase state
- Load phase context (deliverables, project info)
- Display phase objectives and success criteria
- Start phase timer and token tracking

**When It Runs:**
```
Phase N-1 approved
      ↓
[PRE-PHASE HOOK] ← Prepares Phase N
      ↓
Phase N execution
```

---

### 3. post-phase.mdc
**Trigger:** After each phase completes (Phases 1-9)

**Purpose:** Validate phase output and prepare for approval

**Actions:**
- Stop phase timer, calculate duration
- Calculate token usage for phase
- Validate deliverables exist
- Run phase-specific validation (e.g., tests pass, coverage met)
- Check success criteria
- Collect metrics
- Generate phase summary
- Save workflow state
- Prepare approval data

**When It Runs:**
```
Phase N execution completes
      ↓
[POST-PHASE HOOK] ← Validates output
      ↓
Approval prompt
```

---

### 4. pre-approval.mdc
**Trigger:** Before user approval prompt (after post-phase)

**Purpose:** Display approval prompt and handle user decision

**Actions:**
- Load approval data
- Format phase summary
- Display deliverables with icons
- Show success criteria status
- Display metrics
- Preview next phase
- Present action options (approve/reject/modify/cancel/back)
- Wait for and validate user response

**When It Runs:**
```
Post-phase validation complete
      ↓
[PRE-APPROVAL HOOK] ← Shows prompt
      ↓
User responds (approve/reject/modify/cancel)
      ↓
Process response and continue or repeat
```

---

## Hook Execution Flow

### Complete Workflow Lifecycle

```
workflow:start "Task"
      ↓
[ON-START HOOK] - Validate setup
      ↓
      ╔═══════════════════════════════════╗
      ║         FOR EACH PHASE 1-9        ║
      ║                                   ║
      ║  [PRE-PHASE HOOK]                ║
      ║         ↓                         ║
      ║  Phase Execution                  ║
      ║         ↓                         ║
      ║  [POST-PHASE HOOK]               ║
      ║         ↓                         ║
      ║  [PRE-APPROVAL HOOK]             ║
      ║         ↓                         ║
      ║  User Decision                    ║
      ║    - Approve → Next phase         ║
      ║    - Reject → Repeat phase        ║
      ║    - Modify → Make changes        ║
      ║    - Cancel → Stop workflow       ║
      ║    - Back → Previous phase        ║
      ║                                   ║
      ╚═══════════════════════════════════╝
      ↓
Workflow Complete
```

## Execution Order

For each phase, hooks run in this sequence:

1. **PRE-PHASE** → Load context, verify prerequisites, initialize state
2. **PHASE EXECUTION** → Agent performs phase work
3. **POST-PHASE** → Validate output, check criteria, collect metrics
4. **PRE-APPROVAL** → Show formatted approval prompt
5. **USER DECISION** → User approves, rejects, or takes other action
6. **NEXT ACTION** → Proceed to next phase or repeat current phase

## Phase-Specific Behaviors

### Phase 5a: Write Tests (TDD RED)
**Post-Phase Validation:** Tests MUST fail (red phase)

### Phase 5b: Implementation (TDD GREEN)
**Post-Phase Validation:** Tests MUST pass, coverage must meet threshold

### Phase 5c: Refactor
**Post-Phase Validation:** Tests still pass, code quality improved

### Phase 7: QA Validation
**Post-Phase Validation:** All tests pass, coverage meets threshold, no critical bugs

## Integration with Cursor IDE

These hooks are Cursor-specific MDC (Markdown Context) files that:
- Are indexed by Cursor IDE
- Activate contextually during workflow execution
- Provide guidance to the AI agent
- Are **not executable scripts** - they're instructions for the AI

## Hook Characteristics

### Blocking vs Non-Blocking

**Blocking Hooks (Must Complete Successfully):**
- `on-start.mdc` - User must choose to continue or cancel
- `pre-phase.mdc` - Prerequisites must be met
- `post-phase.mdc` - Validation must pass
- `pre-approval.mdc` - User must provide valid response

### Critical Checks

**On-Start:**
- Project context exists
- Configuration files present
- Environment configured

**Pre-Phase:**
- Previous phase approved (if not Phase 1)
- Required agents active
- Context loaded successfully

**Post-Phase:**
- Deliverables created
- Phase-specific validation passed
- Success criteria met (or documented as not met)

**Pre-Approval:**
- Approval data formatted
- User response validated

## Token Tracking

Hooks track token usage throughout workflow:
- **Pre-Phase:** Record starting token count
- **Post-Phase:** Calculate tokens used in phase
- **Cumulative:** Track total tokens across all phases
- **Warning:** Alert at 75% (150K/200K) and 87% (174K/200K)

## Context Access

Hooks access:
- **Workflow state:** `.cursor/logs/workflows/[workflow-id]/state.json`
- **Project context:** `.cursor/project-contexts/[project]/`
- **Phase definitions:** From CLAUDE.md or plugin config
- **Deliverables:** From phase execution
- **Metrics:** Test results, coverage, linter output, etc.

## Customization

To customize hooks for your project:
1. Copy hook to `.cursor/rules/hooks/project-specific/`
2. Modify validation logic
3. Adjust success criteria
4. Update approval prompts
5. Reference in project's `.cursor/rules/core.mdc`

## Error Handling

All hooks include error handling:
- **Validation Errors:** Phase marked as failed, workflow pauses
- **Missing Prerequisites:** Clear error message, suggestion to fix
- **User Cancellation:** Workflow state saved, can resume later

## Best Practices

1. **Don't Skip Hooks:** They ensure quality and consistency
2. **Trust the Process:** Each hook serves a purpose
3. **Provide Feedback:** If validation fails, read the error carefully
4. **Save State:** Use `workflow:handoff` if pausing mid-workflow
5. **Review Approvals:** Read phase summaries before approving

## Related Documentation

- **Templates:** `.cursor/rules/templates/` - Documentation templates used in phases
- **Core Rules:** `.cursor/rules/core.mdc` - Overall Aura Frog behavior
- **Agents:** `.cursor/rules/agents/` - Specialized agent instructions
- **Project Context:** `.cursor/project-contexts/[project]/` - Project-specific config

---

**Version:** 1.3.0
**Adapted from:** Aura Frog hooks system
**For:** Cursor IDE
**Date:** 2025-11-30
