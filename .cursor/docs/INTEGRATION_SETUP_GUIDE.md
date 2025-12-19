# Integration Setup Guide

**Version:** 1.1.9
**Last Updated:** 2025-12-04

---

## Table of Contents

1. [Quick Decision Guide](#1-quick-decision-guide)
2. [15-Minute Quick Setup](#2-15-minute-quick-setup)
3. [Detailed Setup](#3-detailed-setup)
4. [Script Usage](#4-script-usage)
5. [Troubleshooting](#5-troubleshooting)

---

## 1. Quick Decision Guide

### 1.1 Decision Tree

```
Do you track issues in JIRA?
    YES -> Enable JIRA Integration
    NO  -> Skip JIRA

Do you use Confluence for documentation?
    YES -> Enable Confluence Integration
    NO  -> Use local Markdown only

Do you want team notifications?
    YES -> Enable Slack Integration
    NO  -> Skip Slack

Do you have Figma designs?
    YES -> Enable Figma Integration (screenshots work without API)
    NO  -> Skip Figma
```

### 1.2 Integration Matrix

| Integration | Required For | Setup Time | Difficulty | Worth It? |
|-------------|--------------|------------|------------|-----------|
| **JIRA** | Issue tracking, auto-fetch tickets | 5 min | Easy | High |
| **Confluence** | Auto-publish docs | 5 min | Easy | High |
| **Slack** | Team notifications | 10 min | Medium | Medium |
| **Figma** | Design extraction | 5 min | Easy | High |

### 1.3 Common Setup Scenarios

#### Scenario 1: Solo Developer
**Recommended:** None or Figma only
- Figma (if you have designs)
- Skip JIRA (overkill for solo work)
- Skip Confluence (use local markdown)
- Skip Slack (no team to notify)

**Setup Time:** 5 minutes

#### Scenario 2: Small Team (2-5 people)
**Recommended:** JIRA + Figma
- JIRA (issue tracking)
- Figma (if designers involved)
- Slack (optional, useful for async updates)
- Confluence (optional, consider GitHub Wiki instead)

**Setup Time:** 15 minutes

#### Scenario 3: Medium Team (6-15 people)
**Recommended:** All integrations
- JIRA (essential for coordination)
- Confluence (centralized docs)
- Slack (team communication)
- Figma (design handoff)

**Setup Time:** 30 minutes

---

## 2. 15-Minute Quick Setup

### 2.1 Prerequisites

Install `jq` (required for all integrations):

```bash
# macOS
brew install jq

# Ubuntu/Debian
sudo apt install jq

# Verify
jq --version
```

### 2.2 Get All Tokens (10 min)

#### JIRA Token (2 min)
1. Go to https://id.atlassian.com/manage-profile/security/api-tokens
2. Click "Create API token"
3. Name: `Aura Frog`
4. Copy token -> Save for step 2.3

#### Figma Token (1 min)
1. Go to https://www.figma.com/settings
2. Scroll to "Personal Access Tokens"
3. Click "Generate new token"
4. Name: `Aura Frog`
5. Copy token -> Save for step 2.3

#### Slack Token (5 min)
1. Go to https://api.slack.com/apps
2. Click "Create New App" -> "From scratch"
3. Name: `Aura Frog Bot`, select workspace
4. Go to "OAuth & Permissions"
5. Add scopes: `chat:write`, `chat:write.public`
6. Click "Install to Workspace"
7. Copy "Bot User OAuth Token" (xoxb-...) -> Save for step 2.3
8. In Slack: `/invite @Aura Frog Bot` to your channel

#### Confluence Token (2 min)
Same as JIRA - Confluence uses the same Atlassian API token.

### 2.3 Configure `.envrc` (2 min)

**Location:** `.envrc` should be in your **project root**

```bash
# Copy template
cp .cursor/.envrc.template .envrc

# Edit and replace placeholders with your actual values
```

**Complete Configuration:**

```bash
# ============================================
# Project Configuration
# ============================================
export PROJECT_NAME="Your_Project_Name"
export PROJECT_ENV="development"

# ============================================
# JIRA Integration
# ============================================
export JIRA_URL="https://yourcompany.atlassian.net"
export JIRA_EMAIL="your.email@company.com"
export JIRA_API_TOKEN="paste_jira_token_here"
export JIRA_PROJECT_KEY="PROJ"

# ============================================
# Confluence Integration
# ============================================
export CONFLUENCE_URL="https://yourcompany.atlassian.net/wiki"
export CONFLUENCE_EMAIL="your.email@company.com"
export CONFLUENCE_API_TOKEN="paste_confluence_token_here"
export CONFLUENCE_SPACE_KEY="DEV"

# ============================================
# Slack Integration
# ============================================
export SLACK_BOT_TOKEN="paste_slack_token_here"
export SLACK_CHANNEL_ID="#dev-team"

# ============================================
# Figma Integration
# ============================================
export FIGMA_API_TOKEN="paste_figma_token_here"
```

### 2.4 Load & Test (3 min)

#### Load Environment

**Option A: Using direnv (Recommended)**
```bash
# Install direnv
brew install direnv  # macOS

# Add to shell config (~/.zshrc or ~/.bashrc)
eval "$(direnv hook zsh)"  # for zsh

# Allow direnv for this project
direnv allow
```

**Option B: Manual Source**
```bash
source .envrc
```

#### Test Each Integration

```bash
# Test JIRA
./scripts/integrations/jira-fetch.sh PROJ-123

# Test Figma
./scripts/integrations/figma-fetch.sh ABC123xyz456

# Test Slack
./scripts/integrations/slack-notify.sh '#dev-team' 'Test message'

# Test Confluence
echo "# Test" > /tmp/test.md
./scripts/integrations/confluence-publish.sh 'DEV' 'Test Page' '/tmp/test.md'
```

---

## 3. Detailed Setup

### 3.1 JIRA Integration

#### What it does:
- Auto-fetch ticket details when you mention ticket ID
- Update ticket status during workflow
- Add comments with progress updates
- Link commits to tickets

#### Configuration

```bash
export JIRA_URL="https://yourcompany.atlassian.net"
export JIRA_EMAIL="your.email@company.com"
export JIRA_API_TOKEN="your_jira_api_token_here"
export JIRA_PROJECT_KEY="PROJ"
```

#### Enable in Project Config

```yaml
# aura-frog-config.yaml
integrations:
  jira:
    enabled: true
    project_key: "PROJ"
```

#### Test Connection

```bash
curl -u "$JIRA_EMAIL:$JIRA_API_TOKEN" \
  -H "Accept: application/json" \
  "$JIRA_URL/rest/api/3/myself"
```

---

### 3.2 Confluence Integration

#### What it does:
- Auto-publish documentation to Confluence
- Create pages in specified space
- Update existing pages
- Add labels and metadata

#### Configuration

```bash
export CONFLUENCE_URL="https://yourcompany.atlassian.net/wiki"
export CONFLUENCE_EMAIL="your.email@company.com"
export CONFLUENCE_API_TOKEN="same_as_jira_token"
export CONFLUENCE_SPACE_KEY="DEV"
```

#### Enable in Project Config

```yaml
# aura-frog-config.yaml
integrations:
  confluence:
    enabled: true
    space_key: "DEV"
```

#### Usage

```bash
# Publish markdown to Confluence
./scripts/integrations/confluence-publish.sh 'DEV' 'Page Title' 'docs/file.md'

# With parent page
./scripts/integrations/confluence-publish.sh 'DEV' 'Sub Page' 'docs/sub.md' '123456'
```

---

### 3.3 Slack Integration

#### What it does:
- Send workflow completion notifications
- Alert team on phase completions
- Share deployment updates
- Notify on errors or blockers

#### Configuration

```bash
export SLACK_BOT_TOKEN="xoxb-your-slack-bot-token"
export SLACK_CHANNEL_ID="#dev-team"
export SLACK_MENTION_DEV="@developer-team"
export SLACK_MENTION_QA="@qa-team"
```

#### Enable in Project Config

```yaml
# aura-frog-config.yaml
integrations:
  slack:
    enabled: true
    channels:
      dev: "#dev-team"
      qa: "#qa-team"
```

#### Usage

```bash
# Send notification
./scripts/integrations/slack-notify.sh '#dev-team' 'Deploy completed!'

# With mentions
./scripts/integrations/slack-notify.sh '#dev-team' 'PR ready' '' '@reviewer-team'
```

---

### 3.4 Figma Integration

#### What it does:
- Fetch design specifications
- Extract components and layout
- Get design tokens (colors, spacing, typography)
- Works with screenshots (no API needed for basic use)

#### Configuration

```bash
export FIGMA_API_TOKEN="figd_your_figma_token_here"
```

#### Usage

```bash
# Fetch Figma file
./scripts/integrations/figma-fetch.sh ABC123xyz456

# From URL
./scripts/integrations/figma-fetch.sh "https://www.figma.com/file/ABC123/Design"
```

---

## 4. Script Usage

### 4.1 Available Scripts

| Service | Script | Purpose |
|---------|--------|---------|
| **JIRA** | `jira-fetch.sh` | Fetch tickets, requirements |
| **Figma** | `figma-fetch.sh` | Fetch designs, extract components |
| **Slack** | `slack-notify.sh` | Send notifications, updates |
| **Confluence** | `confluence-publish.sh` | Publish documentation |

### 4.2 Script Reference

#### jira-fetch.sh

```bash
./scripts/integrations/jira-fetch.sh <ticket-key>

# Examples
./scripts/integrations/jira-fetch.sh PROJ-123
```

#### figma-fetch.sh

```bash
./scripts/integrations/figma-fetch.sh <file-id-or-url>

# Examples
./scripts/integrations/figma-fetch.sh ABC123xyz456
./scripts/integrations/figma-fetch.sh "https://www.figma.com/file/ABC123/Design"
```

#### slack-notify.sh

```bash
./scripts/integrations/slack-notify.sh <channel> <message> [thread_ts] [mentions]

# Examples
./scripts/integrations/slack-notify.sh '#dev-team' 'Deploy completed!'
./scripts/integrations/slack-notify.sh '#dev-team' 'PR ready' '' '@reviewer-team'
```

#### confluence-publish.sh

```bash
./scripts/integrations/confluence-publish.sh <space-key> <title> <content-file> [parent-page-id]

# Examples
./scripts/integrations/confluence-publish.sh 'DEV' 'API Docs' 'docs/api.md'
./scripts/integrations/confluence-publish.sh 'DEV' 'Sub Page' 'docs/sub.md' '123456'
```

---

## 5. Troubleshooting

### General Issues

**Environment Variables Not Loading**
```bash
# Check if direnv is installed
which direnv

# Manually load variables
source .envrc
echo $JIRA_URL  # Should print your JIRA URL
```

### Integration-Specific Issues

**JIRA: "HTTP 401 Unauthorized"**
- Check email is correct
- Regenerate API token
- Verify URL format (no trailing slash)

**Confluence: "HTTP 403 Forbidden"**
- Verify you have "Can add" permission in space
- Check space key is correct
- Verify API token is valid

**Slack: "channel_not_found"**
- Go to Slack channel
- Type: `/invite @Aura Frog Bot`
- Try again

**Figma: "HTTP 403 Forbidden"**
- Regenerate token at figma.com/settings
- Ensure token has file access
- Check file permissions

**All Scripts: "jq: command not found"**
```bash
brew install jq  # macOS
sudo apt install jq  # Ubuntu
```

---

## Security Best Practices

### DO
- Keep tokens in `.envrc` (gitignored)
- Use separate tokens per project
- Rotate tokens every 90 days
- Use read-only tokens when possible

### DON'T
- Commit `.envrc` to git
- Share tokens in chat/email
- Use production tokens for development
- Hardcode tokens in scripts

### Git Ignore Configuration

Ensure these are in your `.gitignore`:

```
.envrc
.env
*.local.json
.cursor/logs/
```

---

## Related Documentation

- **AGENT_IDENTIFICATION.md** - Agent display system
- **aura-frog-config.example.yaml** - Full configuration reference

---

**Version:** 1.1.9
**Last Updated:** 2025-12-04
