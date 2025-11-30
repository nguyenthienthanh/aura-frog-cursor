# Phase 6: Review (Code Quality Check)

## Purpose
Perform comprehensive code review, run quality checks, ensure security, and verify all standards are met before QA validation.

## Prerequisites
- Phase 5c (TDD REFACTOR) completed and approved
- All tests passing
- Code refactored and polished
- Code review agent or developer agent active

## Inputs
- Complete implementation from Phase 5c
- Test suite (all passing)
- Coverage report
- Project code quality standards

## Execution Steps

### 1. Self-Review Checklist (15 min)
Developer reviews own code for:
- [ ] Code follows project conventions
- [ ] All functions/components have clear names
- [ ] Complex logic is documented
- [ ] No commented-out code
- [ ] No debug statements (console.log)
- [ ] No hardcoded values
- [ ] Error handling complete
- [ ] Types properly defined (no `any`)

### 2. Automated Quality Checks (10 min)
Run all quality tools:

```bash
# Linter
npm run lint

# TypeScript compiler
npm run type-check

# Tests
npm test

# Coverage
npm test -- --coverage

# Security audit
npm audit

# Format check
npm run format:check
```

**All must pass with 0 errors/warnings!**

### 3. Security Review (15 min)
Check for:
- No secrets in code
- No SQL injection vulnerabilities
- No XSS vulnerabilities
- Input validation present
- Authentication/authorization correct
- Sensitive data encrypted
- Dependencies up to date

### 4. Performance Review (15 min)
Verify:
- No unnecessary re-renders
- Expensive operations memoized
- Images optimized
- Lazy loading where appropriate
- No memory leaks
- Efficient data structures

### 5. Cross-Agent Review (20 min)
Code reviewed by:
- **Secondary Dev Agent**: Code quality, architecture, patterns
- **QA Agent**: Testability, edge case coverage
- **Security Expert** (if applicable): Security vulnerabilities

Each agent provides review checklist.

### 6. Code Quality Metrics (10 min)
Generate and review:
- Cyclomatic complexity (should be low)
- Code duplication percentage (should be <5%)
- Test coverage (should be ≥80%)
- Lines of code added/modified
- Technical debt score

### 7. Documentation Check (10 min)
Verify:
- Complex functions documented
- Public APIs documented
- Type definitions complete
- README updated (if needed)
- Inline comments for non-obvious logic

## Deliverables
- Self-review checklist (completed)
- Linter report (0 errors/warnings)
- Security audit report (no critical issues)
- Performance review summary
- Secondary dev review checklist
- QA review checklist
- Security review checklist (if applicable)
- Code quality metrics report

**Review Report Format:**
```markdown
# Phase 6: Code Review - Summary

## Automated Checks: ✅ All Passing

### Linter
- Errors: 0 ✅
- Warnings: 0 ✅

### TypeScript
- Errors: 0 ✅
- Strict mode: Enabled ✅

### Tests
- Passing: 53/53 ✅
- Coverage: 89% ✅

### Security
- Critical: 0 ✅
- High: 0 ✅
- Medium: 0 ✅

## Cross-Agent Reviews: ✅ 2 Approved

### Dev Review (mobile-react-native-secondary)
**Status:** ✅ Approved
- Code quality: Excellent
- Architecture: Sound
- Patterns: Consistent
- KISS principle: Applied
**Concerns:** None

### QA Review (qa-automation)
**Status:** ✅ Approved
- Testability: Excellent
- Coverage: Sufficient (89%)
- Edge cases: Well covered
- Automation: Feasible
**Concerns:** None

## Code Quality Metrics:
- Cyclomatic complexity: 8 (Good)
- Duplication: 2% (Excellent)
- Coverage: 89% (Excellent)
- Lines added: 420
- Technical debt: Low

## Ready for Phase 7: ✅ YES
```

## Approval Gate
Present summary to user including:
- All automated checks passing
- Cross-review results
- Code quality metrics
- Any concerns or recommendations
- Next steps (Phase 7: QA Validation)

**Valid responses:**
- `approve` → AUTO-CONTINUE to Phase 7 (Verify)
- `reject: [reason]` → Fix issues and re-review
- `modify: [changes]` → Address specific concerns

**BLOCKING CONDITIONS:**
- ❌ Cannot proceed with linter errors
- ❌ Cannot proceed with test failures
- ❌ Cannot proceed with critical security issues
- ❌ Cannot proceed without cross-review approval

## Auto-Continue Behavior
After approval, IMMEDIATELY proceed to Phase 7 (Verify - QA Validation).

## Quality Gates
**Must Pass (BLOCKING):**
- Linter: 0 errors, 0 warnings
- Tests: 100% passing
- Coverage: ≥80%
- Security: No critical/high vulnerabilities
- Cross-reviews: All approved
- TypeScript: No errors

**Should Pass:**
- Coverage: ≥85%
- Cyclomatic complexity: <10 per function
- Duplication: <5%
- Documentation: Complete

## Token Awareness
- **Typical usage**: 20-40K tokens (~30K average)
- **Cumulative**: ~295K / 200K (147.5%) - **EXCEEDS LIMIT!**
- **Recommendation**: Session should have been handed off earlier

## Common Mistakes to Avoid
- Skipping automated checks
- Ignoring linter warnings
- Not running full test suite
- Missing security review
- Skipping cross-review
- Approving with known issues
- Not documenting complex logic

## Review Checklist Template

### Code Quality
- [ ] Follows project conventions
- [ ] KISS principle applied
- [ ] DRY applied appropriately (Rule of Three)
- [ ] No code smells
- [ ] Clear naming
- [ ] Proper error handling

### Testing
- [ ] All tests passing
- [ ] Coverage ≥80%
- [ ] Edge cases tested
- [ ] Error cases tested
- [ ] Integration tested

### Security
- [ ] No secrets in code
- [ ] Input validation
- [ ] XSS prevention
- [ ] No vulnerable dependencies
- [ ] Authentication correct

### Performance
- [ ] No unnecessary re-renders
- [ ] Memoization where needed
- [ ] Lazy loading applied
- [ ] Efficient algorithms

### Documentation
- [ ] Complex logic documented
- [ ] Public APIs documented
- [ ] Type definitions complete
- [ ] README updated

## Cross-Review Guidelines

### Secondary Dev Reviews For:
- Architecture soundness
- Code quality
- Pattern consistency
- KISS principle compliance
- Potential bugs
- Performance issues

### QA Reviews For:
- Test coverage adequacy
- Edge case coverage
- Automation feasibility
- Test quality
- Missing scenarios

### Security Reviews For:
- Security vulnerabilities
- Authentication/authorization
- Data encryption
- Input validation
- Dependency security

## References
- Project context: `.cursor/project-contexts/[project]/`
- Related phases: Phase 5c (Refactor), Phase 7 (Verify)
- Rules: `.cursor/rules/core/code-quality.mdc`, `.cursor/rules/core/cross-review-workflow.mdc`
- Skills: `code-reviewer`, `security-expert`
