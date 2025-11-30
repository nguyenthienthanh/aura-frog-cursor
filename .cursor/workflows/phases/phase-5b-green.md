# Phase 5b: TDD GREEN (Implementation)

## Purpose
Implement ONLY enough code to make all failing tests pass. This is the GREEN phase of Test-Driven Development.

## Prerequisites
- Phase 5a (TDD RED) completed and approved
- ALL tests written and failing
- Test failures are "not found" errors (not logic errors)
- NO implementation code exists yet

## Inputs
- Failing test suite from Phase 5a
- Technical Design Document from Phase 2
- UI Breakdown Document from Phase 3 (if applicable)
- Project conventions from `.cursor/project-contexts/[project]/`

## Execution Steps

### 1. Review Failing Tests (10 min)
- Understand what each test expects
- Review test failure messages
- Plan implementation order
- Identify dependencies between modules

### 2. Implement Code (3-6 hours)
**Implementation order:**
1. **Types/Interfaces** → Define data structures
2. **Utilities** → Helper functions
3. **Hooks** → Custom React hooks
4. **Components** → UI components (simple → complex)
5. **Integration** → Wire everything together

**For each module:**
- Write MINIMAL code to pass tests
- Run tests frequently (`npm test --watch`)
- Follow project conventions strictly
- Apply KISS principle (no over-engineering)

### 3. Make Tests Pass (iterative)
```bash
# Run tests in watch mode
npm test -- --watch

# For each failing test:
# 1. Read test expectation
# 2. Write minimal code to pass
# 3. Verify test passes
# 4. Move to next failing test
```

**Success criteria:** ALL tests PASS ✅

### 4. Verify Implementation (15 min)
Check that:
- ✅ All tests passing (0 failures)
- ✅ Code follows project conventions
- ✅ Types properly defined (no `any`)
- ✅ Error handling implemented
- ✅ No commented code
- ✅ No console.logs
- ✅ No hardcoded values

### 5. Run Full Test Suite (10 min)
```bash
# Run all tests
npm test

# Check coverage
npm test -- --coverage

# Verify coverage meets goals (80% minimum)
```

### 6. Manual Testing (15 min)
- Test in development environment
- Verify UI renders correctly
- Test user interactions
- Check error states
- Verify edge cases

## Deliverables
- Implementation code (all components/modules)
- Test suite (ALL passing ✅)
- Coverage report (≥80%)
- Type definitions
- Test Report showing all tests passing

**Test Report Format:**
```markdown
# Phase 5b: TDD GREEN - Test Report

## Tests Passing: 53 ✅
## Tests Failing: 0 ✅
## Coverage: 87% ✅ (Goal: 80%)

## Coverage Breakdown:
- Statements: 87%
- Branches: 85%
- Functions: 90%
- Lines: 87%

## Implementation Complete:
- ✅ ShareModal component
- ✅ PlatformSelector component
- ✅ useSharePost hook
- ✅ shareApi module

## Ready for Phase 5c: ✅ YES
```

## Approval Gate
Present summary to user including:
- All tests passing confirmation
- Coverage report (must meet goal)
- Implementation completeness
- Code quality verification
- Next steps (Phase 5c: TDD REFACTOR)

**Valid responses:**
- `approve` → AUTO-CONTINUE to Phase 5c (Refactor)
- `reject: [reason]` → Fix implementation
- `modify: [changes]` → Adjust specific code

**BLOCKING CONDITIONS:**
- ❌ Cannot proceed if ANY test fails
- ❌ Cannot proceed if coverage below goal (default 80%)
- ❌ Cannot proceed if linter errors exist

## Auto-Continue Behavior
After approval, IMMEDIATELY proceed to Phase 5c (TDD REFACTOR - Code Polish).

## Quality Gates
**Must Pass (BLOCKING):**
- ALL tests passing (0 failures)
- Coverage ≥80% (or project-defined goal)
- No linter errors
- No TypeScript errors
- Code follows project conventions
- Error handling implemented

**Should Pass:**
- Coverage ≥85%
- All types defined (no `any`)
- No code smells
- No hardcoded values
- Proper logging

## Token Awareness
- **Typical usage**: 40-80K tokens (~55K average)
- **Cumulative**: ~230K / 200K (115%) - **EXCEEDS LIMIT!**
- **CRITICAL**: This phase may exceed 200K token limit
- **Action**: Consider `workflow:handoff` before this phase if already at 150K+

## Common Mistakes to Avoid
- Over-implementing (adding features not tested)
- Ignoring project conventions
- Using `any` types
- Skipping error handling
- Not running tests frequently
- Hardcoding values
- Leaving debug code (console.logs)
- Not checking coverage

## KISS Principle Application
**During implementation:**
- ✅ Write simplest code to pass tests
- ✅ Use standard patterns from project
- ✅ Avoid premature optimization
- ✅ Don't add "nice to have" features

**Avoid:**
- ❌ Complex abstractions
- ❌ Custom utility libraries
- ❌ Over-configuration
- ❌ Features not in tests

## Code Quality Checklist
Before requesting approval:
- [ ] All tests passing
- [ ] Coverage ≥80%
- [ ] No linter warnings
- [ ] No TypeScript errors
- [ ] Types defined (no `any`)
- [ ] Error handling complete
- [ ] No console.logs
- [ ] No commented code
- [ ] Follows project conventions
- [ ] KISS principle applied

## Example Implementation
```typescript
// ✅ GOOD: Minimal code to pass tests
interface ShareModalProps {
  isOpen: boolean
  onClose: () => void
  onSubmit: (data: ShareData) => void
}

export const ShareModal: React.FC<ShareModalProps> = ({
  isOpen,
  onClose,
  onSubmit
}) => {
  if (!isOpen) return null

  const [platform, setPlatform] = useState<Platform>('facebook')
  const [caption, setCaption] = useState('')

  const handleSubmit = () => {
    onSubmit({ platform, caption })
  }

  return (
    <Dialog role="dialog">
      <PlatformSelector value={platform} onChange={setPlatform} />
      <Input label="Caption" value={caption} onChange={setCaption} />
      <Button onClick={handleSubmit}>Post</Button>
    </Dialog>
  )
}

// ❌ BAD: Over-engineered
// - Added features not in tests
// - Custom abstraction layer
// - Unnecessary complexity
```

## References
- Project context: `.cursor/project-contexts/[project]/`
- Related phases: Phase 5a (TDD RED), Phase 5c (TDD REFACTOR)
- Rules: `.cursor/rules/core/tdd-workflow.mdc`, `.cursor/rules/core/kiss-principle.mdc`
- Code quality: `.cursor/rules/core/code-quality.mdc`
