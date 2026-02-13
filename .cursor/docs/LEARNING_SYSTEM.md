# Aura Frog Learning System

**Version:** 1.11.0
**Status:** Experimental

The Learning System enables Cursor to improve over time by collecting feedback, analyzing patterns, and generating actionable insights stored in Supabase.

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        Cursor + Aura Frog                        │
├─────────────────────────────────────────────────────────────────┤
│  Data Collection                │  Skills (Analysis)             │
│  ├── User corrections           │  ├── learning-analyzer.mdc     │
│  ├── Workflow metrics           │  └── self-improve.mdc          │
│  └── Agent performance          │                                 │
├─────────────────────────────────┴─────────────────────────────────┤
│  Commands: /learn:setup, /learn:status, /learn:analyze, /learn:apply │
└─────────────────────┬───────────────────────────────────────────┘
                      │ REST API
                      ▼
┌─────────────────────────────────────────────────────────────────┐
│                         Supabase                                 │
├─────────────────────────────────────────────────────────────────┤
│  Tables:                        │  Views:                        │
│  ├── af_feedback               │  ├── v_agent_success_rates     │
│  ├── af_workflow_metrics       │  ├── v_common_patterns         │
│  ├── af_agent_performance      │  └── v_improvement_suggestions │
│  ├── af_learned_patterns       │                                 │
│  └── af_knowledge_base         │                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Setup

### 1. Environment Variables

Add to your `.envrc` (copy from `.envrc.template`):

```bash
# Supabase Learning System
export SUPABASE_URL="https://your-project.supabase.co"
export SUPABASE_PUBLISHABLE_KEY="your-publishable-key"  # Public key (safe for client)
export SUPABASE_SECRET_KEY="your-secret-key"  # Secret key (keep private!)
export AF_LEARNING_ENABLED="true"
```

**Where to find keys:** Supabase Dashboard → Project Settings → Data API

### 2. Database Schema

**Option A: SQL Editor (Recommended)**

Copy and paste `scripts/supabase/schema.sql` into Supabase SQL Editor.

**Option B: Via API**

Run `/learn:setup` after setting environment variables.

### 3. Enable Learning

In your project's `.envrc`:

```bash
export AF_LEARNING_ENABLED="true"
```

---

## Data Collection

The learning system collects data about your usage to improve recommendations.

### What's Collected

| Data | How | When |
|------|-----|------|
| User corrections | When you fix AI output | After edits |
| Workflow metrics | Workflow completion data | On workflow end |
| Agent selections | Which agents are used | On agent activation |
| Task types | What you're working on | Per session |

### What's NOT Stored

- Source code content
- API keys or secrets
- Personal information
- Full conversation logs

---

## Commands

| Command | Description |
|---------|-------------|
| `/learn:setup` | Set up database schema |
| `/learn:status` | Show learning system status and stats |
| `/learn:analyze` | Run pattern analysis |
| `/learn:apply` | Apply learned improvements |

---

## Analysis & Insights

### On-Demand Analysis

```bash
/learn:analyze              # Analyze recent patterns
/learn:analyze --period 30d # Last 30 days
/learn:analyze --focus agents # Focus on agent performance
```

### Generated Insights

The system identifies:

1. **Success Patterns**
   - Which agents perform best for which tasks
   - Optimal workflow configurations
   - Effective prompt patterns

2. **Failure Patterns**
   - Common auto-stop triggers
   - Frequent correction types
   - Problematic phase transitions

3. **Optimization Opportunities**
   - Token usage hotspots
   - Slow phases
   - Underused capabilities

### Applying Learnings

```bash
/learn:apply                # Review and apply suggested improvements
/learn:apply --auto         # Auto-apply high-confidence suggestions
```

---

## Privacy & Security

### Data Retention

- Feedback: 90 days (configurable)
- Metrics: 1 year
- Patterns: Indefinite (aggregated data)

### Data Location

All data is stored in your own Supabase project. Aura Frog does not have access to your data - you control it entirely.

---

## Troubleshooting

### Learning Not Working

1. Check environment variables: `echo $AF_LEARNING_ENABLED`
2. Verify Supabase connection: `/learn:status`
3. Ensure schema is set up: `/learn:setup --check`

### Missing Data

- Ensure `.envrc` is sourced: `source .envrc`
- Verify Supabase RLS policies allow inserts
- Check network connectivity

### "Table not found"

Run `/learn:setup` to create the schema.

---

## Future Enhancements

- [ ] Real-time pattern alerts
- [ ] Cross-project learning (opt-in)
- [ ] ML-based prediction models
- [ ] Integration with project analytics

---

**Version:** 1.11.0 | **Last Updated:** 2026-02-13
