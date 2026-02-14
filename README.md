# 🐸 Aura Frog for Cursor IDE

**MCP-first AI development workflow for Cursor IDE**

> Code with main character energy ✨

## Overview

Aura Frog provides a comprehensive AI-powered development workflow with:

- **11 MCP Servers** - 3 core (always enabled) + 8 optional (enable per-project)
- **20 Specialized Agents** - Auto-detect based on your tech stack
- **9-Phase TDD Workflow** - Structured development
- **94 Slash Commands** - All development tasks covered (23 categories)
- **39 Quality Rules** - 7 always-applied, rest auto-attached by file type
- **43 Skill Rules** - Auto-invoke, expert & reference skills
- **Learning System** - Pattern capture and self-improvement

## What's New in v1.12.0

**Performance Optimization — Context Window Recovery**

Major optimization to recover ~60-70% of wasted context window tokens:

- **alwaysApply rules: 50+ → 7** — Only essential rules always loaded. Rest auto-attach by file type or agent selection
- **Always-applied rules compressed to <60 lines each** — Down from 150-470 lines
- **MCP servers: 9 enabled → 3 core** — Reduced tool token overhead by ~60%
- **Deleted 9 redundant rules** — LLMs already know modern JS, YAGNI, DRY, etc.
- **Deleted deprecated `.cursorrules`** — Was causing double context loading
- **Removed `filesystem` & `memory` MCP servers** — Redundant with Cursor built-ins
- **Merged overlapping rules** — Reduced duplication across security, testing, quality
- **Learning system consolidated** — 3 skills → 1
- **Added CI validation script** — `scripts/validate-rules.sh`

**Estimated impact:** ~75-85% context window now available for actual code (was ~40-50%)

---

### MCP Servers

| MCP Server | Purpose | Default |
|------------|---------|---------|
| context7 | Library docs lookup | ✅ Enabled |
| playwright | E2E/browser testing | ✅ Enabled |
| github | Git/GitHub operations | ✅ Enabled |
| vitest | Unit testing | Disabled* |
| atlassian | JIRA/Confluence | Disabled* |
| figma | Design tokens | Disabled* |
| slack | Team notifications | Disabled* |
| laravel-boost | Laravel AI (15+ tools) | Disabled* |
| nodejs-debugger | Node.js runtime debugging | Disabled* |
| firebase | Firebase official MCP | Disabled* |
| firebase-community | Firebase community MCP | Disabled* |

*Enable per-project in `.cursor/mcp.json` by setting `"disabled": false`

## Quick Start

### 1. Installation

```bash
# Clone and run setup
git clone https://github.com/nguyenthienthanh/aura-frog-cursor.git
./aura-frog-cursor/setup.sh /path/to/your/project
```

The setup script:
- Copies `.cursor` folder to your project
- Creates `.envrc` from template
- Updates `.gitignore`

### 2. Enable Optional MCP Servers

Edit `.envrc` to add your credentials:

```bash
# GitHub (for PR creation, issue management)
export GITHUB_TOKEN="ghp_your-token"

# Atlassian (for JIRA/Confluence)
export ATLASSIAN_SITE_URL="https://company.atlassian.net"
export ATLASSIAN_USER_EMAIL="your-email@company.com"
export ATLASSIAN_API_TOKEN="your-token"

# Figma (for design tokens)
export FIGMA_API_KEY="figd_your-token"
```

Then edit `.cursor/mcp.json` and set `"disabled": false` for servers you want.

### 3. Start Coding

Open your project in Cursor IDE. MCP servers auto-install on first use via `npx`.

```
# Initialize project context
/project:init

# Start a workflow
/workflow:start "Your task description"
```

## MCP Auto-Chaining

MCP tools automatically chain with agents, skills, and workflows:

```
User: "Implement PROJ-1234 using figma.com/file/XYZ"

Auto-chain:
1. atlassian MCP → fetch JIRA requirements
2. figma MCP → fetch design tokens
3. workflow-orchestrator → start 9-phase workflow
4. agent-detector → select appropriate agent
5. Phase 1 + Phase 3 auto-populated
```

### Trigger Patterns

| Pattern | MCP Used | Agent Activated |
|---------|----------|-----------------|
| `PROJ-1234` | atlassian | workflow-orchestrator |
| `figma.com/file/...` | figma | ui-designer |
| "write e2e test" | playwright | qa-automation |
| "run unit tests" | vitest | qa-automation |
| "create PR" | github | - |

## Key Features

### 🤖 20 Specialized Agents

**Development:**
- mobile-react-native, mobile-flutter
- web-angular, web-vuejs, web-reactjs, web-nextjs
- backend-nodejs, backend-python, backend-go, backend-laravel
- database-specialist, game-developer

**Quality & Operations:**
- security-expert, qa-automation, ui-designer
- devops-cicd, project-detector, web-seo

**Operations:**
- pm-operations-orchestrator, voice-operations

### 📋 9-Phase TDD Workflow

```
Phase 1: Understand      → Requirements analysis
Phase 2: Design          → Technical planning (APPROVAL GATE)
Phase 3: UI Breakdown    → Component structure
Phase 4: Test Planning   → Test strategy
Phase 5: TDD             → RED → GREEN (APPROVAL GATE) → REFACTOR
Phase 6: Review          → Code quality check
Phase 7: Verify          → QA validation
Phase 8: Document        → Documentation
Phase 9: Share           → Deployment
```

### ⚡ Key Commands

```
/workflow:start "task"     # Start workflow
/workflow:status           # Check progress
/bugfix:quick "issue"      # Quick bug fix
/test:unit {file}          # Run unit tests
/quality:check             # Quality scan
```

## Structure

```
.cursor/
├── mcp.json                    # MCP server configuration (11 servers)
├── rules/
│   ├── core/                   # 39 quality rules (7 always-applied)
│   ├── agents/                 # 20 specialized agents
│   ├── skills/                 # 43 skill rules
│   │   ├── auto-invoke/        # 17 auto-invoke skills
│   │   ├── experts/            # 10 expert skills
│   │   └── reference/          # 16 reference skills
│   ├── hooks/                  # 4 lifecycle hooks
│   └── templates/              # 7 template rules
├── commands/                   # 94 slash commands (23 categories)
├── workflows/                  # 9-phase workflow system
├── templates/                  # 9 document templates
├── scripts/                    # Utility scripts
└── docs/                       # Documentation
```

## Statistics

| Category | Count |
|----------|-------|
| MCP Servers | 11 (3 core + 8 optional) |
| Agents | 20 |
| Commands | 94 (23 categories) |
| Core Rules | 39 (7 always-applied, 32 auto-attached/agent-selected) |
| Skill Rules | 43 (17 auto-invoke, 10 expert, 16 reference) |
| Hook Rules | 4 |
| Template Rules | 7 |
| Workflow Phases | 9 |

## CI Validation

```bash
# Validate all MDC rules, version consistency, and alwaysApply limits
./scripts/validate-rules.sh
```

## Documentation

- **[.cursor/GET_STARTED.md](.cursor/GET_STARTED.md)** - Quick start guide
- **[.cursor/docs/MCP.md](.cursor/docs/MCP.md)** - MCP server guide
- **[.cursor/docs/LEARNING_SYSTEM.md](.cursor/docs/LEARNING_SYSTEM.md)** - Learning system setup
- **[.cursor/commands/QUICK_REFERENCE.md](.cursor/commands/QUICK_REFERENCE.md)** - All commands

## License

Same as original Aura Frog plugin. Check the [original repository](https://github.com/nguyenthienthanh/aura-frog) for license details.

---

**Code with main character energy!** 🐸✨

**Version:** 1.12.0
**Last Updated:** 2026-02-14
