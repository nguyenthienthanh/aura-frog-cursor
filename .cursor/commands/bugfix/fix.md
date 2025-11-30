# /bugfix:fix - Fix bugs with structured workflow (analyze → plan → fix → test → verify)

## Description

Fix bugs with structured workflow (analyze → plan → fix → test → verify)

**Original command:** `bugfix`

## Usage

```
/bugfix:fix [arguments]
```

## Execution Steps

1. Load command configuration
2. Execute command logic
3. Return results

## Examples

1: Simple Bug Fix

```
User: bugfix Users cannot login with email

AI:
1. Analyzes login code
2. Identifies root cause (email validation regex)
3. Plans fix
4. Writes failing test
5. Implements fix
6. Tests pass
7. Refactors
8. Reviews code
9. Documents
10. Notifies team
```

## References

- Original Aura Frog command: `bugfix`
- Project context: `.claude/project-contexts/[project]/`
- Workflow state: `.claude/logs/workflows/`

## Notes

This command has been converted from Aura Frog format to Cursor slash command format.
All functionality from the original command is preserved.

---

**Source:** Aura Frog v1.0.0
**Converted:** 2025-11-30
