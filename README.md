# 🐸 Aura Frog for Cursor IDE

**A complete conversion of the Aura Frog plugin from Claude Code to Cursor IDE format**

> Code with main character energy ✨

## Overview

This repository contains the **Aura Frog** system adapted for **Cursor IDE**, providing a comprehensive AI-powered development workflow with:

- **24 Specialized Agents** - Auto-detect based on your tech stack
- **9-Phase TDD Workflow** - Structured development (RED-GREEN-REFACTOR)
- **70+ Slash Commands** - All development tasks covered
- **26 Quality Rules** - Always enforced
- **14 Auto-Invoking Skills** - Context-aware activation
- **Multi-Session Support** - Workflow handoff/resume
- **JIRA & Figma Integration** - With cache-first approach

## Original Source

This is a conversion of the **Aura Frog** plugin for Claude Code:
- **Original Repository:** [github.com/nguyenthienthanh/aura-frog](https://github.com/nguyenthienthanh/aura-frog)
- **Converted for:** Cursor IDE
- **Conversion Date:** 2025-11-30
- **Version:** 1.0.0

## Quick Start

### 1. Installation

Copy the `.cursor` directory and `.cursorrules` file to your project root:

```bash
# Clone this repository
git clone https://github.com/nguyenthienthanh/aura-frog-cursor.git

# Copy to your project
cp -r aura-frog-cursor/.cursor /path/to/your/project/
cp aura-frog-cursor/.cursorrules /path/to/your/project/
```

### 2. Initialize Project

Open your project in Cursor IDE and run:

```
/project:init
```

This will:
- Detect your tech stack
- Create project context in `.cursor/project-contexts/[project]/`
- Extract conventions from your codebase
- Generate project-specific rules

### 3. Start Your First Workflow

```
/workflow:start "Your task description"
```

That's it! Aura Frog will guide you through all 9 phases.

## Key Features

### 🤖 24 Specialized Agents

**Development (11):**
- mobile-react-native, mobile-flutter
- web-angular, web-vuejs, web-reactjs, web-nextjs
- backend-nodejs, backend-python, backend-go, backend-laravel
- database-specialist

**Quality & Security (3):**
- security-expert, qa-automation, ui-designer

**DevOps & Operations (5):**
- devops-cicd, jira-operations, confluence-operations
- slack-operations, voice-operations

**Infrastructure (5):**
- smart-agent-detector, pm-operations-orchestrator
- project-detector, project-config-loader, project-context-manager

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
Phase 9: Share           → Deployment & notifications
```

### ⚡ 70+ Slash Commands

**Workflow:**
```
/workflow:start "task"
/workflow:status
/workflow:approve
/workflow:handoff
/workflow:resume {id}
```

**Quick Actions:**
```
/bugfix:quick "description"
/test:unit {file}
/quality:check
/security:scan
/misc:refactor {file}
```

**See all:** `/misc:help`

### 🔗 Integrations

**JIRA Integration:**
```
/workflow:start "PROJ-1234"
```
- Auto-fetches ticket details
- Cache-first approach (checks `.cursor/logs/jira/` first)
- Updates ticket status throughout workflow

**Figma Integration:**
```
/workflow:start "Implement https://figma.com/file/ABC123"
```
- Auto-extracts design tokens
- Cache-first approach (checks `.cursor/logs/figma/` first)
- Generates component structure

## Structure

```
.cursor/
├── 📄 AGENTS.md                      # Main AI instructions
├── 📄 README.md                      # System overview
├── 📄 GET_STARTED.md                 # Quick start guide
│
├── 📂 rules/                         # All rules (MDC format)
│   ├── core/                         # 26 core quality rules
│   ├── agents/                       # 24 specialized agents
│   ├── skills/                       # 14 auto-invoking skills
│   ├── hooks/                        # 4 lifecycle hooks
│   └── templates/                    # 8 documentation templates
│
├── 📂 commands/                      # 70+ slash commands
│   ├── workflow/                     # Workflow orchestration
│   ├── bugfix/                       # Bug fixes
│   ├── test/                         # Testing
│   └── ... (19 categories)
│
├── 📂 workflows/                     # 9-phase workflow system
│   ├── phases/                       # Phase guides
│   ├── QUICK_REFERENCE.md
│   └── STATE_MANAGEMENT.md
│
├── 📂 scripts/                       # Integration scripts
│   ├── jira-fetch.sh
│   ├── figma-fetch.sh
│   ├── workflow/
│   │   └── workflow-manager.sh
│   └── ...
│
└── 📂 project-contexts/              # Project customization
    └── [your-project]/               # Generated by /project:init
```

## Configuration

### Environment Setup (Optional)

For JIRA and Figma integration, create `.envrc`:

```bash
# JIRA
export JIRA_URL="https://company.atlassian.net"
export JIRA_EMAIL="your-email@company.com"
export JIRA_API_TOKEN="your-token"

# Figma
export FIGMA_ACCESS_TOKEN="figd_your-token"

# Slack
export SLACK_WEBHOOK_URL="https://hooks.slack.com/..."

# Confluence
export CONFLUENCE_URL="https://company.atlassian.net"
export CONFLUENCE_EMAIL="your-email@company.com"
export CONFLUENCE_API_TOKEN="your-token"
```

**Important:** Add `.envrc` to `.gitignore`!

## Documentation

**Quick Start:**
- `.cursor/GET_STARTED.md` - Complete user guide
- `.cursor/README.md` - System overview

**Reference:**
- `.cursor/commands/QUICK_REFERENCE.md` - All commands
- `.cursor/workflows/QUICK_REFERENCE.md` - Workflow guide
- `.cursor/rules/core/README.md` - Quality rules

## Differences from Claude Code Version

1. **File Format:** MDC files (`.mdc`) instead of Markdown (`.md`)
2. **Commands:** Slash command format (`/workflow:start`) vs natural language
3. **Auto-loading:** `.cursor/rules/*.mdc` auto-loaded by Cursor
4. **Token Limit:** 200K tokens vs 1M (requires more frequent handoff)
5. **Paths:** `.cursor/` instead of `.claude/`

## Statistics

- **Total Files:** 167
- **Total Size:** 1.0 MB
- **MDC Rules:** 56 files
- **Commands:** 70+ slash commands
- **Agents:** 24 specialized agents
- **Skills:** 14 (9 auto-invoke, 5 reference)
- **Workflows:** 9 phases with 11 guide files

## Contributing

This is a conversion project. For contributions:
- **Bug fixes in conversion:** Open issue in this repo
- **Feature requests:** Suggest in original [Aura Frog](https://github.com/nguyenthienthanh/aura-frog) repo
- **Documentation improvements:** Welcome in this repo

## Credits & Sources

### Original Source
- **Aura Frog Plugin:** [github.com/nguyenthienthanh/aura-frog](https://github.com/nguyenthienthanh/aura-frog)

### Cursor IDE Documentation
- [Cursor Rules Documentation](https://docs.cursor.com/context/rules)
- [Cursor Agent Overview](https://docs.cursor.com/agent/overview)

### Conversion References
- [Awesome Cursor Rules by PatrickJS](https://github.com/PatrickJS/awesome-cursorrules)
- [Awesome Cursor Rules Guide - Apidog](https://apidog.com/blog/awesome-cursor-rules/)
- [Cursor IDE Rules for AI - Kirill Markin](https://kirill-markin.com/articles/cursor-ide-rules-for-ai/)

## License

Same as original Aura Frog plugin. Check the [original repository](https://github.com/nguyenthienthanh/aura-frog) for license details.

## Support

For questions:
1. Check `.cursor/GET_STARTED.md` in your project
2. Review command documentation in `.cursor/commands/`
3. Open an issue in this repository
4. Refer to original [Aura Frog documentation](https://github.com/nguyenthienthanh/aura-frog)

---

**Code with main character energy!** 🐸✨

**Version:** 1.0.0
**Converted:** 2025-11-30
**Original:** [nguyenthienthanh/aura-frog](https://github.com/nguyenthienthanh/aura-frog)
