# /project:switch - project:switch

## Description

Command from Aura Frog workflow system

**Original command:** `project:switch`

## Usage

```
/project:switch [arguments]
```

## Execution Steps

1. Load project configuration from ccpm-config.yaml
2. Update active project context
3. Load project-specific conventions
4. Activate project-specific agents

---

## Examples

```bash
/project:switch my-mobile-app
/project:switch my-web-app
```

---

## References

- Original Aura Frog command: `project:switch`
- Project context: `.cursor/project-contexts/[project]/`
- Workflow state: `.cursor/logs/workflows/`

## Notes

This command has been converted from Aura Frog format to Cursor slash command format.
All functionality from the original command is preserved.

---

**Source:** Aura Frog v1.2.0
**Converted:** 2025-11-30
