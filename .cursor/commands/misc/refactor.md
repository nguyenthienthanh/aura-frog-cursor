# /misc:refactor - Refactor code with structured workflow (analyze → plan → test → refactor → verify)

## Description

Refactor code with structured workflow (analyze → plan → test → refactor → verify)

**Original command:** `refactor`

## Usage

```
/misc:refactor [arguments]
```

## Execution Steps

1. Load command configuration
2. Execute command logic
3. Return results

## Examples

1: Refactor Large Component

```
User: refactor src/components/SocialMarketingCompositePost.phone.tsx

AI:
1. Analyzes component (683 lines)
2. Identifies: too large, complex logic, hardcoded values
3. Plans: split into 5 components, extract custom hook
4. Writes tests for new structure
5. Refactors code
6. Optimizes performance
7. Reviews code
8. Validates
9. Documents
```

## References

- Original Aura Frog command: `refactor`
- Project context: `.claude/project-contexts/[project]/`
- Workflow state: `.claude/logs/workflows/`

## Notes

This command has been converted from Aura Frog format to Cursor slash command format.
All functionality from the original command is preserved.

---

**Source:** Aura Frog v1.1.4
**Converted:** 2025-11-30
