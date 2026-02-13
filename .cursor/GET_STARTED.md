# Getting Started with Aura Frog

🐸 **Welcome to Aura Frog** - MCP-first AI development for Cursor IDE!

---

## Quick Start (5 Minutes)

### Step 1: Install

```bash
git clone https://github.com/nguyenthienthanh/aura-frog-cursor.git
./aura-frog-cursor/setup.sh /path/to/your/project
```

### Step 2: Verify

Open your project in Cursor. Check MCP servers are loaded:
- `context7` - Library docs
- `playwright` - E2E testing
- `filesystem` - File operations
- `memory` - Persistent context

### Step 3: Initialize Project

```
/project:init
```

### Step 4: Start Coding

```
/workflow:start "Your task description"
```

That's it! 🎉

---

## MCP Servers

Aura Frog uses Model Context Protocol for all integrations.

### Always Enabled

| Server | Purpose | Auto-Triggers |
|--------|---------|---------------|
| context7 | Library docs | When you ask about libraries |
| playwright | E2E testing | "e2e test", "browser test" |
| filesystem | File operations | File read/write |
| memory | Persistent context | Session handoff |

### Optional (Add Credentials)

| Server | Purpose | Trigger Pattern |
|--------|---------|-----------------|
| github | Git/PR/Issues | "create PR", GitHub URLs |
| vitest | Unit testing | "unit test", "coverage" |
| atlassian | JIRA/Confluence | `PROJ-1234` patterns |
| figma | Design tokens | `figma.com/file/...` URLs |
| slack | Notifications | `#channel`, "notify team" |

### Enable Optional Servers

1. Edit `.envrc`:
```bash
export GITHUB_TOKEN="ghp_xxx"
export ATLASSIAN_API_TOKEN="xxx"
export FIGMA_API_KEY="figd_xxx"
```

2. Edit `.cursor/mcp.json`:
```json
"github": {
  "disabled": false  // Change from true
}
```

3. Restart Cursor

---

## MCP Auto-Chaining

MCP tools automatically chain with agents and workflows:

```
User: "Implement PROJ-1234 using figma.com/file/XYZ"

Auto-chain:
1. atlassian MCP → fetch JIRA requirements
2. figma MCP → fetch design tokens
3. workflow-orchestrator → start 9-phase workflow
4. Phase 1 + Phase 3 auto-populated
```

### Trigger Examples

| You Say | MCP Used | What Happens |
|---------|----------|--------------|
| "Work on PROJ-123" | atlassian | Fetches ticket, starts workflow |
| "Implement figma.com/file/ABC" | figma | Extracts design, activates ui-designer |
| "Write e2e tests for login" | playwright | Opens browser, generates tests |
| "Run unit tests" | vitest | Runs tests, shows coverage |
| "Create PR for this" | github | Creates PR with auto-description |

---

## The 9-Phase Workflow

```
Planning (Phases 1-4)
├── Phase 1: Understand    → Requirements
├── Phase 2: Design        → Technical plan
├── Phase 3: UI Breakdown  → Components
└── Phase 4: Test Planning → Test strategy

Building (Phase 5)
├── Phase 5a: RED          → Write failing tests
├── Phase 5b: GREEN        → Implement code
└── Phase 5c: REFACTOR     → Clean up

Review (Phases 6-9)
├── Phase 6: Review        → Code quality
├── Phase 7: Verify        → QA validation
├── Phase 8: Document      → Documentation
└── Phase 9: Share         → Deploy/notify
```

---

## Key Commands

### Workflow
```
/workflow:start "task"     # Start workflow
/workflow:status           # Check progress
/workflow:approve          # Approve phase
/workflow:handoff          # Save for new session
/workflow:resume {id}      # Continue workflow
```

### Quick Actions
```
/bugfix:quick "issue"      # Fast bug fix
/test:unit {file}          # Add unit tests
/quality:check             # Quality scan
/misc:refactor {file}      # Refactor code
```

### Project
```
/project:init              # Initialize project
/project:detect            # Detect tech stack
/agent:list                # List agents
```

---

## 16 Specialized Agents

Automatically selected based on your project and task:

**Frontend:** web-reactjs, web-vuejs, web-angular, web-nextjs
**Mobile:** mobile-react-native, mobile-flutter
**Backend:** backend-nodejs, backend-python, backend-go, backend-laravel
**Specialists:** database-specialist, security-expert, qa-automation, ui-designer, devops-cicd, project-detector

---

## Multi-Session Workflows

When approaching token limit (~150K):

```
# Save state
/workflow:handoff

# In new Cursor session
/workflow:resume {workflow-id}
```

The `memory` MCP server helps persist context across sessions.

---

## Configuration

### Project Context

Located at `.cursor/project-contexts/[project]/`:
- `conventions.md` - Your naming/coding patterns
- `project-config.yaml` - Tech stack config
- `rules.md` - Project-specific rules

Edit these to teach Aura Frog YOUR patterns.

### MCP Configuration

Located at `.cursor/mcp.json` - Add/remove/configure MCP servers.

### Environment

Located at `.envrc` - API credentials for optional MCP servers.

---

## Creating Custom MCP Servers

Want to build your own MCP server instead of using open-source?

See **[docs/MCP.md](docs/MCP.md)** for:
- MCP architecture overview
- TypeScript/Python examples
- Registering in mcp.json
- Auto-invoke integration

---

## Troubleshooting

### MCP Server Not Working

1. Check `.cursor/mcp.json` configuration
2. Verify credentials in `.envrc`
3. Restart Cursor
4. Check Cursor's MCP logs

### Agent Not Activating

```
/agent:activate "agent-name"
```

### Token Limit Exceeded

```
/workflow:handoff
# Open new session
/workflow:resume {id}
```

---

## Documentation

- **[docs/MCP.md](docs/MCP.md)** - MCP server guide
- **[commands/QUICK_REFERENCE.md](commands/QUICK_REFERENCE.md)** - All commands
- **[workflows/QUICK_REFERENCE.md](workflows/QUICK_REFERENCE.md)** - Workflow guide

---

**Code with main character energy!** 🐸✨

**Version:** 1.11.0
**Last Updated:** 2026-02-13
