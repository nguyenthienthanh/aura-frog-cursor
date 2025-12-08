# /review:fix - Auto-fix code review issues from Phase 6  

## Description

Auto-fix code review issues from Phase 6  

**Original command:** `review:fix`

## Usage

```
/review:fix [arguments]
```

## Execution Steps

1. Load command configuration
2. Execute command logic
3. Return results

## Examples

1: Fix All Auto-Fixable

```bash
review:fix

# Output:
# Analyzing 9 issues...
# ✅ Can fix: 6 issues
# ⚠️ Manual: 3 issues
#
# Applying fixes...
# ✅ Fixed M-001
# ✅ Fixed m-002
# ✅ Fixed m-003
# ...
#
# Quality: 8.5/10 → 9.2/10
```

## References

- Original Aura Frog command: `review:fix`
- Project context: `.cursor/project-contexts/[project]/`
- Workflow state: `.cursor/logs/workflows/`

## Notes

This command has been converted from Aura Frog format to Cursor slash command format.
All functionality from the original command is preserved.

---

**Source:** Aura Frog v1.1.4
**Converted:** 2025-11-30
