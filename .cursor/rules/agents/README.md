# Aura Frog Agents - Cursor IDE Format

## Overview

This directory contains **23 specialized Aura Frog agents** converted to Cursor IDE MDC format.

## Conversion Status

**Completed:** 23/23 agents (100%)

---

## Agent Categories

### Development Agents (11)

| Agent | File | Description |
|-------|------|-------------|
| mobile-react-native | `mobile-react-native.mdc` | React Native + Expo expert |
| mobile-flutter | `mobile-flutter.mdc` | Flutter + Dart cross-platform |
| web-reactjs | `web-reactjs.mdc` | React 18 SPA expert |
| web-nextjs | `web-nextjs.mdc` | Next.js App Router expert |
| web-vuejs | `web-vuejs.mdc` | Vue.js 3 + Composition API |
| web-angular | `web-angular.mdc` | Angular 17+ Signals expert |
| backend-nodejs | `backend-nodejs.mdc` | Node.js/Express/NestJS |
| backend-python | `backend-python.mdc` | Django/FastAPI/Flask |
| backend-go | `backend-go.mdc` | Go/Gin/Fiber |
| backend-laravel | `backend-laravel.mdc` | PHP/Laravel |
| database-specialist | `database-specialist.mdc` | Schema, queries, migrations |

### Quality & Security (3)

| Agent | File | Description |
|-------|------|-------------|
| qa-automation | `qa-automation.mdc` | Testing, coverage, E2E |
| security-expert | `security-expert.mdc` | OWASP, vulnerability scanning |
| ui-designer | `ui-designer.mdc` | Design analysis, accessibility |

### DevOps & Operations (5)

| Agent | File | Description |
|-------|------|-------------|
| devops-cicd | `devops-cicd.mdc` | Docker, K8s, CI/CD pipelines |
| jira-operations | `jira-operations.mdc` | JIRA ticket management |
| confluence-operations | `confluence-operations.mdc` | Documentation publishing |
| slack-operations | `slack-operations.mdc` | Team notifications |
| voice-operations | `voice-operations.mdc` | TTS/audio notifications |

### Infrastructure (4)

| Agent | File | Description |
|-------|------|-------------|
| project-detector | `project-detector.mdc` | Auto project type detection |
| project-config-loader | `project-config-loader.mdc` | Load project configurations |
| project-context-manager | `project-context-manager.mdc` | Session state persistence |
| pm-operations-orchestrator | `pm-operations-orchestrator.mdc` | 9-phase workflow coordinator |

> **Note:** `agent-detector` is now a skill at `skills/auto-invoke/agent-detector.mdc`

---

## MDC Format Structure

Each agent uses Cursor's MDC format with YAML frontmatter:

```markdown
---
description: "One-sentence agent description"
globs:
  - "**/*.{ext}"
  - "**/pattern/**/*"
alwaysApply: false
---

# Agent Name

## Role & Expertise
## When to Activate
## Tech Stack
## Best Practices (CRITICAL)
## Quality Standards
## Cross-Agent Collaboration
```

---

## Always-Active Agents

The following agents have `alwaysApply: true`:

1. **project-detector** - Auto-detects project type from files
2. **project-config-loader** - Loads project configurations
3. **project-context-manager** - Manages session state
4. **pm-operations-orchestrator** - Coordinates workflow

> **Note:** `agent-detector` skill (at `skills/auto-invoke/`) also has `alwaysApply: true`

---

## Agent Activation

Agents auto-activate based on:

1. **Glob patterns** - File patterns in frontmatter
2. **Keywords** - Mentioned terms in user query
3. **Project type** - Detected by project-detector
4. **Explicit activation** - User requests specific agent

---

## Usage

### Automatic
Cursor automatically loads agents when files match glob patterns.

### Explicit
Request specific agent expertise:
- "Use the backend-nodejs agent..."
- "Apply security-expert review..."
- "Follow mobile-flutter conventions..."

---

## Documentation

- **Main instructions:** `.cursor/AGENTS.md`
- **Quick start:** `.cursor/GET_STARTED.md`
- **Workflow phases:** `.cursor/workflows/phases/`
- **Commands:** `.cursor/commands/`

---

**Version:** 1.3.0
**Last Updated:** 2025-12-22
**Status:** Complete (24/24 agents)
