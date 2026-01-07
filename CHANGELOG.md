# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.5.0] - 2026-01-07

### Learning System - Self-Improvement via Supabase

Cursor can now learn and improve over time by collecting feedback, tracking metrics, and applying learned patterns.

#### Added

- **Learning System** - Cloud-based learning with Supabase
  - `.cursor/docs/LEARNING_SYSTEM.md` - Full setup and usage guide
  - `scripts/supabase/schema.sql` - Database schema for learning tables
  - Feedback collection (corrections, approvals, rejections)
  - Workflow metrics tracking
  - Agent performance monitoring
  - Pattern recognition and insights

- **New Skills**
  - `.cursor/rules/skills/auto-invoke/learning-analyzer.mdc` - Analyze patterns and generate insights
  - `.cursor/rules/skills/auto-invoke/self-improve.mdc` - Apply learned improvements

- **New Commands** (4)
  - `/learn:setup` - Automatic schema setup via API
  - `/learn:status` - Display learning system status
  - `/learn:analyze` - Run pattern analysis
  - `/learn:apply` - Apply learned improvements

- **Environment Variables**
  - `SUPABASE_URL` - Supabase project URL
  - `SUPABASE_PUBLISHABLE_KEY` - Public key (safe for client)
  - `SUPABASE_SECRET_KEY` - Secret key (server-side only)
  - `AF_LEARNING_ENABLED` - Enable/disable learning

#### Features

1. **Feedback Collection**
   - Detects user corrections to AI output
   - Captures approval/rejection reasons at gates
   - Optional quality ratings

2. **Metrics Tracking**
   - Workflow success/failure rates
   - Token usage per phase
   - Agent performance by task type
   - Test coverage trends

3. **Pattern Analysis**
   - Success patterns (what works)
   - Failure patterns (common issues)
   - Optimization opportunities
   - Agent routing recommendations

4. **Self-Improvement**
   - Review and apply suggestions
   - Auto-apply high-confidence improvements
   - Rollback support with backups

#### Stats
- Commands: 74 (was 70)

---

## [1.4.1] - 2026-01-02

### Fixed
- **Auto-Continue Phases Being Skipped** - Fixed documentation inconsistency
  - Auto-continue phases were being skipped entirely instead of executing and showing deliverables
  - Updated `approval-gates.mdc` to v2.0.0 with clear 2-gate model
  - Updated `execution.mdc` to v2.0.0 with split rules for approval vs auto-continue
  - Updated `safety.mdc` with approval gates section

### Key Clarification
```
Auto-continue ≠ Skip!

Approval Phases (2, 5b):     Execute → Show → WAIT → User approves → Continue
Auto-Continue Phases:        Execute → Show → Continue automatically
Auto-Stop (on blockers):     Execute → Issue found → STOP for fix
```

---

## [1.4.0] - 2026-01-01

### Changed
- **Streamlined Workflow with 2 Approval Gates** - Reduced approval gates from 8 to 2
  - Only Phase 2 (Design) and Phase 5b (Implementation) require approval
  - All other phases auto-continue unless blockers hit
  - Auto-stop triggers: test failures, security issues, coverage < 80%
  - Flow: `START → Phase 1 (auto) → Phase 2 ✋ → Phases 3-5a (auto) → Phase 5b ✋ → Phases 5c-9 (auto) → DONE`

### Updated Files
- `.cursor/rules/skills/auto-invoke/workflow-orchestrator.mdc`
  - Updated phase table with new gate types (⚡ Auto vs ✋ Approval)
  - New phase transition rules with AUTO-CONTINUE modes
  - Simplified example workflow execution
- `.cursor/rules/core/workflow-navigation.mdc`
  - Added 2-gate workflow note to core rule

### Why This Change
- Faster feature delivery with fewer interruptions
- Critical decisions (architecture, implementation) still require approval
- Auto-stop on errors ensures quality is maintained
- TDD still enforced throughout

---

## [1.3.0] - 2025-12-22

### Added
- **Centralized Version Management** - Single source of truth for versioning
  - `VERSION` file at project root contains the version number
  - `scripts/sync-version.sh` syncs version to all 121 files automatically
  - Commands: `--bump patch|minor|major`, `--with-date`, `--dry-run`
  - No more manual updates across 121 files

### Changed
- Updated `.claude/CLAUDE.md` with new version workflow documentation
- Simplified pre-commit checklist (one command instead of manual updates)

### Fixed
- **Documentation Consistency** - Fixed incorrect counts across all docs
  - Agent count: 24 → 16 (actual agents in `.cursor/rules/agents/`)
  - Core rules: 37 → 42 (actual rules in `.cursor/rules/core/`)
  - Skills breakdown: corrected to 9 auto-invoke + 7 experts + 13 reference
  - Removed references to non-existent agents and files
  - Updated version banners in example code blocks
- **Deprecated Slack MCP Package** - Replaced with active alternative
  - Old: `@modelcontextprotocol/server-slack` (deprecated, no longer supported)
  - New: `slack-mcp-server` (korotovsky) - 30K+ users, stealth & OAuth modes
  - Updated env var: `SLACK_BOT_TOKEN` → `SLACK_TOKEN`
- **Atlassian MCP Package** - Switched to official remote server
  - Old: `mcp-atlassian` (Python/Docker-based)
  - New: Official Atlassian Remote MCP via `mcp-remote`
  - No API tokens needed - uses OAuth browser authentication
  - Just enable and login via browser on first use

## [1.2.0] - 2025-12-22

### Added
- **JIRA/Figma Data Persistence** - Fetched data now saved to logs
  - JIRA tickets saved to `.cursor/logs/jira/{TICKET_ID}.toon`
  - Figma designs saved to `.cursor/logs/figma/{FILE_ID}.toon`
  - Uses TOON format instead of JSON (~40% smaller)
  - Cache-first behavior: reads from logs before fetching
  - Refresh keywords: `fetch`, `refresh`, `update`, `get latest`

### Changed
- **Aggressive Minimization** - MCP-first architecture
  - Most functionality now via MCP servers
  - Scripts reduced to workflow management only
  - Agents consolidated from 20 to 16
- **Documentation Overhaul**
  - README.md: 311 → 196 lines (37% smaller), MCP-focused
  - GET_STARTED.md: 735 → 257 lines (65% smaller), simplified
  - setup.sh: 441 → 189 lines (57% smaller), no interactive prompts
- **Duplicate Rule Cleanup**
  - `security-expert.mdc`: 446 → 293 lines (34% smaller)
    - Now references `sast-security.mdc` instead of duplicating OWASP Top 10
    - Keeps unique content: Input Validation, XSS, CSRF, Secrets, Auth patterns
  - `workflow-system.mdc`: Fixed reference to non-existent `tdd-workflow.mdc`
    - Now references `testing-expert.mdc` for TDD patterns
- **Documentation Update for MCP**
  - Removed all bash script references (jira-fetch.sh, figma-fetch.sh, etc.)
  - `INTEGRATION_SETUP_GUIDE.md`: 492 → 206 lines (58% smaller), MCP-focused
  - `AGENTS.md`: Updated integration section to use MCP servers
  - `README.md`: Updated directory structure (scripts now workflow-only)
  - `phase-9-share.md`: Updated to use MCP tools instead of scripts

### Added
- **MCP Startup Check Rule** (`mcp-startup-check.mdc`) - Verify MCP servers at session start
  - Lists enabled servers and their purposes
  - Troubleshooting guidance for failed servers
- **MCP Visibility in Banner** - Agent banner now shows which MCP servers are being used
  - New `🔌 MCP:` line displays active MCP servers
  - Examples: `🔌 MCP: context7`, `🔌 MCP: atlassian, figma`
  - Shows `-` when no MCP servers are in use
- **Single Source of Truth for Banner** - `.cursorrules` now references `agent-identification.mdc`
  - No more duplicated banner format
  - Update banner in one place, applies everywhere
- **Deliverable Persistence Rule** (`deliverable-persistence.mdc`)
  - All workflow phase deliverables MUST be saved to files
  - Location: `.cursor/documents/workflows/[workflow-id]/`
  - Prevents loss of work when session ends
- **MCP Documentation** (`docs/MCP.md`) - Complete guide for custom MCP servers
  - TypeScript and Python examples
  - Publishing to npm or local usage
  - Integration with auto-invoke system
- New MCP servers (enabled by default):
  - `@modelcontextprotocol/server-filesystem` - File operations
  - `@modelcontextprotocol/server-memory` - Persistent context
  - `@modelcontextprotocol/server-github` - Git/GitHub operations (disabled*)
- Auto-chaining: MCP tools → Agents → Skills → Workflows

### Removed
- **Scripts** (~1500 lines):
  - `test/run-tests.sh`, `test/coverage-report.sh` → Vitest MCP
  - `detect-design-system.sh` → AI detects directly
  - `discover-agents.sh`, `validate-config.sh`, `generate-report.sh` → Not needed
- **Agents** (4 redundant):
  - `voice-operations.mdc` - ElevenLabs removed
  - `pm-operations-orchestrator.mdc` - Slack MCP handles
  - `project-context-manager.mdc` - Merged into project-detector
  - `project-config-loader.mdc` - Merged into project-detector

## [1.1.8] - 2025-12-19

### Changed
- **MCP-First Integrations** - Replaced custom bash scripts with MCP servers
  - JIRA, Confluence, Figma, Slack now use standard MCP protocol
  - Auto-install via `npx` - no manual package installation needed
  - Pre-configured in `.cursor/mcp.json` (disabled by default)
  - Users just add credentials to `.envrc` and enable in mcp.json

### Added
- **MCP Integrations Rule** (`mcp-integrations.mdc`) - Auto-invoke MCP tools on pattern detection
- Pre-configured MCP servers:
  - `@playwright/mcp` - E2E testing, browser automation (enabled by default)
  - `@madrus/vitest-mcp-server` - Unit testing, coverage analysis
  - `mcp-atlassian` - JIRA + Confluence
  - `figma-developer-mcp` - Figma designs (optimized for Cursor)
  - `@modelcontextprotocol/server-slack` - Slack integration

### Removed
- Custom integration scripts (replaced by MCP):
  - `figma-fetch.sh`, `jira-fetch.sh`
  - `integrations/jira-sync.sh`, `integrations/confluence-publish.sh`, `integrations/slack-notify.sh`
  - `confluence-operations.sh`, `setup-integrations.sh`, `test-integrations.sh`, `voice-notify.sh`
- Integration agents (now handled by MCP):
  - `jira-operations.mdc`, `confluence-operations.mdc`, `slack-operations.mdc`
- Auto-invoke skills (replaced by `mcp-integrations.mdc`):
  - `figma-integration.mdc`, `jira-integration.mdc`, `confluence-integration.mdc`

### Benefits
- **Zero-config**: Users copy `.cursor/`, add credentials, done
- **Standard protocol**: MCP servers are community-maintained
- **Auto-install**: `npx -y` downloads servers on first use
- **Minimal footprint**: Removed ~2000 lines of custom integration code

## [1.1.6] - 2025-12-15

### Added
- **Expert Skills System** - Domain-specific bundled best practices (~3500 lines total)
  - `typescript-expert.mdc` - TS/JS patterns, strict typing, null handling
  - `react-expert.mdc` - Hooks, performance, state management, JSX patterns
  - `vue-expert.mdc` - Composition API, Pinia, reactivity
  - `angular-expert.mdc` - Signals, RxJS, NgRx, standalone components
  - `api-expert.mdc` - REST design, validation, error handling, DB patterns
  - `testing-expert.mdc` - TDD, unit/integration/e2e, mocking, coverage
  - `security-expert.mdc` - OWASP Top 10, secure coding, auth, crypto

### Changed
- **Agent Optimization** - All 15 development agents slimmed down (~70% reduction)
  - Agents now reference expert skills instead of embedding patterns
  - Reduced from ~200-420 lines to ~60-90 lines per agent
  - Consistent "Load Expert Skills" table format across all agents
- **Updated Agents:**
  - Frontend: `web-reactjs`, `web-vuejs`, `web-angular`, `web-nextjs`, `mobile-react-native`, `mobile-flutter`
  - Backend: `backend-nodejs`, `backend-python`, `backend-go`, `backend-laravel`
  - Specialists: `qa-automation`, `security-expert`, `database-specialist`, `devops-cicd`, `ui-designer`

### Removed
- **Redundant Core Rules** (now in expert skills):
  - `typescript-strict-nulls.mdc` → `typescript-expert.mdc`
  - `tdd-workflow.mdc` → `testing-expert.mdc`
  - `api-design.mdc` → `api-expert.mdc`
- **Redundant Reference Skills** (merged into experts):
  - `unit-testing.mdc` → `testing-expert.mdc`
  - `e2e-testing.mdc` → `testing-expert.mdc`
  - `api-designer.mdc` → `api-expert.mdc`
  - `react-native-patterns.mdc` → `react-expert.mdc`
  - `state-management.mdc` → `react-expert.mdc` / `vue-expert.mdc`
  - `qa-expert.mdc` → `testing-expert.mdc`
  - `dev-expert.mdc` → expert skills

### Stats
- Rules reduced from ~114 to 103 files
- Total lines saved: ~4000+ lines across agents and rules
- Expert skills provide comprehensive patterns in dedicated files

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
| 1.5.0 | 2026-01-07 | Learning System with Supabase (self-improvement) |
| 1.4.1 | 2026-01-02 | Auto-continue phases fix |
| 1.4.0 | 2026-01-01 | Streamlined 2-gate workflow |
| 1.3.0 | 2025-12-22 | Centralized version management (VERSION + sync script) |
| 1.2.0 | 2025-12-22 | JIRA/Figma data persistence in TOON format |
| 1.1.8 | 2025-12-19 | MCP-first integrations, removed custom scripts |
| 1.1.6 | 2025-12-15 | Expert skills system, agent optimization (~70% reduction) |
| 1.1.5 | 2025-12-15 | SAST security, Mermaid diagrams, library usage rule |
| 1.1.4 | 2025-12-11 | TOON format, project-contexts, linting standards |
| 1.1.3 | 2025-12-01 | Confluence integration, design system |
| 1.1.0 | 2025-11-30 | Multi-model, agents, full feature set |
| 1.0.0 | 2025-11-29 | Initial Cursor IDE conversion |

---

**Maintained by:** Aura Frog Team
**Original:** [nguyenthienthanh/aura-frog](https://github.com/nguyenthienthanh/aura-frog)
