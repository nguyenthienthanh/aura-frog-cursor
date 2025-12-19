# Cursor Scripts

Minimal workflow management scripts. Most functionality now handled by MCP servers.

## Scripts

### Workflow Management
- `workflow/init-workflow.sh` - Initialize new workflow
- `workflow/workflow-manager.sh` - Manage workflows (list, switch, load, delete)
- `workflow/workflow-status.sh` - Show workflow status
- `workflow/phase-transition.sh` - Handle phase transitions
- `workflow/track-tokens.sh` - Track token usage
- `workflow/migrate-workflows.sh` - Migrate workflow formats

## Usage

```bash
# Initialize workflow
bash .cursor/scripts/workflow/init-workflow.sh "Task description"

# List workflows
bash .cursor/scripts/workflow/workflow-manager.sh list

# Check status
bash .cursor/scripts/workflow/workflow-status.sh
```

## Replaced by MCP

| Old Script | Now Use |
|------------|---------|
| `test/run-tests.sh` | `vitest` MCP |
| `test/coverage-report.sh` | `vitest` MCP |
| `detect-design-system.sh` | AI detects directly |
| `discover-agents.sh` | Not needed |
| `generate-report.sh` | AI generates directly |
| `validate-config.sh` | AI validates directly |

See `.cursor/mcp.json` for available MCP servers.
