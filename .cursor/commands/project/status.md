# /project:status

## Description

Display current project detection status including framework, tech stack, agents, and MCP servers. Uses cached detection data for fast response.

## Usage

```
/project:status
```

## Output Format

```
Project: [project-name]
Type: [single-repo|monorepo|workspace]
Framework: [detected framework]
Package Manager: [npm|pnpm|yarn|composer|pip|etc.]
Primary Agent: [agent-name]
Secondary Agents: [agent-list]
Test Framework: [vitest|jest|phpunit|etc.]
MCP Servers: [X enabled, Y disabled]
From Cache: [Yes|No]
```

## Related Commands

- `/project:refresh` - Force re-scan of project
- `/project:detect` - Re-detect project type
- `/project:init` - Full initialization

---

**Source:** Aura Frog v1.11.0
**Created:** 2026-02-13
