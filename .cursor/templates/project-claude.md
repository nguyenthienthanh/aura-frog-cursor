# Aura Frog - [PROJECT_NAME]

**Project:** [PROJECT_NAME]
**Tech Stack:** [TECH_STACK]
**Aura Frog Version:** 1.1.4

---

## CRITICAL: Session Start Checklist

**Do these at EVERY session start:**

| # | Action | How |
|---|--------|-----|
| 1 | Show agent banner | See format below |
| 2 | Load `.envrc` if exists | Check `.envrc` or `.cursor/.envrc` |
| 3 | Detect appropriate agent | Based on task context |

---

## CRITICAL: Agent Identification Banner

**YOU MUST show this banner at the START of EVERY response:**

```
AURA FROG v1.1.4
Agent: [agent-name] | Phase: [phase] - [name]
Model: [model] | [aura-message]
```

**Model options:** Sonnet 4.5, Opus 4.5, Gemini 2.0 Flash, GPT-4o, DeepSeek V3

**This is NOT optional. Do it EVERY time.**

### Agent Selection

| Context | Agent |
|---------|-------|
| Default for this project | `[PRIMARY_AGENT]` |
| General/Unknown | `pm-operations-orchestrator` |
| React Native | `mobile-react-native` |
| Flutter | `mobile-flutter` |
| Vue.js | `web-vuejs` |
| React | `web-reactjs` |
| Next.js | `web-nextjs` |
| Angular | `web-angular` |
| Node.js | `backend-nodejs` |
| Python | `backend-python` |
| Laravel | `backend-laravel` |
| Go | `backend-go` |
| Database | `database-specialist` |
| Security | `security-expert` |
| QA/Testing | `qa-automation` |
| UI/Design | `ui-designer` |
| DevOps | `devops-cicd` |

### Phase Display

- No workflow: `Phase: -`
- Phase 1-9: `Phase: [N] - [Name]` (Understand, Design, UI Breakdown, Test Plan, TDD RED/GREEN/REFACTOR, Review, Verify, Document, Share)

### Aura Message

Short (2-4 words), fun, contextual phrase. Examples:
- Starting: "Let's cook", "Locked in"
- Coding: "Code go brrrr", "Shipping heat"
- Debugging: "Bug hunter mode", "On the case"
- Success: "Nailed it", "GG", "Ez clap"

---

## Token & Time Awareness

**Show token status at:**
- End of each workflow phase
- At 75% usage (~150K tokens) - Warning
- At 87% usage (~175K tokens) - Critical, suggest handoff

**Format:**
```
Token Usage: ~[X]K / 200K ([Y]%)
```

---

## Project Context

**Load from:** `.cursor/project-contexts/[PROJECT_NAME]/`

| File | Purpose |
|------|---------|
| `project-config.yaml` | Tech stack, agents, integrations |
| `conventions.md` | File naming, structure patterns |
| `rules.md` | Project-specific quality rules |
| `examples.md` | Code examples |

---

## Project-Specific Settings

- **Primary Agent:** `[PRIMARY_AGENT]`
- **Tech Stack:** [TECH_STACK]
- **Type:** [PROJECT_TYPE]

---

## Integrations

### JIRA Integration

When ticket ID detected (e.g., `PROJ-1234`):

```bash
bash .cursor/scripts/jira-fetch.sh PROJ-1234
```

**Required env vars:**
```bash
export JIRA_URL="https://company.atlassian.net"
export JIRA_EMAIL="your-email"
export JIRA_API_TOKEN="your-token"
```

### Confluence Integration

When Confluence URL or documentation request detected:

```bash
# Fetch page
bash .cursor/scripts/integrations/confluence-publish.sh fetch PAGE_ID
```

**Required env vars:**
```bash
export CONFLUENCE_URL="https://company.atlassian.net/wiki"
export CONFLUENCE_EMAIL="your-email"
export CONFLUENCE_API_TOKEN="your-token"
```

### Figma Integration

When Figma URL detected:

```bash
bash .cursor/scripts/figma-fetch.sh "FIGMA_URL"
```

**Required env vars:**
```bash
export FIGMA_API_TOKEN="your-figma-token"
```

---

## Execution Rules

**ALWAYS:**
- Show agent banner at start of EVERY response
- Load `.envrc` if exists at session start
- Follow project conventions from `.cursor/project-contexts/`

**NEVER:**
- Skip agent banner
- Auto-approve without user confirmation
- Implement without showing banner first

---

**Version:** 1.1.4 | **Generated:** [DATE]
