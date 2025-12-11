# Aura Frog for Cursor IDE

**Version:** 1.1.5
**Converted from:** [nguyenthienthanh/aura-frog](https://github.com/nguyenthienthanh/aura-frog) (Aura Frog Plugin for Claude Code)
**Adapted for:** Cursor IDE
**Last Updated:** 2025-12-11

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
│   ├── core/                         # 37 core quality rules
│   ├── agents/                       # 24 specialized agents
│   ├── skills/                       # 29 skills (10 auto-invoke, 19 reference)
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
│   ├── confluence-operations.sh
│   └── ...
│
├── 📂 templates/                     # Document templates
│   ├── tech-spec.md
│   ├── requirements.md
│   ├── test-plan.md
│   └── ...
│
├── 📂 documents/                     # Generated documentation output
│   ├── features/
│   ├── api/
│   ├── components/
│   ├── specs/
│   └── guides/
│
└── 📂 project-contexts/              # Project customization
    └── [project-name]/
```

---

## 🎯 Key Features

✅ **24 Specialized Agents** - Auto-detect based on context
✅ **9-Phase TDD Workflow** - Structured development (RED-GREEN-REFACTOR)
✅ **70+ Slash Commands** - All development tasks covered
✅ **37 Quality Rules** - Always enforced
✅ **29 Skills** - 10 auto-invoke + 19 reference skills
✅ **Mermaid Diagrams** - Sequence, ERD, Architecture, State diagrams
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
- `rules/hooks/README.md` - Hooks lifecycle
- `rules/templates/README.md` - Templates usage
- `commands/README.md` - Commands overview
- `commands/QUICK_REFERENCE.md` - Quick command lookup
- `workflows/QUICK_REFERENCE.md` - Workflow cheat sheet
- `workflows/STATE_MANAGEMENT.md` - State persistence

---

## 🐸 Agent Identification Banner

Every response shows (single or multi-agent):

**Single Agent:**
```
⚡ 🐸 AURA FROG v1.1.5 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
┃ Agent: mobile-react-native │ Phase: 2 - Design         ┃
┃ 🔥 Code go brrrr                                        ┃
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Multiple Agents (collaboration):**
```
⚡ 🐸 AURA FROG v1.1.5 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
┃ Agent: mobile-react-native (+qa-automation)            ┃
┃ Phase: 5b - TDD GREEN │ 🔥 Building with tests          ┃
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Environment Setup (Optional)

Copy and configure environment template:

```bash
cp .cursor/.envrc.template .cursor/.envrc
```

Then edit `.cursor/.envrc` with your integration tokens:
- JIRA_URL, JIRA_EMAIL, JIRA_API_TOKEN
- FIGMA_ACCESS_TOKEN
- SLACK_WEBHOOK_URL
- CONFLUENCE (optional - defaults to JIRA credentials)

**Note:** Confluence uses the same Atlassian account as JIRA, so JIRA credentials work for both.

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

- **Total Files:** 250+
- **Total Size:** ~1.5 MB
- **MDC Rules:** 103 files
- **Commands:** 70+ slash commands
- **Agents:** 24 specialized agents
- **Skills:** 29 (10 auto-invoke, 19 reference)
- **Core Rules:** 37 quality rules

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

**Version:** 1.1.5
**Last Updated:** 2025-12-11
**Original:** [nguyenthienthanh/aura-frog](https://github.com/nguyenthienthanh/aura-frog)
