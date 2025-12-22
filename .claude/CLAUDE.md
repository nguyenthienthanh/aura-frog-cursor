# Aura Frog Cursor - Project Instructions

**Project:** aura-frog-cursor
**Type:** Cursor IDE Plugin/Configuration (MCP-first)
**Version:** 1.3.0

---

## Project Overview

This is the **Aura Frog** plugin converted for Cursor IDE with MCP-first architecture:
- 9 MCP servers in `.cursor/mcp.json`
- 16 specialized agents in `.cursor/rules/agents/`
- 37 core quality rules in `.cursor/rules/core/`
- 70+ slash commands in `.cursor/commands/`
- 9-phase TDD workflow in `.cursor/workflows/`

---

## MANDATORY: Documentation & Version Updates

**CRITICAL: After ANY code change, you MUST update the following:**

### 1. CHANGELOG.md (Required for ALL changes)

Update `CHANGELOG.md` at project root with:
```markdown
## [X.Y.Z] - YYYY-MM-DD

### Added
- New features

### Changed
- Modifications to existing features

### Fixed
- Bug fixes

### Removed
- Removed features
```

**Version Increment Rules:**
- **PATCH (1.1.X):** Bug fixes, documentation updates, minor tweaks
- **MINOR (1.X.0):** New features, new rules, new commands, new agents
- **MAJOR (X.0.0):** Breaking changes, major restructuring

### 2. Version Updates (Required for feature/fix changes)

**Single source of truth:** Edit the `VERSION` file at project root, then run sync:

```bash
# Option 1: Edit VERSION file manually, then sync
./scripts/sync-version.sh              # Sync version to all files
./scripts/sync-version.sh --with-date  # Also update "Last Updated" dates

# Option 2: Auto-bump and sync in one command
./scripts/sync-version.sh --bump patch  # 1.2.0 -> 1.2.1
./scripts/sync-version.sh --bump minor  # 1.2.0 -> 1.3.0
./scripts/sync-version.sh --bump major  # 1.2.0 -> 2.0.0

# Preview changes first (recommended)
./scripts/sync-version.sh --dry-run
```

### 3. README Updates (When applicable)

Update README.md when:
- Adding new MCP servers → Update server count and list
- Adding new agents → Update agent count and list
- Adding new rules → Update rules count
- Adding new commands → Update command count

---

## Pre-Commit Checklist

- [ ] CHANGELOG.md updated with change description
- [ ] Run `./scripts/sync-version.sh --bump <type> --with-date` if version changed
- [ ] Related documentation updated

---

## Commit Message Format

Use conventional commits:
```
feat: Add new feature
fix: Fix bug
docs: Documentation only changes
refactor: Code refactoring
chore: Maintenance tasks
```

---

**Version:** 1.3.0
**Last Updated:** 2025-12-22
