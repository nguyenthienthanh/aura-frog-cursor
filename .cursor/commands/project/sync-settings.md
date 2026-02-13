# /project:sync-settings

## Description

Sync Cursor IDE settings from template to project. Ensures `.cursor/settings.json` matches the recommended configuration for Aura Frog.

## Usage

```
/project:sync-settings
```

## What Gets Synced

- MCP server configurations
- Rule activation settings
- Agent configurations
- Workflow preferences

## Process

1. Read `.cursor/settings.example.json` (template)
2. Read current `.cursor/settings.json` (if exists)
3. Merge: template values fill missing settings, existing values preserved
4. Write updated `.cursor/settings.json`

## Related Commands

- `/project:config` - View/update project config
- `/setup:activate` - Initial setup activation

---

**Source:** Aura Frog v1.11.0
**Created:** 2026-02-13
