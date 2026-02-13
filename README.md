# 🐸 Aura Frog for Cursor IDE

**MCP-first AI development workflow for Cursor IDE**

> Code with main character energy ✨

## Overview

Aura Frog provides a comprehensive AI-powered development workflow with:

- **13 MCP Servers** - Auto-install, zero-config integrations (9 enabled, 4 optional)
- **20 Specialized Agents** - Auto-detect based on your tech stack
- **9-Phase TDD Workflow** - Structured development
- **94 Slash Commands** - All development tasks covered (23 categories)
- **50 Quality Rules** - Always enforced
- **46 Skill Rules** - Auto-invoke, expert & reference skills
- **Learning System** - Self-improvement via Supabase with memory auto-load

## What's New in v1.11.0

**Feature Sync from Aura Frog v1.18.0** - 27 new files converted to Cursor format:
- 11 new skills: model-router, framework-expert, testing-patterns, seo-bundle, code-simplifier, workflow-fasttrack, git-workflow, godot-expert, qa-expert, problem-solving, sequential-thinking
- 6 new core rules: estimation, verification, workflow-deliverables, frontend-excellence, impact-analysis, context-management
- 3 new agents: game-developer, voice-operations, pm-operations-orchestrator
- 7 new commands in 3 new categories: design/, logs/, mcp/

## What's New in v1.10.0

**SEO & AI Discovery** - Comprehensive optimization package:
- `/seo:check` command for full SEO/GEO audits
- AI Discovery optimization for Perplexity, ChatGPT Search, Gemini, Claude
- `web-seo.mdc` specialized agent
- `seo-expert.mdc` and `ai-discovery.mdc` skill rules

## What's New in v1.9.1

**Visual Regression Testing** - Pixel-perfect UI with auto-fix loop:

- **Auto-Trigger** - Runs automatically when design reference detected (Figma URL, PNG, keywords)
- **Workflow Integration** - Auto-runs in Phase 5 (GREEN), Phase 6 (Review), Phase 7 (Verify)
- **Screenshot Comparison** - Compare implementation against design
- **Auto-Fix Loop** - Iterates until pixel-perfect (max 5 attempts)
- **MCP Integration** - Playwright (capture) + Figma (reference)

```
Auto-Trigger Flow:
┌─────────────────────────────────────────────────────────────┐
│  User: "Implement button per figma.com/file/ABC123"         │
│         │                                                   │
│         ▼                                                   │
│  Phase 3: Store design reference automatically              │
│         │                                                   │
│         ▼                                                   │
│  Phase 5-7: Visual regression auto-runs                     │
│         │                                                   │
│         ▼                                                   │
│  Result: ✅ Pixel-perfect match (0.4% diff)                 │
└─────────────────────────────────────────────────────────────┘
```

Manual commands still available: `/visual:test`, `/visual:loop`

**Requirements:** ImageMagick (`brew install imagemagick`)

---

### MCP Servers

| MCP Server | Purpose | Default |
|------------|---------|---------|
| context7 | Library docs lookup | ✅ Enabled |
| playwright | E2E/browser testing | ✅ Enabled |
| github | Git/GitHub operations | ✅ Enabled |
| filesystem | File operations | ✅ Enabled |
| memory | Persistent context | ✅ Enabled |
| vitest | Unit testing | ✅ Enabled |
| atlassian | JIRA/Confluence | ✅ Enabled |
| figma | Design tokens | ✅ Enabled |
| slack | Team notifications | ✅ Enabled |
| laravel-boost | Laravel AI (15+ tools) | Disabled* |
| nodejs-debugger | Node.js runtime debugging | Disabled* |
| firebase | Firebase official MCP | Disabled* |
| firebase-community | Firebase community MCP | Disabled* |

*Requires setup and credentials. Enable in `.cursor/mcp.json`

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
Phase 2: Design          → Technical planning
Phase 3: UI Breakdown    → Component structure
Phase 4: Test Planning   → Test strategy
Phase 5: TDD             → RED → GREEN → REFACTOR
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
├── mcp.json                    # MCP server configuration (13 servers)
├── rules/
│   ├── core/                   # 50 quality rules
│   ├── agents/                 # 20 specialized agents
│   ├── skills/                 # 46 skill rules
│   │   ├── auto-invoke/        # 20 auto-invoke skills
│   │   ├── experts/            # 10 expert skills
│   │   └── reference/          # 16 reference skills
│   ├── hooks/                  # 4 lifecycle hooks
│   └── templates/              # 7 template rules
├── commands/                   # 94 slash commands (23 categories)
│   └── learn/                  # Learning system commands
├── workflows/                  # 9-phase workflow system
├── templates/                  # 9 document templates
├── scripts/                    # Utility scripts
└── docs/                       # Documentation
    ├── MCP.md                  # MCP server guide
    └── LEARNING_SYSTEM.md      # Learning system setup
```

## Creating Custom MCP Servers

Want to build your own MCP server instead of using open-source ones?

See **[.cursor/docs/MCP.md](.cursor/docs/MCP.md)** for:
- MCP architecture overview
- Creating a custom MCP server
- Registering your server in `mcp.json`
- Auto-invoke integration

## Statistics

| Category | Count |
|----------|-------|
| MCP Servers | 13 (9 enabled, 4 optional) |
| Agents | 20 |
| Commands | 94 (23 categories) |
| Core Rules | 50 |
| Skill Rules | 46 (20 auto-invoke, 10 expert, 16 reference) |
| Hook Rules | 4 |
| Template Rules | 7 |
| Document Templates | 9 |
| Workflow Phases | 9 |

## Documentation

- **[.cursor/GET_STARTED.md](.cursor/GET_STARTED.md)** - Quick start guide
- **[.cursor/docs/MCP.md](.cursor/docs/MCP.md)** - MCP server guide
- **[.cursor/docs/LEARNING_SYSTEM.md](.cursor/docs/LEARNING_SYSTEM.md)** - Learning system setup
- **[.cursor/commands/QUICK_REFERENCE.md](.cursor/commands/QUICK_REFERENCE.md)** - All commands

## License

Same as original Aura Frog plugin. Check the [original repository](https://github.com/nguyenthienthanh/aura-frog) for license details.

---

**Code with main character energy!** 🐸✨

**Version:** 1.11.0
**Last Updated:** 2026-02-13
