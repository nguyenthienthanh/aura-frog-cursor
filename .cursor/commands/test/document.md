# /test:document - Generate comprehensive test documentation from requirements or ticket

## Description

Generate comprehensive test documentation from requirements or ticket

**Original command:** `test:document`

## Usage

```
/test:document [arguments]
```

## Execution Steps

1. Load command configuration
2. Execute command logic
3. Return results

## Examples

1: From Description

```
User: test:document "User can login with email and password, reset password if forgotten, and stay logged in with remember me"

AI:
Phase 1: Analyzing requirement... ✅
- 3 user stories identified
- 8 acceptance criteria
- 15 test scenarios

Phase 2: Generating test cases... ✅
- TC-001 to TC-015 created
- Positive, negative, edge cases covered

Phase 3: Creating test matrix... ✅
- Requirements 100% covered
- iOS and Android covered

Phase 4: Generating automated tests... ✅
- 5 test files created
- 800+ lines of test code

Phase 5: Creating test plan... ✅
- 15-page test plan document

Phase 6: Assembling final doc... ✅
- Master document ready (50+ pages)

✅ Complete test documentation generated!
```

## References

- Original Aura Frog command: `test:document`
- Project context: `.claude/project-contexts/[project]/`
- Workflow state: `.claude/logs/workflows/`

## Notes

This command has been converted from Aura Frog format to Cursor slash command format.
All functionality from the original command is preserved.

---

**Source:** Aura Frog v1.0.0
**Converted:** 2025-11-30
