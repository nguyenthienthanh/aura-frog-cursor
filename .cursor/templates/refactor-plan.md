# Refactor Implementation Plan: {TARGET_NAME}

**Date:** {DATE}
**Target:** `{TARGET_PATH}`
**Analysis:** `{ANALYSIS_PATH}`
**Workflow ID:** {WORKFLOW_ID}

---

## 1. Overview

### Objective
{OBJECTIVE_SUMMARY}

### Scope
- **Files to Create:** {NEW_FILES_COUNT}
- **Files to Modify:** {MODIFY_FILES_COUNT}
- **Files to Delete:** {DELETE_FILES_COUNT}
- **Total Changes:** {TOTAL_CHANGES}

### Constraints
- [ ] Preserve existing behavior
- [ ] Maintain/improve test coverage
- [ ] No breaking changes to public API
- [ ] Follow project conventions

---

## 2. Target Structure

### Before
```
{BEFORE_STRUCTURE}
```

### After
```
{AFTER_STRUCTURE}
```

### File Mapping

| Before | After | Action |
|--------|-------|--------|
| {OLD_FILE_1} | {NEW_FILE_1} | {ACTION_1} |
| {OLD_FILE_2} | {NEW_FILE_2} | {ACTION_2} |
| - | {NEW_FILE_3} | Create |
| {OLD_FILE_4} | - | Delete |

---

## 3. Implementation Steps

### Phase 1: Test Preparation (TDD RED)

**Goal:** Ensure tests exist for all code paths before refactoring

| # | Step | Description | Verification |
|---|------|-------------|--------------|
| 1.1 | Run existing tests | Verify all pass | `{TEST_COMMAND}` |
| 1.2 | Check coverage | Document current | `{COVERAGE_COMMAND}` |
| 1.3 | Write tests for new structure | Prepare for extractions | Tests fail (expected) |
| 1.4 | Document test baseline | Save current state | Coverage: {COVERAGE}% |

**Deliverables:**
- [ ] Existing tests: PASS
- [ ] New tests created for: {NEW_TEST_TARGETS}
- [ ] Coverage baseline documented

---

### Phase 2: Safe Extractions (Low Risk)

**Goal:** Extract code without changing imports/exports

| # | Step | Description | Files Affected | Risk |
|---|------|-------------|----------------|------|
| 2.1 | {STEP_2_1} | {DESC_2_1} | {FILES_2_1} | Low |
| 2.2 | {STEP_2_2} | {DESC_2_2} | {FILES_2_2} | Low |
| 2.3 | {STEP_2_3} | {DESC_2_3} | {FILES_2_3} | Low |

**Checkpoint:** Run tests after each step

---

### Phase 3: Structure Changes (Medium Risk)

**Goal:** Reorganize file structure

| # | Step | Description | Files Affected | Risk |
|---|------|-------------|----------------|------|
| 3.1 | {STEP_3_1} | {DESC_3_1} | {FILES_3_1} | Medium |
| 3.2 | {STEP_3_2} | {DESC_3_2} | {FILES_3_2} | Medium |
| 3.3 | {STEP_3_3} | {DESC_3_3} | {FILES_3_3} | Medium |

**Checkpoint:** Run tests + verify imports

---

### Phase 4: API Refinements (Higher Risk)

**Goal:** Improve interfaces without breaking consumers

| # | Step | Description | Breaking? | Migration |
|---|------|-------------|-----------|-----------|
| 4.1 | {STEP_4_1} | {DESC_4_1} | {BREAKING_4_1} | {MIGRATION_4_1} |
| 4.2 | {STEP_4_2} | {DESC_4_2} | {BREAKING_4_2} | {MIGRATION_4_2} |

**Checkpoint:** Run full test suite + integration tests

---

### Phase 5: Cleanup & Optimization

**Goal:** Remove dead code, optimize performance

| # | Step | Description | Impact |
|---|------|-------------|--------|
| 5.1 | Remove deprecated code | {DEPRECATED_LIST} | -{REMOVED_LINES} lines |
| 5.2 | Add memoization | {MEMO_TARGETS} | +{PERF_IMPROVEMENT}% perf |
| 5.3 | Update documentation | JSDoc, README | Clarity |

---

## 4. Test Strategy

### Existing Tests
| Test File | Tests | Status |
|-----------|-------|--------|
| {TEST_FILE_1} | {TEST_COUNT_1} | Must pass |
| {TEST_FILE_2} | {TEST_COUNT_2} | Must pass |

### New Tests Required
| New Test | Purpose | Priority |
|----------|---------|----------|
| {NEW_TEST_1} | {PURPOSE_1} | {PRIORITY_1} |
| {NEW_TEST_2} | {PURPOSE_2} | {PRIORITY_2} |

### Coverage Targets
| Metric | Current | Target |
|--------|---------|--------|
| Line Coverage | {LINE_COV}% | >{TARGET_LINE_COV}% |
| Branch Coverage | {BRANCH_COV}% | >{TARGET_BRANCH_COV}% |
| Function Coverage | {FUNC_COV}% | >{TARGET_FUNC_COV}% |

---

## 5. Rollback Plan

### If Tests Fail
```bash
# Revert to last known good state
git checkout {BRANCH_NAME}
git reset --hard {COMMIT_HASH}
```

### Recovery Checkpoints
| Checkpoint | Commit | Description |
|------------|--------|-------------|
| Before start | {COMMIT_1} | Clean state |
| After Phase 2 | {COMMIT_2} | Safe extractions |
| After Phase 3 | {COMMIT_3} | Structure changes |
| After Phase 4 | {COMMIT_4} | API refinements |

---

## 6. Risk Mitigation

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| Breaking changes | {PROB_1} | {IMPACT_1} | {MITIGATION_1} |
| Test gaps | {PROB_2} | {IMPACT_2} | {MITIGATION_2} |
| Performance regression | {PROB_3} | {IMPACT_3} | {MITIGATION_3} |

---

## 7. Approval Checklist

### Before Starting
- [ ] Analysis document reviewed
- [ ] Plan reviewed by tech lead
- [ ] Test coverage adequate
- [ ] Rollback plan understood

### After Completion
- [ ] All tests passing
- [ ] Coverage targets met
- [ ] Documentation updated
- [ ] PR created for review

---

## 8. Commands Reference

```bash
# Start refactoring workflow
/misc:refactor {TARGET_PATH}

# Run tests
{TEST_COMMAND}

# Check coverage
{COVERAGE_COMMAND}
```

---

**Generated:** {TIMESTAMP}
**Agent:** {AGENT_NAME}
**Based on:** `{ANALYSIS_PATH}`
**Document:** `{OUTPUT_PATH}`
