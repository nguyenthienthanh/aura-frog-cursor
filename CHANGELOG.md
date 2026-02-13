# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.11.0] - 2026-02-13

### Feature Sync from Aura Frog v1.18.0

Comprehensive sync of missing features from the Claude Code plugin (aura-frog v1.18.0) converted to Cursor-compatible `.mdc` format.

#### Added

- **11 New Skill Rules** converted from aura-frog source
  - Auto-invoke (7): `model-router.mdc` (auto-select Haiku/Sonnet/Opus), `framework-expert.mdc` (lazy-load 12 framework patterns), `testing-patterns.mdc` (universal AAA testing), `seo-bundle.mdc` (consolidated SEO/GEO), `code-simplifier.mdc` (KISS enforcement), `workflow-fasttrack.mdc` (skip phases 1-3 for pre-approved specs), `git-workflow.mdc` (token-efficient git ops with security scanning)
  - Experts (2): `godot-expert.mdc` (Godot 4.x/GDScript), `qa-expert.mdc` (QA testing strategies)
  - Reference (2): `problem-solving.mdc` (5 techniques), `sequential-thinking.mdc` (structured analysis with revision)

- **6 New Core Rules** converted from aura-frog source
  - `estimation.mdc` - Story points (Fibonacci), time estimates, risk assessment
  - `verification.mdc` - Iron law: run, read, claim verification protocol
  - `workflow-deliverables.mdc` - Phase-by-phase deliverables checklist
  - `frontend-excellence.mdc` - Core Web Vitals, responsive design, accessibility
  - `impact-analysis.mdc` - Change impact assessment before modifications
  - `context-management.mdc` - Token budget management and context optimization

- **3 New Agent Rules** converted from aura-frog source
  - `game-developer.mdc` - Godot 4.x game development (globs: `*.gd`, `*.tscn`, `*.tres`)
  - `voice-operations.mdc` - ElevenLabs voice streaming integration
  - `pm-operations-orchestrator.mdc` - Central workflow coordinator

- **7 New Commands** (3 new categories)
  - `project/status.md` - Display project detection status
  - `project/config.md` - View/update project configuration
  - `project/sync-settings.md` - Sync Cursor IDE settings
  - `design/stitch.md` - Generate UI with Google Stitch AI
  - `design/stitch-review.md` - Review Stitch-generated designs
  - `logs/analyze.md` - Analyze workflow logs
  - `mcp/status.md` - MCP server status display

#### Stats
- Agents: 20 (was 17)
- Skills: 46 total - 20 auto-invoke, 10 experts, 16 reference (was 35)
- Core Rules: 50 (was 44)
- Commands: 94 in 23 categories (was 87 in 20 categories)

---

## [1.10.0] - 2026-01-15

### SEO & AI Discovery Optimization

Comprehensive SEO and AI Discovery optimization package for web projects.

#### Added
- **SEO Expert Skill** (`seo-expert.mdc`) - Technical SEO expertise
  - Meta tags (title, description, Open Graph, Twitter Cards)
  - Structured data / Schema.org / JSON-LD implementation
  - Sitemap and robots.txt generation
  - Core Web Vitals optimization (LCP, INP, CLS)
  - International SEO (i18n/hreflang)
  - Framework-specific patterns (Next.js, Nuxt, Remix, Astro)

- **AI Discovery Skill** (`ai-discovery.mdc`) - AI search engine optimization
  - Perplexity, ChatGPT Search, Gemini, Claude optimization
  - Entity-first content structure
  - Answer-optimized content patterns
  - Citation-worthy content strategies
  - AI crawler management (robots.txt rules)
  - Freshness signals and semantic HTML

- **Web SEO Agent** (`web-seo.mdc`) - Combined SEO & AI Discovery specialist
  - Auto-activates on meta tags, sitemap, schema, structured data files
  - Loads seo-expert and ai-discovery skills
  - Framework support: Next.js, Nuxt, Remix, Astro, SvelteKit

- **SEO Standards Rule** (`seo-standards.mdc`) - Quality enforcement
  - Required meta tags per page
  - Structured data requirements by page type
  - Image optimization standards
  - Heading hierarchy enforcement
  - URL structure conventions
  - Core Web Vitals targets

- **SEO Commands** (8 new)
  - `/seo:audit` - Comprehensive SEO audit
  - `/seo:test` - Test with Google Rich Results Test & validators
  - `/seo:schema` - Generate structured data (article, product, FAQ, etc.)
  - `/seo:sitemap` - Generate dynamic sitemap
  - `/seo:vitals` - Core Web Vitals analysis and optimization
  - `/seo:ai-optimize` - AI Discovery optimization
  - `/seo:meta` - Generate meta tags (OG, Twitter Cards)
  - `/seo:i18n` - International SEO setup

- **Firebase MCP Servers** (2 options)
  - `firebase` - Official Firebase CLI MCP (30+ tools for Firebase projects)
  - `firebase-community` - Community MCP for Firestore, Storage, Auth

#### Stats
- Agents: 17 (was 16)
- Skills: 16 auto-invoke, 8 experts, 14 reference
- Rules: 45 (was 44)
- Commands: 87 (was 79)
- MCP Servers: 13 (was 11)

---

## [1.9.1] - 2026-01-14

### Visual Regression Workflow Integration

Auto-trigger visual regression during workflow - no manual commands needed.

#### Added
- **Auto-Detection Triggers** - Visual regression runs automatically when:
  - Figma URL detected in task (`figma.com/file/...`)
  - Design files mentioned (`*.png`, `*.jpg`, `*.fig`)
  - Keywords detected: "match design", "pixel perfect", "per Figma"
  - Workflow reaches Phase 5 (GREEN), Phase 6 (Review), or Phase 7 (Verify)

- **Design Reference Storage** - Phase 3 now stores design references
  - Automatically persists to `.cursor/visual/reference-path.txt`
  - Enables automatic visual regression in later phases

#### Updated
- **Phase 3 (UI Breakdown)** - Stores design reference for later comparison
- **Phase 7 (Verify)** - New step 6.5: Auto visual regression if reference exists
- **visual-regression.mdc** - Enhanced with workflow triggers and auto-detection

#### How Auto-Trigger Works
```
┌─────────────────────────────────────────────────────────────┐
│                    WORKFLOW INTEGRATION                      │
├─────────────────────────────────────────────────────────────┤
│  Phase 3 (UI) ──► Store design reference                     │
│       │                                                      │
│       ▼                                                      │
│  Phase 5 (GREEN) ──► Auto-run after component implementation │
│       │                                                      │
│       ▼                                                      │
│  Phase 6 (Review) ──► Auto-run during quality check          │
│       │                                                      │
│       ▼                                                      │
│  Phase 7 (Verify) ──► Final auto-validation                  │
└─────────────────────────────────────────────────────────────┘
```

---

## [1.9.0] - 2026-01-14

### Visual Regression Testing with Auto-Fix Loop

Pixel-perfect UI testing with closed-loop automated fixing.

#### Added
- **Visual Regression Skill** (`visual-regression.mdc`) - Auto-invoke skill for visual testing
  - Compares implementation screenshots against design references
  - Calculates pixel difference percentage
  - Auto-fix loop: identifies issues → applies fixes → re-tests
  - Integrates with Playwright MCP (screenshots) and Figma MCP (design refs)
  - Max 5 iterations, configurable threshold (default 1%)

- **Pixel Accuracy Rule** (`pixel-accuracy.mdc`) - Core rule enforcing UI quality
  - Defines pixel accuracy standards (colors exact, spacing ±1px)
  - Quality gate: ≤1% pass, 1-5% warning, >5% fail
  - Documents common issues and fix strategies

- **Visual Testing Scripts**
  - `scripts/visual/visual-regression.sh` - Compare images, generate diff
  - `scripts/visual/auto-fix-loop.sh` - Iterative fix loop until pass

- **Visual Commands** (3 new)
  - `/visual:test` - Run visual regression test
  - `/visual:loop` - Run auto-fix loop
  - `/visual:baseline` - Update baseline screenshots

#### How It Works
```
┌─────────────────────────────────────────────────────────────┐
│                    VISUAL REGRESSION LOOP                    │
├─────────────────────────────────────────────────────────────┤
│  1. CAPTURE ──► Screenshot of implementation                 │
│  2. COMPARE ──► Diff against design reference                │
│  3. ANALYZE ──► Identify problems (color, spacing, font)     │
│  4. CHECK ────► Diff < 1%?                                   │
│       YES → ✅ PASS                                          │
│       NO  → 5. FIX → Apply CSS fixes → Back to step 1       │
└─────────────────────────────────────────────────────────────┘
```

#### Requirements
```bash
brew install imagemagick   # Image comparison
npx playwright install     # Screenshot capture
```

#### Stats
- Skills: 14 auto-invoke (was 13)
- Rules: 44 (was 43)
- Commands: 79 (was 76)

---

## [1.8.0] - 2026-01-14

### Framework-Specific MCP Integrations

#### Added
- **Laravel Boost MCP Server** - Official Laravel AI assistant with 15+ tools
  - `app_info` - Laravel version, models, packages
  - `db_schema` - Database tables and relationships
  - `db_query` - Execute read queries
  - `routes` - List and analyze routes
  - `artisan` - Run Artisan commands
  - `tinker` - Execute PHP in Laravel context
  - `config` - Read configuration values
  - `docs` - Search Laravel documentation
  - `logs` - Application and browser logs

#### Setup
```bash
# In your Laravel project:
composer require laravel/boost --dev
php artisan boost:install
# Select "Cursor" when prompted
# Enable in .cursor/mcp.json
```

- **Node.js Debugger MCP Server** (`@hyperdrive-eng/mcp-nodejs-debugger`) - Runtime debugging
  - `set_breakpoint` - Set breakpoints in running processes
  - `step_in` / `step_out` / `continue` - Control execution flow
  - `get_location` - Fetch current execution location
  - `read_console` - Read console output
  - `eval` - Run JavaScript to inspect variables

#### Setup
```bash
# Node.js Debugger - start app with --inspect:
node --inspect dist/main.js
# Then enable in .cursor/mcp.json
```

#### Updated
- **backend-laravel agent** - Added Laravel Boost MCP integration section
- **backend-nodejs agent** - Added Node.js Debugger MCP integration section
- **MCP.md** - Added Framework-Specific section with Laravel Boost and Node.js Debugger docs
- **README.md** - Added framework MCP servers to table

#### Stats
- MCP Servers: 11 (was 9)

---

## [1.7.0] - 2026-01-08

### Auto-Learn: Automatic Feedback Detection

#### Added
- **Auto-Learn Skill** (`auto-learn.mdc`) - Automatically detects corrections in user messages
  - Correction patterns: "no", "wrong", "actually", "don't do", "stop adding"
  - Approval patterns: "good", "great", "perfect", "thanks"
  - Auto-categorizes: code_style, testing, security, error_handling, etc.
  - Confidence scoring (50-90%)
- **Auto-Learn Submit Script** (`scripts/learn/auto-learn-submit.sh`) - Submits detected feedback
  - Deduplication: Skips identical feedback within 24 hours (MD5 hash)
  - Pattern detection: Auto-creates patterns after 3+ similar corrections
  - Local cache: `.cursor/cache/auto-learn-cache.json`
  - Local patterns: `.cursor/cache/learned-patterns.md`

#### How It Works
```
User: "stop adding jsdoc comments"
         ↓
Auto-Learn detects correction (90% confidence)
         ↓
Categorizes as code_style:minimal_comments
         ↓
Records to Supabase + local cache
         ↓
🧠 Learning: Captured correction [code_style:minimal_comments] (3x)
```

#### Stats
- Skills: 13 auto-invoke (was 12)

---

## [1.6.0] - 2026-01-08

### Memory Auto-Load at Session Start

#### Added
- **Memory Auto-Load Rule** (`memory-auto-load.mdc`) - Load learned patterns at session start
  - Reads cached memory from `.cursor/cache/memory-context.md`
  - Shows memory count in session status banner
  - Applies learned patterns, agent performance stats, and corrections
- **Memory Load Script** (`scripts/learn/memory-load.sh`) - CLI for memory management
  - Fetches learned patterns from Supabase (high confidence, active)
  - Caches agent performance metrics
  - Loads recent corrections to avoid past mistakes
  - 1-hour cache validity with force refresh option
- **New Command** (`/learn:memory`) - Load or refresh memory cache
  - CRITICAL execution: Must actually run script, not just show docs

#### Changed
- **Environment Loading Rule** updated to include memory loading step
  - Step 3: Load memory cache after sourcing .envrc
  - Status now shows: `🧠 Learning: enabled ✓ | Memory: 15 items loaded`

#### Stats
- Commands: 76 (was 75)
- Core Rules: 43 (was 42)

---

## [1.5.1] - 2026-01-07

### Enhanced Learning System Execution

#### Added
- **Auto env check at session start** - Cursor now checks env vars FIRST before any response
  - Shows MCP status and Learning status in first response
  - Auto-runs `project:reload-env` if env not configured
- **Manual feedback command** (`/learn:feedback`) - Submit feedback interactively
- **Feedback submission script** (`scripts/learn/submit-feedback.sh`) - CLI tool for feedback

#### Changed
- **CRITICAL execution notes** added to ALL learn commands
  - Commands MUST actually execute curl commands, not just show docs
  - Commands MUST source .envrc first to load environment
  - Commands MUST query/submit REAL data to Supabase
- Updated `env-loading.mdc` rule with mandatory session check

#### Stats
- Commands: 75 (was 74)

---

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
| 1.11.0 | 2026-02-13 | Feature sync from aura-frog v1.18.0 (11 skills, 6 rules, 3 agents, 7 commands) |
| 1.10.0 | 2026-01-15 | SEO & AI Discovery optimization (Perplexity, ChatGPT, Gemini) |
| 1.9.1 | 2026-01-14 | Visual regression workflow integration |
| 1.9.0 | 2026-01-14 | Visual regression testing with auto-fix loop |
| 1.8.0 | 2026-01-14 | Framework MCP: Laravel Boost, Node.js Debugger |
| 1.7.0 | 2026-01-08 | Auto-learn: Automatic feedback detection |
| 1.6.0 | 2026-01-08 | Memory auto-load at session start |
| 1.5.1 | 2026-01-07 | Auto env check, feedback command, CRITICAL execution notes |
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
