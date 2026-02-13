# /mcp:status

## Description

Display the status of all configured MCP servers. Shows which servers are enabled, disabled, and their connection health.

## Usage

```
/mcp:status
```

## Output Format

```
MCP Server Status
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Enabled:
  context7        ✅ Library docs
  playwright      ✅ E2E testing
  github          ✅ Git operations
  filesystem      ✅ File operations
  memory          ✅ Persistent context
  vitest          ✅ Unit testing
  atlassian       ✅ JIRA/Confluence
  figma           ✅ Design tokens
  slack           ✅ Team notifications

Disabled:
  laravel-boost   ❌ Requires setup
  nodejs-debugger ❌ Requires setup
  firebase        ❌ Requires setup
  firebase-comm.  ❌ Requires setup

Total: 13 servers (9 enabled, 4 disabled)
```

## Configuration

MCP servers are configured in `.cursor/mcp.json`. To enable a disabled server:
1. Add required environment variables to `.envrc`
2. Set `"disabled": false` in `.cursor/mcp.json`
3. Restart Cursor IDE

## Related Commands

- `/setup:integrations` - Configure MCP integrations
- `/project:status` - Overall project status

---

**Source:** Aura Frog v1.11.0
**Created:** 2026-02-13
