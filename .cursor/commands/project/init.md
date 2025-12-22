# /project:init - Initialize Aura Frog for Project

## Description

Initializes Aura Frog system for a project by analyzing the codebase, extracting conventions and patterns, creating project context files, and setting up configuration. This is a prerequisite for using workflows effectively.

**What it does:**
1. Auto-detects project type, framework, and tech stack
2. Indexes project structure and conventions
3. Creates `.cursor/project-contexts/[project]/` with rules and examples
4. Generates project-specific configuration files
5. Sets up environment variable templates
6. Creates CLAUDE.md with marker-based sections (for smart regen support)

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

- Related commands: `/project:regen`, `/workflow:start`, `/setup:integrations`
- Created files: `.cursor/project-contexts/[project]/`
- Configuration: `.cursor/ccpm-config.yaml`
- Agent banner: `.cursor/CLAUDE.md`

## Notes

**Critical:** `.claude/CLAUDE.md` MUST exist for Aura Frog to work. It references:
- Banner format from `.cursor/rules/core/agent-identification.mdc`
- MCP integrations from `.cursor/rules/skills/auto-invoke/mcp-integrations.mdc`

**Marker System:** CLAUDE.md uses `<!-- AURA-FROG-AUTO-START -->` and `<!-- AURA-FROG-AUTO-END -->` markers to separate auto-managed content from user content. This allows `/project:regen` to update Aura Frog sections without losing user customizations.

**Next Steps:**
1. Review generated files
2. Add custom rules/integrations to CLAUDE.md (below the AUTO-END marker)
3. Configure MCP credentials (optional): Edit `.envrc`
4. Start first workflow: `/workflow:start "your task"`

---

**Source:** Aura Frog v1.1.9
**Converted:** 2025-11-30
