# Integration Setup Guide

**Version:** 1.10.0
**Last Updated:** 2026-01-15

---

## Overview

Aura Frog uses **MCP (Model Context Protocol) servers** for all integrations. No bash scripts needed.

**Configuration:** `.cursor/mcp.json`
**Credentials:** `.envrc` (project root)

---

## Quick Setup (5 minutes)

### Step 1: Copy Environment Template

```bash
cp .cursor/.envrc.template .envrc
```

### Step 2: Add Your Credentials

Edit `.envrc` and fill in the credentials for integrations you want:

```bash
# JIRA + Confluence (OAuth - no tokens needed!)
# Just enable atlassian in mcp.json, browser opens on first use

# Figma
export FIGMA_API_KEY="your_figma_token_here"

# Slack (uses slack-mcp-server)
export SLACK_TOKEN="xoxc-or-xoxb-your-token"
export SLACK_TEAM_ID="T1234567890"

# GitHub
export GITHUB_TOKEN="ghp_your_token_here"
```

### Step 3: Enable MCP Servers

Edit `.cursor/mcp.json` and set `"disabled": false` for servers you want:

```json
{
  "mcpServers": {
    "atlassian": {
      "disabled": false  // Change from true to false
    }
  }
}
```

### Step 4: Restart Cursor

MCP servers load on Cursor startup. Restart to pick up changes.

---

## Available MCP Servers

| Server | Purpose | Default | Needs Credentials |
|--------|---------|---------|-------------------|
| `context7` | Library documentation | ✅ Enabled | No |
| `playwright` | Browser automation | ✅ Enabled | No |
| `filesystem` | File operations | ✅ Enabled | No |
| `memory` | Persistent context | ✅ Enabled | No |
| `atlassian` | JIRA + Confluence | ❌ Disabled | No (OAuth) |
| `figma` | Design extraction | ❌ Disabled | Yes |
| `slack` | Team notifications | ❌ Disabled | Yes |
| `github` | Git operations | ❌ Disabled | Yes |
| `vitest` | Test running | ❌ Disabled | No |

---

## Getting Credentials

### Atlassian (JIRA + Confluence)

**No API token needed!** Uses Official Atlassian Remote MCP Server with OAuth:

1. Enable `atlassian` in `.cursor/mcp.json` (`"disabled": false`)
2. Restart Cursor
3. On first use, browser opens for Atlassian login
4. Approve permissions - done!

### Figma

1. Go to https://www.figma.com/settings
2. Scroll to "Personal Access Tokens"
3. Click "Generate new token"
4. Copy token to `.envrc`

### Slack

**Option 1: Stealth Mode** (no app/bot required)
1. Open Slack in browser, open DevTools → Application → Cookies
2. Copy `d` cookie value (starts with `xoxd-`)
3. Or extract token from localStorage (starts with `xoxc-`)
4. Get Team ID from workspace URL

**Option 2: OAuth Mode**
1. Go to https://api.slack.com/apps
2. Create app → "From scratch"
3. OAuth & Permissions → Add scopes: `chat:write`, `channels:read`
4. Install to workspace
5. Copy "Bot User OAuth Token" (starts with `xoxb-`) to `.envrc`

### GitHub

1. Go to https://github.com/settings/tokens
2. Generate new token (classic)
3. Select scopes: `repo`, `read:org`
4. Copy token to `.envrc`

---

## Verify MCP Status

In Cursor:
1. **Settings** → **Features** → **MCP**
2. Check server status:
   - 🟢 Green = Running
   - 🔴 Red = Failed (check logs)
   - ⚫ Gray = Disabled

---

## Usage Examples

### JIRA

When you mention a ticket ID, the AI uses MCP automatically:

```
Implement PROJ-1234
```

The `atlassian` MCP server fetches ticket details.

### Figma

When you share a Figma link:

```
Implement the design from https://figma.com/file/ABC123/Design
```

The `figma` MCP server extracts design data.

### Confluence

```
Publish this to Confluence in the DEV space
```

Uses `atlassian` MCP server's Confluence tools.

---

## Troubleshooting

### MCP Server Won't Start

1. Check credentials in `.envrc`
2. Verify `npx` is in PATH
3. Check Cursor MCP logs
4. Restart Cursor

### "Tool not found"

The MCP server isn't loaded:
1. Check `.cursor/mcp.json` - is `disabled: false`?
2. Restart Cursor
3. Check Settings → Features → MCP for errors

### Environment Variables Not Loading

```bash
# Install direnv
brew install direnv

# Add to shell (~/.zshrc)
eval "$(direnv hook zsh)"

# Allow in project
direnv allow
```

---

## Security

### DO
- Keep `.envrc` gitignored
- Use separate tokens per project
- Rotate tokens every 90 days

### DON'T
- Commit `.envrc` to git
- Share tokens in chat/email
- Use production tokens for dev

---

**Version:** 1.10.0
**Last Updated:** 2026-01-15
