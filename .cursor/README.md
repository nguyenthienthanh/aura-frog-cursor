# Aura Frog for Cursor IDE

**Version:** 1.0.0
**Converted from:** [nguyenthienthanh/aura-frog](https://github.com/nguyenthienthanh/aura-frog) (Aura Frog Plugin for Claude Code)
**Adapted for:** Cursor IDE
**Conversion Date:** 2025-11-30

---

## 🚀 Quick Start

### 1. Read the Guide

```bash
cat .cursor/GET_STARTED.md
```

### 2. Initialize Project

```bash
/project:init
```

### 3. Start First Workflow

```bash
/workflow:start "Your task description"
```

---

## 📂 Structure

```
.cursor/
├── 📄 AGENTS.md                      # Main AI instructions
├── 📄 GET_STARTED.md                 # Complete user guide
├── 📄 README.md                      # This file
├── 📄 .envrc.template                # Environment setup
│
├── 📂 rules/                         # All rules (MDC format)
│   ├── core/                         # 26 core quality rules
│   ├── agents/                       # 24 specialized agents
│   ├── skills/                       # 14 auto-invoking skills
│   ├── hooks/                        # 4 lifecycle hooks
│   └── templates/                    # 8 documentation templates
│
├── 📂 commands/                      # 70 slash commands
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
│   └── ...
│
└── 📂 project-contexts/              # Project customization
    └── [project-name]/
```

---

## 🎯 Key Features

✅ **24 Specialized Agents** - Auto-detect based on context
✅ **9-Phase TDD Workflow** - Structured development (RED-GREEN-REFACTOR)
✅ **70 Slash Commands** - All development tasks covered
✅ **26 Quality Rules** - Always enforced
✅ **14 Auto-Invoking Skills** - Context-aware activation
✅ **Multi-Session Support** - Workflow handoff/resume
✅ **Project Customization** - Generic core + project context
✅ **Integrations** - JIRA, Figma, Slack, Confluence

---

## 📚 Documentation

### Essential Reading

1. **GET_STARTED.md** - Complete quick start guide (read this first!)
2. **AGENTS.md** - Main AI instructions (for Cursor)

### Component Guides

Located in subdirectories:
- `rules/core/README.md` - Core rules overview
- `rules/agents/README.md` - Agents guide
- `rules/skills/README.md` - Skills guide
- `rules/hooks/README.md` - Hooks lifecycle
- `rules/templates/README.md` - Templates usage
- `commands/README.md` - Commands overview
- `commands/QUICK_REFERENCE.md` - Quick command lookup
- `commands/INDEX.md` - Alphabetical index
- `workflows/QUICK_REFERENCE.md` - Workflow cheat sheet
- `workflows/STATE_MANAGEMENT.md` - State persistence

---

## 🐸 Agent Identification Banner

Every response shows:

```
⚡ 🐸 AURA FROG v1.0.0 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
┃ Agent: mobile-react-native │ Phase: 2 - Design        ┃
┃ 🔥 Code go brrrr                                       ┃
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## ⚙️ Environment Setup (Optional)

Copy and configure environment template:

```bash
cp .cursor/.envrc.template .envrc
```

Then edit `.envrc` with your integration tokens:
- JIRA_URL, JIRA_EMAIL, JIRA_API_TOKEN
- FIGMA_ACCESS_TOKEN
- SLACK_WEBHOOK_URL
- CONFLUENCE_URL, CONFLUENCE_EMAIL, CONFLUENCE_API_TOKEN

---

## 💡 Common Commands

### Workflow
```bash
/workflow:start "Task description"   # Start 9-phase workflow
/workflow:status                     # Check progress
/workflow:handoff                    # Save state (at 150K tokens)
/workflow:resume {id}                # Continue in new session
```

### Quick Actions
```bash
/bugfix:quick "Description"          # Fast bug fix
/test:unit {file}                    # Add unit tests
/quality:check                       # Quality analysis
/security:scan                       # Security audit
/misc:refactor {file}                # Refactor code
```

### Project
```bash
/project:init                        # Initialize project
/project:detect                      # Detect project type
/agent:list                          # List all agents
```

See all commands: `cat .cursor/commands/QUICK_REFERENCE.md`

---

## 📊 Statistics

- **Total Files:** 164
- **Total Size:** 1.1 MB
- **Rules:** 76 .mdc files
- **Commands:** 70+ slash commands
- **Documentation:** 97 .md files
- **Scripts:** ~20 integration scripts

---

## 🎓 Learn More

1. **Start here:** `cat .cursor/GET_STARTED.md`
2. **Commands:** `cat .cursor/commands/QUICK_REFERENCE.md`
3. **Workflow:** `cat .cursor/workflows/QUICK_REFERENCE.md`
4. **Component guides:** Check README.md files in subdirectories

---

## 📚 Sources & References

### Original Source
- **Aura Frog Plugin:** [github.com/nguyenthienthanh/aura-frog](https://github.com/nguyenthienthanh/aura-frog)

### Cursor IDE Documentation
- [Cursor Rules Documentation](https://docs.cursor.com/context/rules)
- [Cursor Agent Overview](https://docs.cursor.com/agent/overview)

### Conversion References
- [Awesome Cursor Rules by PatrickJS](https://github.com/PatrickJS/awesome-cursorrules)
- [Awesome Cursor Rules Guide - Apidog](https://apidog.com/blog/awesome-cursor-rules/)
- [Cursor IDE Rules for AI - Kirill Markin](https://kirill-markin.com/articles/cursor-ide-rules-for-ai/)

---

**Code with main character energy!** 🐸✨

**Version:** 1.0.0
**Converted:** 2025-11-30
**Original:** [nguyenthienthanh/aura-frog](https://github.com/nguyenthienthanh/aura-frog)
