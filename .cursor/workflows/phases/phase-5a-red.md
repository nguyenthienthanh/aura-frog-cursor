# Phase 5a: TDD RED (Write Failing Tests)

## Purpose
Write comprehensive failing tests BEFORE implementation. This is the RED phase of Test-Driven Development where ALL tests must fail for the right reasons.

## Prerequisites
- Phase 4 (Test Planning) completed and approved
- Test plan and test cases defined
- Test environment configured
- Development agent active

## Inputs
- Test Strategy Document from Phase 4
- Test case descriptions (unit/integration/e2e)
- Test data and fixtures plan
- Component/module specifications from Phase 2

## Execution Steps

### 1. Review Test Plan (5 min)
- Read Phase 4 test plan document
- Understand all test cases
- Review coverage goals
- Note test data requirements

### 2. Set Up Test Environment (10 min)
```bash
# Install test dependencies
npm install --save-dev jest @testing-library/react @testing-library/react-native

# Configure test framework (jest.config.js)
# Set up test utilities
# Configure mocks and fixtures
```

### 3. Write Unit Tests (2-4 hours)
For each component/function, write tests for:
- **Rendering**: Component renders correctly with various props
- **User Interactions**: Click, input, gesture handlers
- **State Changes**: All state transitions
- **Edge Cases**: Empty states, null values, boundaries
- **Error Cases**: Invalid inputs, exceptions

**CRITICAL**: Do NOT write any implementation code!

### 4. Write Integration Tests (1-2 hours)
Test integration between:
- Components and state management
- API calls and data handling
- Navigation flows
- Third-party SDK integration

### 5. Write E2E Tests (1-2 hours)
Test complete user flows:
- Critical user journeys
- Multi-step workflows
- Success and error paths

### 6. Run Tests - MUST FAIL (15 min)
```bash
npm test
```

**SUCCESS CRITERIA: ALL TESTS MUST FAIL**

Valid failure reasons:
- ✅ "Cannot find module" (component doesn't exist)
- ✅ "Function is not defined" (function doesn't exist)
- ✅ "ReferenceError" (code doesn't exist)

**INVALID failure reasons:**
- ❌ "Expected X but got Y" (means you implemented something!)
- ❌ Logic errors (means code exists)

### 7. Verify Test Quality (10 min)
Check that tests are:
- **Descriptive**: Clear test names
- **Focused**: One assertion per test (generally)
- **Independent**: No test dependencies
- **Complete**: All scenarios covered

## Deliverables
- Test files for all components/modules
- Unit test suite (fully failing)
- Integration test suite (fully failing)
- E2E test suite (fully failing)
- Test coverage configuration
- Test Report showing ALL tests failing
- Failure reason analysis

**Test Report Format:**
```markdown
# Phase 5a: TDD RED - Test Report

## Tests Written: 53
## Tests Passing: 0 ❌ (Expected!)
## Tests Failing: 53 ✅ (All fail for right reason)

## Failure Breakdown:
- Module not found: 45 tests ✅
- Function not defined: 8 tests ✅
- Implementation errors: 0 tests ✅

## Coverage Goals:
- Target: 85%
- Current: 0% (no code yet)

## Ready for Phase 5b: ✅ YES
```

## Approval Gate
Present summary to user including:
- Number of tests written (by type)
- All tests failing confirmation
- Failure reason breakdown
- Test quality verification
- Next steps (Phase 5b: TDD GREEN)

**Valid responses:**
- `approve` → AUTO-CONTINUE to Phase 5b (Implementation)
- `reject: [reason]` → Revise tests
- `modify: [changes]` → Adjust specific tests

**BLOCKING CONDITIONS:**
- ❌ Cannot proceed if ANY test passes
- ❌ Cannot proceed if failures are logic errors
- ❌ Cannot proceed if implementation code exists

## Auto-Continue Behavior
After approval, IMMEDIATELY proceed to Phase 5b (TDD GREEN - Implementation).

## Quality Gates
**Must Pass (BLOCKING):**
- ALL tests written from test plan
- ALL tests FAIL (0 passing)
- ALL failures are "not found" errors (not logic errors)
- NO implementation code written
- Test infrastructure ready

**Should Pass:**
- Test names are descriptive
- Tests are independent
- Mocks configured correctly
- Test data prepared

## Token Awareness
- **Typical usage**: 30-50K tokens (~40K average)
- **Cumulative**: ~175K / 200K (87.5%)
- Display token usage at approval gate
- **CRITICAL WARNING**: Approaching token limit - consider handoff after Phase 5b

## Common Mistakes to Avoid
- Writing ANY implementation code (biggest violation!)
- Tests that pass (means you implemented)
- Tests with logic errors (not "not found" errors)
- Skipping test cases from plan
- Writing tests that depend on each other
- Not verifying all tests fail

## TDD Philosophy
**Why RED phase matters:**
1. **Proves tests work**: A test that never fails is useless
2. **Defines interface**: Tests define the API before coding
3. **Prevents overengineering**: Only code what tests require
4. **Builds confidence**: Passing tests in GREEN phase prove correctness

**RED → GREEN → REFACTOR is non-negotiable!**

## Example Test Structure
```typescript
// ✅ GOOD: Test written, no implementation
describe('ShareModal', () => {
  it('renders modal when open prop is true', () => {
    render(<ShareModal isOpen={true} />)
    expect(screen.getByRole('dialog')).toBeInTheDocument()
  })

  it('does not render when open prop is false', () => {
    render(<ShareModal isOpen={false} />)
    expect(screen.queryByRole('dialog')).not.toBeInTheDocument()
  })
})

// ❌ BAD: Implementation included
const ShareModal = ({ isOpen }) => {
  if (!isOpen) return null
  return <div role="dialog">Modal</div>
}
```

## References
- Project context: `.cursor/project-contexts/[project]/`
- Related phases: Phase 4 (Test Planning), Phase 5b (TDD GREEN)
- Rules: `.cursor/rules/core/tdd-workflow.mdc`
- Skills: `test-writer`
- TDD Guide: `~/.claude/plugins/marketplaces/aurafrog/aura-frog/TESTING_GUIDE.md`
