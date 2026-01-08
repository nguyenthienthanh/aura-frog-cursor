# /learn:memory

Load or refresh memory from Supabase learning database.

---

## CRITICAL: Cursor MUST Execute

When user runs `/learn:memory`, Cursor **MUST actually run the memory load script**.

**DO NOT** just show documentation. **DO** run the script and show REAL results.

---

## Prerequisites

1. Supabase configured in `.envrc`:
   ```bash
   export SUPABASE_URL="https://your-project.supabase.co"
   export SUPABASE_SECRET_KEY="your-secret-key"
   export AF_LEARNING_ENABLED="true"
   ```
2. Schema created (run `/learn:setup` first)

---

## MANDATORY Execution

```bash
# ALWAYS source env first
source .envrc 2>/dev/null || source .cursor/.envrc 2>/dev/null || true

# Run memory load script
./scripts/learn/memory-load.sh
```

---

## Force Refresh

To bypass cache and force reload:

```bash
./scripts/learn/memory-load.sh --force
```

---

## Check Status

To see cache status without loading:

```bash
./scripts/learn/memory-load.sh --status
```

---

## What Gets Loaded

| Category | Source | Description |
|----------|--------|-------------|
| **Patterns** | `af_learned_patterns` | High-confidence learned patterns |
| **Agent Stats** | `v_agent_success_rates` | Agent performance metrics |
| **Corrections** | `af_feedback` | Recent corrections to avoid |
| **Insights** | `af_knowledge_base` | Recent analysis insights |

---

## Cache Location

```
.cursor/cache/memory-context.md
```

This file is read at session start to apply learned patterns.

---

## Example Output

```
🔄 Loading memory from Supabase...
✓ Memory loaded: 15 items cached to .cursor/cache/memory-context.md

## Learned Patterns
- **code_style**: Use explicit return types in TypeScript (85% confidence)
  → Add return types to all exported functions
- **architecture**: Prefer composition over inheritance (92% confidence)
  → Use hooks and HOCs instead of class inheritance

## Agent Performance
- backend-nodejs: 94% success (47 tasks)
- web-reactjs: 89% success (32 tasks)

## Recent Corrections (Avoid These)
- Don't use `any` type without explicit comment
- Always await async operations in try/catch

## Recent Insights
- Performance improved 40% by memoizing expensive calculations
```

---

**Version:** 1.6.0
**Last Updated:** 2026-01-08
