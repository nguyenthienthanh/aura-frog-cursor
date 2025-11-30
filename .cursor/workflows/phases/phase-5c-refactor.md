# Phase 5c: TDD REFACTOR (Code Polish)

## Purpose
Improve code quality, eliminate duplication, enhance readability, and optimize performance while ensuring ALL tests still pass.

## Prerequisites
- Phase 5b (TDD GREEN) completed and approved
- ALL tests passing
- Coverage ≥80%
- Implementation complete

## Inputs
- Working implementation from Phase 5b
- Passing test suite
- Coverage report
- Project code quality standards

## Execution Steps

### 1. Review Current Code (15 min)
Identify opportunities for:
- Code duplication (DRY violations)
- Complex functions (split into smaller)
- Magic numbers/strings (extract constants)
- Poor naming (improve clarity)
- Missing abstractions (apply Rule of Three)
- Performance improvements

### 2. Refactor for Clarity (1-2 hours)
**Improve readability:**
- Extract complex conditions into named functions
- Split large functions (>50 lines)
- Improve variable/function names
- Add inline documentation for complex logic
- Simplify nested conditionals

**Run tests after each change!**

### 3. Eliminate Duplication (30-60 min)
**Apply DRY principle (Rule of Three):**
- Extract repeated code into functions
- Create shared utilities
- Extract common patterns
- Create reusable components

**CAUTION:** Only abstract after 3+ repetitions!

### 4. Performance Optimization (30-60 min)
**Optimize where needed:**
- Memoize expensive calculations
- Optimize re-renders (React.memo, useMemo)
- Lazy load heavy components
- Debounce user inputs
- Optimize loops and iterations

**Only optimize actual bottlenecks!**

### 5. Code Quality Improvements (30-45 min)
- Ensure consistent formatting
- Remove commented code
- Remove unused imports
- Fix linter warnings
- Improve error messages
- Add PropTypes/TypeScript refinements

### 6. Continuous Testing (ongoing)
```bash
# Keep tests running during refactor
npm test -- --watch

# After each refactor:
# ✅ Verify all tests still pass
# ✅ Verify coverage remains ≥80%
# ❌ If tests fail → revert and try different approach
```

### 7. Final Verification (15 min)
Confirm:
- ✅ All tests passing
- ✅ Coverage ≥80% (should not decrease)
- ✅ No linter errors/warnings
- ✅ Code is more readable
- ✅ No new bugs introduced
- ✅ Performance improved or unchanged

## Deliverables
- Refactored code (cleaner, more maintainable)
- Test suite (still ALL passing ✅)
- Coverage report (maintained or improved)
- Refactoring summary document

**Refactoring Report Format:**
```markdown
# Phase 5c: TDD REFACTOR - Summary

## Tests Status: 53/53 Passing ✅
## Coverage: 89% ✅ (was 87%)

## Refactorings Applied:

### 1. Extract Utility Functions
- Extracted `validateEmail` from ShareModal
- Extracted `formatPlatformName` from PlatformSelector
- Benefits: Reduced duplication, improved testability

### 2. Improve Naming
- `fn` → `handleSubmit`
- `data` → `shareFormData`
- Benefits: Improved code clarity

### 3. Split Large Component
- Split `ShareModal` (200 lines) into:
  - `ShareModal` (80 lines)
  - `ShareForm` (60 lines)
  - `PlatformOptions` (40 lines)
- Benefits: Better separation of concerns

### 4. Performance Optimizations
- Memoized `sharePostMutation` with useMemo
- Added React.memo to PlatformSelector
- Benefits: Reduced unnecessary re-renders

### 5. Code Cleanup
- Removed 3 unused imports
- Removed 2 console.log statements
- Fixed 5 linter warnings
- Benefits: Cleaner codebase

## Metrics:
- Lines of code: 450 → 420 (6% reduction)
- Cyclomatic complexity: 15 → 10 (33% improvement)
- Duplication: 8% → 2%

## Ready for Phase 6: ✅ YES
```

## Approval Gate
Present summary to user including:
- Refactorings applied
- Code quality improvements
- Tests still passing confirmation
- Coverage maintained/improved
- Next steps (Phase 6: Code Review)

**Valid responses:**
- `approve` → AUTO-CONTINUE to Phase 6 (Review)
- `reject: [reason]` → Revert and try different approach
- `modify: [changes]` → Additional refactoring

**BLOCKING CONDITIONS:**
- ❌ Cannot proceed if ANY test fails
- ❌ Cannot proceed if coverage decreased
- ❌ Cannot proceed if new linter errors

## Auto-Continue Behavior
After approval, IMMEDIATELY proceed to Phase 6 (Code Review).

## Quality Gates
**Must Pass (BLOCKING):**
- ALL tests still passing
- Coverage maintained (≥80%)
- No new linter errors
- No regressions introduced
- Code compiles successfully

**Should Pass:**
- Coverage improved
- Code complexity reduced
- Duplication reduced
- Performance improved
- Readability improved

## Token Awareness
- **Typical usage**: 25-50K tokens (~35K average)
- **Cumulative**: ~265K / 200K (132.5%) - **EXCEEDS LIMIT!**
- **CRITICAL**: Very likely to exceed token limit
- **Recommendation**: Use `workflow:handoff` after Phase 5b, resume for 5c

## Common Mistakes to Avoid
- Refactoring without running tests
- Premature abstraction (violates Rule of Three)
- Over-optimization (YAGNI principle)
- Changing behavior (refactoring should not change functionality)
- Adding new features (that's not refactoring!)
- Decreasing test coverage
- Introducing new dependencies unnecessarily

## Rule of Three (DRY with Caution)
**When to abstract:**
```
1st time: Write it
2nd time: Wince and duplicate
3rd time: Refactor and extract

✅ After 3+ repetitions → Abstract
❌ After 1-2 repetitions → Keep duplicated
```

**Why?** Premature abstraction is worse than duplication!

## Refactoring Patterns

### Extract Function
```typescript
// Before
const isValid = email.includes('@') && email.includes('.') && email.length > 5

// After
const isValidEmail = (email: string) =>
  email.includes('@') && email.includes('.') && email.length > 5

const isValid = isValidEmail(email)
```

### Extract Constant
```typescript
// Before
if (text.length > 500) { ... }

// After
const MAX_CAPTION_LENGTH = 500
if (text.length > MAX_CAPTION_LENGTH) { ... }
```

### Simplify Conditional
```typescript
// Before
if (platform === 'facebook' || platform === 'instagram') {
  if (caption.length > 0 && caption.length <= 500) {
    return true
  }
}
return false

// After
const isSocialPlatform = ['facebook', 'instagram'].includes(platform)
const isValidCaption = caption.length > 0 && caption.length <= 500
return isSocialPlatform && isValidCaption
```

### Split Component
```typescript
// Before: ShareModal (200 lines, too large)
const ShareModal = () => {
  // 200 lines of mixed concerns
}

// After: Split into smaller components
const ShareModal = () => <Dialog><ShareForm /></Dialog>
const ShareForm = () => <form><PlatformSelector /><CaptionInput /></form>
const PlatformSelector = () => { ... }
const CaptionInput = () => { ... }
```

## References
- Project context: `.cursor/project-contexts/[project]/`
- Related phases: Phase 5b (TDD GREEN), Phase 6 (Review)
- Rules: `.cursor/rules/core/tdd-workflow.mdc`, `.cursor/rules/core/dry-with-caution.mdc`
- Skills: `refactor-expert`, `performance-optimizer`
