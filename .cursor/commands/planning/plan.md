# Command: planning

**Purpose:** Create a comprehensive plan for a task without starting full workflow
**Aliases:** `plan`, `create plan`, `brainstorm plan`

---

## Overview

Generate a detailed technical plan including:
- Problem analysis
- Solution options (brainstorming)
- Technical approach
- Implementation steps
- Risk assessment

**Use when:** You need planning/design before committing to full workflow

---

## Usage

```bash
# Create plan
planning "Refactor UserProfile component"

# Or natural language
"Create a plan for adding authentication"
"Help me plan the dashboard refactoring"
"Brainstorm solutions for performance issues"
```

---

## Execution Flow

### 1. Gather Context

- Load project context
- Analyze existing code (if applicable)
- Identify constraints (time, complexity, dependencies)

### 2. Brainstorm Solutions

```markdown
## Problem Statement

**Task:** [User's request]

**Current State:**
- What exists today
- Pain points
- Limitations

**Desired State:**
- What we want to achieve
- Success criteria
- Requirements

---

## Solution Options

### Option A: [Approach 1]

**Description:** [How it works]

**Pros:**
- [Advantage 1]
- [Advantage 2]

**Cons:**
- [Disadvantage 1]
- [Disadvantage 2]

**Effort:** Low | Medium | High
**Risk:** Low | Medium | High
**Impact:** Low | Medium | High

### Option B: [Approach 2]

[Same structure...]

### Option C: [Approach 3]

[Same structure...]

---

## Decision Matrix

| Solution | Impact | Effort | Risk | Maintainability | Score |
|----------|--------|--------|------|-----------------|-------|
| Option A | 9      | 3      | 2    | 8               | 22    |
| Option B | 7      | 5      | 4    | 6               | 18    |
| Option C | 6      | 2      | 1    | 7               | 16    |

**Recommended:** Option A (Highest score)
```

### 3. Technical Plan

The plan includes:
- Architecture diagram
- Component breakdown
- File structure
- Implementation steps with time estimates
- Dependencies (external and internal)
- Testing strategy
- Migration plan
- Risks & mitigation

### 4. Save Plan

Plans are saved to `plans/[plan-id].md` for future reference.

---

## Output Format

```markdown
PLAN CREATED

**Task:** Refactor UserProfile component
**Plan ID:** refactor-userprofile-20251124-150000
**Recommended Solution:** Option A - Component Split

**Effort:** 3.5 hours
**Risk:** Low
**Impact:** Medium

---

## Plan Location

`plans/refactor-userprofile-20251124-150000.md`

**Contains:**
- Problem analysis
- 3 solution options
- Decision matrix
- Technical approach
- Implementation steps
- File structure
- Testing strategy
- Risk assessment

---

## Next Steps

**Option 1: Review & Refine**
planning:refine refactor-userprofile-20251124-150000

**Option 2: Execute Plan**
execute refactor-userprofile-20251124-150000

**Option 3: Start Full Workflow**
workflow:start "Refactor UserProfile component"
```

---

## Plan Features

### Comprehensive Analysis
- Problem statement
- Multiple solutions (brainstorming)
- Decision framework with scoring
- Risk assessment

### Actionable Details
- File structure
- Implementation steps
- Time estimates
- Dependencies

### Quality Focus
- Testing strategy
- Success criteria
- Rollback plan
- Mitigation strategies

---

## Use Cases

### Case 1: Explore Options (Brainstorming)

```bash
planning "Add authentication"

# Output:
- Option A: JWT tokens
- Option B: OAuth
- Option C: Session-based

# Review and decide later
```

### Case 2: Quick Estimate

```bash
planning "Refactor dashboard"

# Get:
- Effort estimate: 8 hours
- Complexity: High
- Risks identified
```

### Case 3: Documentation

```bash
planning "Implement new API"

# Creates:
- Technical specification
- Architecture diagram
- Implementation plan
- Can share with team
```

---

## Related Commands

```bash
planning "Task"              # Create plan
planning:refine [plan-id]    # Update plan
planning:list                # List all plans
execute [plan-id]            # Execute plan
workflow:start "Task"        # Full workflow (includes planning)
```

---

## Success Criteria

- Comprehensive problem analysis
- Multiple solution options (brainstorming)
- Clear decision rationale
- Detailed implementation plan
- Risk assessment included
- Saved for reference
- Ready to execute

---

**Command:** planning
**Version:** 1.3.0
**Added:** Aura Frog v1.3
