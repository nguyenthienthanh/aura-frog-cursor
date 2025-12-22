# /project:init - Initialize Aura Frog for Project

## Description

Initializes Aura Frog system for a project by analyzing the codebase, extracting conventions and patterns, creating project context files, and setting up configuration. This is a prerequisite for using workflows effectively.

**What it does:**
1. Auto-detects project type, framework, and tech stack
2. Indexes project structure and conventions
3. Creates `.cursor/project-contexts/[project]/` with rules and examples
4. Generates project-specific configuration files
5. Sets up environment variable templates

**Original command:** `project:init`

## Usage

```
/project:init
```

## Execution Steps

1. **Detect Project Name** - Read from package.json, composer.json, or directory name
2. **Analyze Project Structure** - Scan for framework, tech stack, directories
3. **Extract Conventions** - File naming, directory patterns, import aliases
4. **Create Project Context Files** - Generate project-config.yaml, conventions.md, rules.md, examples.md
5. **Setup Configuration** - Create ccpm-config.yaml, settings.local.json, CLAUDE.md, .envrc
6. **Display Summary** - Show detected tech stack and created files

## Examples

### React Native Project
```
/project:init
```
Output: Detects React Native + TypeScript, creates project context

### Laravel + Vue Project
```
/project:init
```
Output: Detects Laravel + Vue, activates backend-laravel and web-vuejs agents

## References

- Related commands: `/project:regen`, `/workflow:start`
- Created files: `.cursor/project-contexts/[project]/`
- Configuration: `.cursor/ccpm-config.yaml`
- Agent banner: `.cursor/rules/core/agent-identification.mdc`
- MCP config: `.cursor/mcp.json`

## Notes

**Critical:** `.cursorrules` is the main entry point. It references:
- Banner format: `.cursor/rules/core/agent-identification.mdc`
- MCP integrations: `.cursor/rules/skills/auto-invoke/mcp-integrations.mdc`
- All core rules: `.cursor/rules/core/` (with `alwaysApply: true`)

**Next Steps:**
1. Review generated files in `.cursor/project-contexts/[project]/`
2. Configure MCP credentials (optional): Edit `.envrc`
3. Start first workflow: `/workflow:start "your task"`

---

**Source:** Aura Frog v1.1.9
**Converted:** 2025-11-30
