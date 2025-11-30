# Phase 4: Plan Tests (Test Strategy)

## Purpose
Create comprehensive test strategy, define test cases for all scenarios, set coverage goals, and prepare for TDD implementation in Phase 5.

## Prerequisites
- Phase 3 (UI) completed and approved (or skipped if no UI)
- Technical design and component structure defined
- QA automation agent selected
- Test requirements from Phase 1

## Inputs
- Requirements Analysis Document (Phase 1)
- Technical Design Document (Phase 2)
- UI Breakdown Document (Phase 3, if applicable)
- Acceptance criteria from all user stories
- Edge cases identified in Phase 1

## Execution Steps

### 1. Test Strategy Definition (15 min)
Define:
- Test types needed: Unit, Integration, E2E
- Testing frameworks: Jest, Testing Library, Detox, etc.
- Coverage goals (default: 80% minimum)
- Test data strategy
- Mock strategy
- Test environment setup

### 2. Unit Test Planning (30 min)
For each component/function:
- **Happy path**: Normal operation scenarios
- **Edge cases**: Boundary conditions, empty states
- **Error cases**: Invalid inputs, exceptions
- **State changes**: All state transitions
- **Props variations**: All prop combinations

Create test case descriptions for:
- Component rendering
- User interactions
- Hook behavior
- Utility functions
- Data transformations

### 3. Integration Test Planning (25 min)
Plan tests for:
- API integration
- State management integration
- Component composition
- Navigation flows
- Data persistence
- Third-party SDK integration

### 4. E2E Test Planning (20 min)
Define user flows to test:
- Critical user journeys
- Multi-step workflows
- Cross-screen navigation
- Success scenarios
- Error recovery flows

### 5. Test Data Planning (15 min)
- Define test fixtures
- Plan mock API responses
- Create test user scenarios
- Define edge case data
- Plan snapshot test data

### 6. Coverage Analysis (10 min)
Map test cases to:
- Acceptance criteria (from Phase 1)
- Components (from Phase 2/3)
- Edge cases (from Phase 1)

Ensure 100% acceptance criteria coverage.

### 7. Cross-Review (15 min)
Test plan reviewed by:
- **Dev Agent**: Testability confirmation, completeness
- **Secondary QA** (if available): Test case quality

## Deliverables
- Test Strategy Document (`PHASE_4_TEST_PLANNING.md`)
- Unit test case descriptions (all scenarios)
- Integration test case descriptions
- E2E test case descriptions
- Test data and fixtures plan
- Coverage goals and mapping
- Test environment setup guide
- Dev testability review checklist

## Approval Gate
Present summary to user including:
- Total test cases planned
- Test types breakdown (unit/integration/e2e)
- Coverage goals
- Testing approach
- Next steps (Phase 5a: TDD RED)

**Valid responses:**
- `approve` → AUTO-CONTINUE to Phase 5a (TDD RED)
- `reject: [reason]` → Revise test plan
- `modify: [changes]` → Adjust test cases

## Auto-Continue Behavior
After approval, IMMEDIATELY proceed to Phase 5a (TDD RED - Write Failing Tests).

## Quality Gates
**Must Pass:**
- 100% acceptance criteria covered by tests
- All edge cases have test cases
- Coverage goal defined (minimum 80%)
- Test strategy complete
- Dev review approved

**Should Pass:**
- Unit tests cover all components
- Integration tests cover all flows
- E2E tests cover critical paths
- Test data plan complete

## Token Awareness
- **Typical usage**: 25-45K tokens (~35K average)
- **Cumulative**: ~135K / 200K (67.5%)
- Display token usage at approval gate
- **Warning**: Approaching 75% threshold (150K)

## Common Mistakes to Avoid
- Planning too few test cases
- Missing edge case tests
- Not planning mocks upfront
- Skipping integration tests
- Insufficient coverage goals
- Not mapping to acceptance criteria
- Missing error scenario tests

## Test Case Quality
**Good test cases are:**
- **Specific**: Clear scenario description
- **Measurable**: Definite pass/fail criteria
- **Independent**: No dependencies on other tests
- **Repeatable**: Same result every time
- **Focused**: One thing per test

**Example:**
```
✅ Good: "should display error message when email is invalid format"
❌ Bad: "should handle errors properly"
```

## Coverage Goals
| Test Type | Coverage Target | Priority |
|-----------|----------------|----------|
| Unit | 85-90% | Must Have |
| Integration | 70-80% | Must Have |
| E2E | Critical paths | Should Have |
| Overall | 80% minimum | Must Have |

## References
- Project context: `.cursor/project-contexts/[project]/`
- Related phases: Phase 3 (UI), Phase 5a (TDD RED)
- Templates: `~/.claude/plugins/marketplaces/aurafrog/aura-frog/templates/test-plan.md`
- Rules: `.cursor/rules/core/tdd-workflow.mdc`
- Skills: `test-writer`
