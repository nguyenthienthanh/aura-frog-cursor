# Aura Frog Cursor - Project Instructions

**Project:** aura-frog-cursor
**Type:** Cursor IDE Plugin/Configuration
**Version:** 1.1.5

---

## Project Overview

This is the **Aura Frog** plugin converted for Cursor IDE. It contains:
- 24 specialized agents in `.cursor/rules/agents/`
- 37+ core quality rules in `.cursor/rules/core/`
- 29 skills in `.cursor/rules/skills/`
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

When version changes, update ALL files containing version:
```bash
# Files that contain version numbers:
README.md                              # **Version:** X.Y.Z
.cursor/README.md                      # **Version:** X.Y.Z
.cursor/GET_STARTED.md                 # **Version:** X.Y.Z
.cursor/rules/**/*.mdc                 # **Version:** X.Y.Z (in footer)
```

**Quick update command:**
```bash
find . -type f \( -name "*.md" -o -name "*.mdc" \) -exec sed -i '' 's/OLD_VERSION/NEW_VERSION/g' {} \;
```

### 3. README Updates (When applicable)

Update README.md when:
- Adding new agents → Update agent count and list
- Adding new rules → Update rules count and list
- Adding new commands → Update command count
- Adding new skills → Update skills count

### 4. Related Documentation

| Change Type | Update These Files |
|-------------|-------------------|
| New agent | `.cursor/rules/agents/`, `.cursor/rules/core/README.md` |
| New rule | `.cursor/rules/core/README.md`, main README |
| New skill | main README |
| New command | `.cursor/commands/QUICK_REFERENCE.md` |

---

## Pre-Commit Checklist

- [ ] CHANGELOG.md updated with change description
- [ ] Version incremented if needed (patch/minor/major)
- [ ] Related documentation updated
- [ ] Last Updated date set to today

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

**Version:** 1.1.5
**Last Updated:** 2025-12-15
