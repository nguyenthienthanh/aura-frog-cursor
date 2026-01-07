# Learning Commands

Commands for the Aura Frog Learning System.

---

## Overview

The learning system enables Cursor to improve over time by:
- **Automatic:** Collecting feedback, metrics, agent usage
- **Manual:** Analyzing patterns and applying improvements via commands

**Full Guide:** `.cursor/docs/LEARNING_SYSTEM.md`

---

## Commands

| Command | Purpose | When to Use |
|---------|---------|-------------|
| `/learn:setup` | Create database schema | First time setup |
| `/learn:status` | Show status and stats | Check if working |
| `/learn:analyze` | Generate insights | Weekly or on-demand |
| `/learn:apply` | Apply improvements | After analysis |

---

## Quick Start

```bash
# 1. First time setup
/learn:setup

# 2. Verify it's working
/learn:status

# 3. After using Cursor for a while...
/learn:analyze

# 4. Apply improvements
/learn:apply
```

---

## Auto vs Manual

| What | How | When |
|------|-----|------|
| Data collection | **Automatic** | Every session |
| Analysis | **Manual** (`/learn:analyze`) | Weekly recommended |
| Apply changes | **Manual** (`/learn:apply`) | After analysis |

---

## Configuration

Required in `.envrc`:

```bash
export SUPABASE_URL="https://your-project.supabase.co"
export SUPABASE_SECRET_KEY="your-secret-key"
export AF_LEARNING_ENABLED="true"
```

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| "Not configured" | Set env vars, run `source .envrc` |
| "Table not found" | Run `/learn:setup` |
| Empty results | Use the system more to collect data |

---

**Version:** 1.5.0
