# Cursor Scripts

This directory contains scripts adapted from [CCPM Team Agents](https://github.com/nguyenthienthanh/ccpm-team-agents) for Cursor compatibility.

## 📁 Scripts Overview

### Workflow Scripts
- `workflow/init-workflow.sh` - Initialize new workflow
- `workflow/workflow-manager.sh` - Manage workflows (list, switch, load, delete)
- `workflow/workflow-status.sh` - Show workflow status
- `workflow/phase-transition.sh` - Handle phase transitions
- `workflow/track-tokens.sh` - Track token usage

### Utility Scripts
- `discover-agents.sh` - Discover and list all available agents
- `validate-config.sh` - Validate configuration files
- `generate-report.sh` - Generate workflow reports

### Integration Scripts
- `integrations/jira-sync.sh` - JIRA integration
- `integrations/confluence-publish.sh` - Confluence integration
- `integrations/slack-notify.sh` - Slack notifications
- `setup-integrations.sh` - Setup integrations
- `test-integrations.sh` - Test integrations

### Test Scripts
- `test/run-tests.sh` - Run tests
- `test/coverage-report.sh` - Generate coverage reports

## 🔄 Changes from Original

All scripts have been adapted to use `.cursor/` instead of `.cursor/`:
- Directory references updated
- Path variables changed from `CLAUDE_DIR` to `CURSOR_DIR`
- All file paths updated

## 🚀 Usage

Scripts can be run directly:

```bash
# Initialize workflow
bash .cursor/scripts/workflow/init-workflow.sh "Your task description"

# List workflows
bash .cursor/scripts/workflow/workflow-manager.sh list

# Track tokens
bash .cursor/scripts/workflow/track-tokens.sh show
```

## 📚 Source

Based on [CCPM Team Agents Scripts](https://github.com/nguyenthienthanh/ccpm-team-agents/tree/main/.cursor/scripts)

