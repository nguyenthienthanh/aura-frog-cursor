# Phase 7: Verify (QA Validation)

## Purpose
Run complete test suite, validate all acceptance criteria, verify edge cases, and confirm feature works as specified.

## Prerequisites
- Phase 6 (Review) completed and approved
- Code review passed
- All automated checks passing
- QA automation agent active

## Inputs
- Complete implementation
- Test suite (all passing)
- Requirements Analysis Document (Phase 1)
- Acceptance criteria from user stories
- Edge cases list

## Execution Steps

### 1. Review Acceptance Criteria (10 min)
- Read all user stories from Phase 1
- List all acceptance criteria
- Understand expected behavior
- Note edge cases to verify

### 2. Run Full Test Suite (10 min)
```bash
# Run all tests with coverage
npm test -- --coverage

# Verify all tests pass
# Verify coverage ≥80%
# Check for flaky tests
```

Expected results:
- ✅ All unit tests passing
- ✅ All integration tests passing
- ✅ All E2E tests passing
- ✅ Coverage ≥80%
- ✅ No flaky tests

### 3. Acceptance Criteria Validation (30 min)
For each user story:
- [ ] Verify each acceptance criterion
- [ ] Test manually if needed
- [ ] Document results
- [ ] Mark as passed/failed

Use traceability matrix from Phase 1.

### 4. Edge Case Testing (20 min)
Test all edge cases identified in Phase 1:
- Boundary conditions
- Empty states
- Null/undefined values
- Network failures
- Permission denials
- Concurrent operations

### 5. Exploratory Testing (20 min)
Try to break the feature:
- Unexpected user actions
- Rapid interactions
- Large data sets
- Long text inputs
- Special characters
- Different device sizes

### 6. Performance Testing (15 min)
Verify:
- Page load time acceptable
- No UI freezing
- Smooth animations
- Quick API responses
- Memory usage normal

### 7. Accessibility Testing (15 min)
Verify:
- Screen reader compatible
- Keyboard navigation works
- Color contrast sufficient (WCAG AA)
- Touch targets ≥44x44pt
- Focus management correct

### 8. Test Report Creation (10 min)
Document all testing results.

## Deliverables
- Test execution report (all tests passing)
- Coverage report (≥80%)
- Acceptance criteria validation (all passed)
- Edge case testing results
- Exploratory testing findings
- Performance test results
- Accessibility test results
- Bug list (if any found)

**QA Report Format:**
```markdown
# Phase 7: QA Validation - Report

## Test Execution: ✅ All Passing

### Automated Tests
- Unit tests: 35/35 passing ✅
- Integration tests: 15/15 passing ✅
- E2E tests: 3/3 passing ✅
- Coverage: 89% ✅ (Goal: 80%)

## Acceptance Criteria: ✅ All Validated

### US-1: Share to Facebook Feed
- [✅] User can select "Share to Facebook" option
- [✅] User can preview post before sharing
- [✅] User can customize message (max 500 chars)
- [✅] System auto-includes success story image
- [✅] Post includes tracking link back to app
- [✅] User sees success confirmation after post

### US-2: Share to Instagram Stories
- [✅] User can select "Share to Instagram Stories"
- [✅] System generates story-sized image (1080x1920)
- [✅] User can add stickers/text overlay
- [✅] User can preview story before sharing
- [✅] Deep link to app included in story

## Edge Cases: ✅ All Tested

- [✅] EC-1: No Internet Connection → Correct error shown
- [✅] EC-2: Facebook Not Logged In → Login prompt works
- [✅] EC-3: Image Too Large → Auto-compression works

## Exploratory Testing: ✅ No Issues Found

Tested scenarios:
- Rapid button clicking → Handled correctly
- Very long captions → Validation works
- Special characters → Rendered correctly
- App backgrounding → State preserved

## Performance: ✅ Acceptable

- Share modal opens: <100ms ✅
- Image upload: <2s on 4G ✅
- API response: <500ms ✅
- No memory leaks ✅

## Accessibility: ✅ Compliant

- [✅] Screen reader support (VoiceOver tested)
- [✅] Keyboard navigation
- [✅] Color contrast WCAG AA
- [✅] Touch targets ≥44pt
- [✅] Focus management

## Bugs Found: 0 🎉

## Ready for Phase 8: ✅ YES
```

## Approval Gate
Present summary to user including:
- All tests passing
- All acceptance criteria validated
- Edge cases tested
- Performance acceptable
- Accessibility compliant
- Any bugs found (should be 0)
- Next steps (Phase 8: Documentation)

**Valid responses:**
- `approve` → AUTO-CONTINUE to Phase 8 (Document)
- `reject: [reason]` → Fix issues and re-verify
- `bugs: [list]` → Document bugs, may need to return to Phase 5

**BLOCKING CONDITIONS:**
- ❌ Cannot proceed with failing tests
- ❌ Cannot proceed with unvalidated acceptance criteria
- ❌ Cannot proceed with critical bugs
- ❌ Cannot proceed with coverage <80%

## Auto-Continue Behavior
After approval, IMMEDIATELY proceed to Phase 8 (Document).

## Quality Gates
**Must Pass (BLOCKING):**
- All tests passing (100%)
- Coverage ≥80%
- All acceptance criteria validated
- No critical/high bugs
- No flaky tests

**Should Pass:**
- Coverage ≥85%
- All edge cases tested
- Performance acceptable
- Accessibility compliant
- No medium bugs

## Token Awareness
- **Typical usage**: 15-35K tokens (~25K average)
- **Cumulative**: ~320K / 200K (160%) - **EXCEEDS LIMIT!**
- **Note**: Should have used handoff strategy

## Common Mistakes to Avoid
- Not running full test suite
- Skipping manual validation
- Ignoring edge cases
- Not testing accessibility
- Missing performance checks
- Accepting bugs to "fix later"
- Not documenting test results

## Acceptance Criteria Validation

### Validation Checklist
For each criterion:
1. [ ] Understand expected behavior
2. [ ] Run automated test (if exists)
3. [ ] Perform manual test
4. [ ] Verify result matches expectation
5. [ ] Document result
6. [ ] Mark as passed/failed

### Validation Methods
- **Automated**: Run test suite
- **Manual**: Test in dev environment
- **Visual**: Screenshot comparison
- **Performance**: Measure metrics
- **Accessibility**: Tool + manual check

## Bug Classification

### Critical
- App crashes
- Data loss
- Security vulnerability
- Complete feature failure

**Action:** BLOCK release, return to Phase 5

### High
- Major feature broken
- Significant UX issue
- Performance severely degraded

**Action:** BLOCK release, return to Phase 5

### Medium
- Minor feature issue
- Small UX problem
- Acceptable workaround exists

**Action:** Document, may continue or fix

### Low
- Visual inconsistency
- Minor text issue
- Enhancement request

**Action:** Document, continue to Phase 8

## References
- Project context: `.cursor/project-contexts/[project]/`
- Related phases: Phase 6 (Review), Phase 8 (Document)
- Requirements: Phase 1 deliverables
- Rules: `.cursor/rules/core/qa-standards.mdc`
- Skills: `test-writer`
