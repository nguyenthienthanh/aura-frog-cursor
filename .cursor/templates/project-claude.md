# Aura Frog - [PROJECT_NAME]

**Project:** [PROJECT_NAME]
**Tech Stack:** [TECH_STACK]
**Aura Frog Version:** 1.1.9

---

<!-- AURA-FROG-AUTO-START -->
<!-- DO NOT EDIT THIS SECTION - It will be overwritten on regen -->
<!-- Banner format is defined in: .cursor/rules/core/agent-identification.mdc -->

## CRITICAL: Agent Identification Banner

**YOU MUST show the Aura Frog banner at the START of EVERY response.**

**Banner format is defined in:** `.cursor/rules/core/agent-identification.mdc`

Read that file for the latest banner format, including:
- Agent selection
- Phase display
- MCP server visibility (🔌 MCP: [servers])
- Aura messages

**This is NOT optional. Do it EVERY time.**

---

## Session Start Checklist

| # | Action | How |
|---|--------|-----|
| 1 | Show agent banner | See `.cursor/rules/core/agent-identification.mdc` |
| 2 | Load `.envrc` if exists | Check `.envrc` or `.cursor/.envrc` |
| 3 | Detect appropriate agent | Based on task context |

---

## Project Context

**Load from:** `.cursor/project-contexts/[PROJECT_NAME]/`

| File | Purpose |
|------|---------|
| `project-config.yaml` | Tech stack, agents, integrations |
| `conventions.md` | File naming, structure patterns |
| `rules.md` | Project-specific quality rules |
| `examples.md` | Code examples |

---

## MCP Servers

MCP tools are auto-invoked based on patterns. See `.cursor/rules/skills/auto-invoke/mcp-integrations.mdc`

| Server | Trigger | Purpose |
|--------|---------|---------|
| context7 | Library questions | Documentation lookup |
| playwright | "e2e test", "browser test" | Browser automation |
| atlassian | `PROJ-1234` patterns | JIRA/Confluence |
| figma | `figma.com/file/...` URLs | Design tokens |
| github | "create PR" | Git operations |
| vitest | "unit test" | Test runner |
| slack | `#channel`, "notify team" | Notifications |

---

## Execution Rules

**ALWAYS:**
- Show agent banner at start of EVERY response
- Load `.envrc` if exists at session start
- Follow project conventions from `.cursor/project-contexts/`

**NEVER:**
- Skip agent banner
- Auto-approve without user confirmation
- Implement without showing banner first

<!-- AURA-FROG-AUTO-END -->

---

## Project-Specific Settings

<!-- USER SECTION - Your custom settings below will be preserved on regen -->

- **Primary Agent:** `[PRIMARY_AGENT]`
- **Tech Stack:** [TECH_STACK]
- **Type:** [PROJECT_TYPE]

### Custom Rules

<!-- Add your project-specific rules here -->

### Custom Integrations

<!-- Add your project-specific integrations here -->

---

**Version:** 1.1.9 | **Generated:** [DATE]
