# Aura Frog Commands - Cursor Slash Command Format

**Last Updated:** 2025-12-04
**Source:** Aura Frog v1.1.9  
**Total Commands:** 70

---

## Overview

This directory contains all Aura Frog commands converted to Cursor IDE slash command format. All 70+ commands from the Aura Frog workflow system are now available as Cursor slash commands.

## Quick Start

### 1. Initialize Aura Frog
```bash
/project:init
```

### 2. Start Workflow
```bash
/workflow:start "Add user authentication"
```

### 3. Check Status
```bash
/workflow:status
```

---

## Command Summary by Category

**Workflow** (18): workflow management and orchestration
**Bug Fix** (3): quick, standard, and hotfix workflows
**Testing** (4): unit, e2e, coverage, documentation
**Quality** (3): checks, debt analysis, complexity
**Security** (3): scan, audit, dependency checks
**Deploy** (3): setup, docker, CI/CD
**Project** (5): init, detect, regen, list, switch
**Agent** (4): list, info, activate, deactivate
**Planning** (3): plan, refine, list
**Setup** (2): activate, integrations
**Performance** (4): analyze, optimize, bundle, lighthouse
**API** (2): design, test
**Database** (2): design, optimize
**Monitor** (2): setup, errors
**Logs** (1): analyze
**Review** (1): fix
**Skill** (1): create
**Misc** (4): document, refactor, help, execute

---

## Key Commands

**Essential:**
- `/project:init` - Initialize Aura Frog (required first step)
- `/workflow:start` - Start 9-phase workflow
- `/workflow:status` - Check progress
- `/workflow:approve` - Approve phase

**Multi-Session:**
- `/workflow:handoff` - Save state at 150K+ tokens
- `/workflow:resume` - Continue in new session

**Quick Actions:**
- `/bugfix:quick` - Fast bug fix
- `/test:unit` - Add unit tests
- `/misc:refactor` - Refactor code

---

## Directory Structure

```
.cursor/commands/
├── workflow/     # 18 workflow commands
├── bugfix/       # 3 bug fix commands
├── test/         # 4 testing commands
├── quality/      # 3 quality commands
├── security/     # 3 security commands
├── deploy/       # 3 deployment commands
├── project/      # 5 project commands
├── agent/        # 4 agent commands
├── planning/     # 3 planning commands
├── setup/        # 2 setup commands
├── perf/         # 4 performance commands
├── api/          # 2 API commands
├── db/           # 2 database commands
├── monitor/      # 2 monitoring commands
├── logs/         # 1 log command
├── review/       # 1 review command
├── skill/        # 1 skill command
└── misc/         # 4 miscellaneous commands
```

---

## Integration Support

Configure in `.envrc`:
- JIRA: Ticket tracking and updates
- Figma: Design import
- Slack: Team notifications
- Confluence: Documentation

Setup: `/setup:integrations`

---

**Generated:** 2025-11-30  
**Ready to use!** ✨
