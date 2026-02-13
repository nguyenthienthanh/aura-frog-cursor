# Learning Commands

Commands for the Aura Frog Learning System.

---

## Overview

The learning system enables Cursor to improve over time by:
- **Automatic:** Detecting corrections in user messages, collecting metrics
- **Manual:** Analyzing patterns and applying improvements via commands

**Full Guide:** `.cursor/docs/LEARNING_SYSTEM.md`

---

## Auto-Learn (NEW in v1.7.0)

Cursor automatically detects when you correct it:
- "no, that's wrong" → Records correction
- "stop adding comments" → Records code_style:minimal_comments
- "good job" → Records approval

**No action needed** - happens automatically. See `.cursor/rules/skills/auto-invoke/auto-learn.mdc`

---

## Commands

| Command | Purpose | When to Use |
|---------|---------|-------------|
| `/learn:setup` | Create database schema | First time setup |
| `/learn:status` | Show status and stats | Check if working |
| `/learn:memory` | Load learned patterns | Session start or refresh |
| `/learn:feedback` | Submit manual feedback | Report success/issues |
| `/learn:analyze` | Generate insights | Weekly or on-demand |
| `/learn:apply` | Apply improvements | After analysis |

---

## Quick Start

```bash
# 1. First time setup
/learn:setup

# 2. Verify it's working
/learn:status

# 3. Load learned patterns (auto at session start)
/learn:memory

# 4. Submit feedback as you work
/learn:feedback

# 5. After using Cursor for a while...
/learn:analyze

# 6. Apply improvements
/learn:apply
```

---

## Auto vs Manual

| What | How | When |
|------|-----|------|
| Correction detection | **Automatic** (auto-learn skill) | Every message |
| Memory loading | **Automatic** (session start) | Every session |
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

## Local Cache Files

| File | Purpose |
|------|---------|
| `.cursor/cache/memory-context.md` | Loaded memory from Supabase |
| `.cursor/cache/auto-learn-cache.json` | Deduplication cache for auto-learn |
| `.cursor/cache/learned-patterns.md` | Local patterns file |

---

**Version:** 1.11.0
