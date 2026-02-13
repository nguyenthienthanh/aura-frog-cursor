# /project:config

## Description

View or update project configuration settings. Shows current config from `project-config.yaml` and allows modification of key settings.

## Usage

```
/project:config                    # View current config
/project:config set key value      # Set a config value
```

## Configuration Keys

| Key | Description | Example |
|-----|-------------|---------|
| `primary_agent` | Default agent for this project | `web-nextjs` |
| `main_branch` | Git main branch name | `main` |
| `test_framework` | Test runner to use | `vitest` |
| `package_manager` | Package manager | `pnpm` |

## Config File

Located at: `.claude/project-contexts/[project-name]/project-config.yaml`

## Related Commands

- `/project:status` - View detection results
- `/project:refresh` - Re-detect project settings
- `/project:init` - Full initialization

---

**Source:** Aura Frog v1.11.0
**Created:** 2026-02-13
