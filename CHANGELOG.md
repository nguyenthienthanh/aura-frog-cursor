# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- **TypeScript Strict Nulls Rule** (`typescript-strict-nulls.mdc`) - Explicit null/undefined handling
  - Avoid truthy/falsy pitfalls (empty string, zero are valid!)
  - Use `??` instead of `||` for defaults
  - Explicit JSX conditional rendering patterns
  - ESLint rules configuration
  - React, Vue, Angular specific examples

### Changed
- Updated frontend agents with strict null handling section:
  - `mobile-react-native.mdc` - JSX conditional patterns
  - `web-reactjs.mdc` - React-specific null handling
  - `web-vuejs.mdc` - Vue v-if and computed patterns
  - `web-nextjs.mdc` - Next.js patterns
  - `web-angular.mdc` - Signals and @if patterns
- All updated agents now reference `typescript-strict-nulls.mdc`

## [1.1.5] - 2025-12-15

### Added
- **SAST Security Rule** (`sast-security.mdc`) - OWASP Top 10 coverage with CWE patterns
- **Use Existing Libraries Rule** (`use-existing-libraries.mdc`) - Prefer lodash/es-toolkit over custom utils
- **Mermaid Diagrams Skill** (`mermaid-diagrams.mdc`) - Diagram generation in Phase 2
- Diagram section added to tech-spec template
- `.claude/CLAUDE.md` - Project-specific documentation rules
- `.claude/settings.json` - Claude Code hooks configuration

### Changed
- Updated all documentation for v1.1.5
- Phase 2 workflow now includes Mermaid diagram creation
- Tech spec template includes diagrams section

### Fixed
- Fixed version references across 79 files (v1.1.4 → v1.1.5)
- Corrected statistics in README (250+ files, 103 MDC rules, 37 core rules)
- Removed broken references to non-existent files

## [1.1.4] - 2025-12-11

### Added
- **TOON Format** - Token-Oriented Object Notation for ~40% token reduction
- **Project-Contexts Template** - Standardized project customization
- **Linting Standards Rule** - Project-specific linting with merge strategy
- **Tech Spec Requirement Rule** - Enforces TECH_SPEC_AI.md creation
- **Safe Refactoring Rule** - Prevents breaking changes during refactoring
- **Multi-Agent Banner Support** - Collaboration indicator for multiple agents

### Changed
- Converted all tables to TOON format across rules and skills
- Changed linting rule strategy from fallback to merge
- Enhanced smart-commenting rule with JSDoc examples
- Removed divider recommendations from smart-commenting

### Fixed
- Updated .cursorrules and fixed all .claude/ paths to .cursor/
- Fixed setup.sh to merge existing .envrc instead of skipping

## [1.1.3] - 2025-12-01

### Added
- **Confluence Integration** - Auto-configure from JIRA credentials
- **Design System Library** - Component library support
- **Next-Step Guidance** - Workflow guidance improvements
- **Documents Folder Structure** - Organized documentation output

### Changed
- Improved setup.sh with smart merge for existing files
- Updated banner format (removed Model line)

## [1.1.0] - 2025-11-30

### Added
- **Multi-Model Selection** - Support for different AI models
- **Agent Banner** - Visual agent identification
- **24 Specialized Agents** - Full agent suite
- **70+ Slash Commands** - Complete command coverage
- **37 Core Quality Rules** - Comprehensive quality standards
- **29 Skills** - 10 auto-invoke + 19 reference skills
- **9-Phase TDD Workflow** - Structured development process
- **JIRA Integration** - Ticket fetching with cache
- **Figma Integration** - Design token extraction

### Changed
- Migrated from Aura Frog plugin v1.1.4 format

## [1.0.0] - 2025-11-29

### Added
- Initial release: Aura Frog converted for Cursor IDE
- Basic structure with `.cursor/` directory
- Core rules and agents
- Slash commands
- Workflow system
- Setup script

---

## Version History Summary

| Version | Date | Highlights |
|---------|------|------------|
| 1.1.5 | 2025-12-15 | SAST security, Mermaid diagrams, library usage rule |
| 1.1.4 | 2025-12-11 | TOON format, project-contexts, linting standards |
| 1.1.3 | 2025-12-01 | Confluence integration, design system |
| 1.1.0 | 2025-11-30 | Multi-model, agents, full feature set |
| 1.0.0 | 2025-11-29 | Initial Cursor IDE conversion |

---

**Maintained by:** Aura Frog Team
**Original:** [nguyenthienthanh/aura-frog](https://github.com/nguyenthienthanh/aura-frog)
