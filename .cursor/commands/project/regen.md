# /project:regen - Regenerate Project Context

## Description

Regenerates project context files while preserving user customizations. Updates Aura Frog system files to latest version without losing project-specific settings.

**What it does:**
1. Re-detects project type and tech stack
2. Updates `.cursor/project-contexts/[project]/` files
3. Preserves user-added rules and conventions
4. Syncs with latest Aura Frog version

## Usage

```
/project:regen
```

## What Gets Updated

| File | On Regen |
|------|----------|
| `.cursorrules` | **NOT touched** (copy manually if needed) |
| `project-config.yaml` | Updated with new tech stack |
| `conventions.md` | Merged (user additions preserved) |
| `rules.md` | Merged (user additions preserved) |

## What Gets Preserved

- Project-specific conventions in `conventions.md`
- Custom rules in `rules.md`
- Any user-added files in `project-contexts/`

## Execution Steps

1. **Re-detect project** - Scan for framework, tech stack changes
2. **Read existing context** - Get current project-contexts files
3. **Merge changes** - Update system parts, keep user parts
4. **Write back** - Save merged files

## When to Use

- After updating Aura Frog version
- When project tech stack changes
- To pick up new MCP server configurations

## Related Commands

- `/project:init` - First-time project initialization
- `/project:detect` - Just re-detect tech stack (no file changes)

## Notes

- **Safe**: User customizations are always preserved
- **Banner format**: Always references `.cursor/rules/core/agent-identification.mdc`
- **MCP config**: Check `.cursor/mcp.json` for server updates

---

**Source:** Aura Frog v1.2.0
**Updated:** 2025-12-22
