# 🐸 Aura Frog for Cursor IDE

**MCP-first AI development workflow for Cursor IDE**

> Code with main character energy ✨

## Overview

Aura Frog provides a comprehensive AI-powered development workflow with:

- **9 MCP Servers** - Auto-install, zero-config integrations
- **16 Specialized Agents** - Auto-detect based on your tech stack
- **9-Phase TDD Workflow** - Structured development
- **76 Slash Commands** - All development tasks covered
- **43 Quality Rules** - Always enforced
- **Learning System** - Self-improvement via Supabase with memory auto-load

## What's New in v1.7.0

**Auto-Learn** - Automatic feedback detection:

- **Correction Detection** - "no", "wrong", "don't do" → auto-captured
- **Approval Detection** - "good", "great", "perfect" → auto-captured
- **Pattern Recognition** - After 3+ similar corrections, creates pattern
- **Local + Cloud** - Stores in `.cursor/cache/` and Supabase

```bash
# No commands needed - happens automatically!
# When you say "stop adding comments", Cursor learns:
🧠 Learning: Captured correction [code_style:minimal_comments] (1x)
```

**Requirements:** Supabase (free tier works). See `.cursor/docs/LEARNING_SYSTEM.md`

---

### MCP Servers

| MCP Server | Purpose | Default |
|------------|---------|---------|
| context7 | Library docs lookup | ✅ Enabled |
| playwright | E2E/browser testing | ✅ Enabled |
| filesystem | File operations | ✅ Enabled |
| memory | Persistent context | ✅ Enabled |
| laravel-boost | Laravel AI (15+ tools) | Disabled* |
| nodejs-debugger | Node.js runtime debugging | Disabled* |
| github | Git/GitHub operations | Disabled* |
| vitest | Unit testing | Disabled* |
| atlassian | JIRA/Confluence | Disabled* |
| figma | Design tokens | Disabled* |
| slack | Team notifications | Disabled* |

*Requires setup. Laravel Boost needs `composer require laravel/boost --dev`

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

### 🤖 16 Specialized Agents

**Development:**
- mobile-react-native, mobile-flutter
- web-angular, web-vuejs, web-reactjs, web-nextjs
- backend-nodejs, backend-python, backend-go, backend-laravel
- database-specialist

**Quality & Operations:**
- security-expert, qa-automation, ui-designer
- devops-cicd, project-detector

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
├── mcp.json                    # MCP server configuration
├── cache/                      # Memory cache for learned patterns
├── rules/
│   ├── core/                   # 43 quality rules
│   ├── agents/                 # 16 specialized agents
│   └── skills/auto-invoke/     # 12 auto-invoke skills
├── commands/                   # 76 slash commands
│   └── learn/                  # Learning system commands
├── workflows/                  # 9-phase workflow system
├── scripts/
│   ├── workflow/               # Workflow management scripts
│   └── learn/                  # Learning system scripts
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
| MCP Servers | 11 (4 enabled, 7 optional) |
| Agents | 16 |
| Commands | 76 |
| Rules | 43 |
| Skills | 13 (auto-invoke) |
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

**Version:** 1.8.0
**Last Updated:** 2026-01-14
