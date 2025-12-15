# Expert Skills

Expert skills bundle related rules and best practices into comprehensive references. Agents load these skills to become "experts" in specific domains.

## Available Expert Skills

| Skill | Description | Use For |
|-------|-------------|---------|
| `typescript-expert.mdc` | TypeScript/JS patterns, strict typing, null handling | All TS/JS projects |
| `react-expert.mdc` | React hooks, performance, state management | React, RN, Next.js |
| `vue-expert.mdc` | Composition API, Pinia, reactivity | Vue.js, Nuxt |
| `angular-expert.mdc` | Signals, RxJS, NgRx, standalone components | Angular |
| `api-expert.mdc` | REST design, validation, error handling, DB | Backend APIs |
| `testing-expert.mdc` | TDD, unit/integration/e2e, mocking | All testing |
| `security-expert.mdc` | OWASP Top 10, secure coding, auth | All projects |

## How Agents Use Expert Skills

```yaml
# Agent references expert skills
Related Skills:
- typescript-expert.mdc   # Core TS/JS patterns
- react-expert.mdc        # React-specific patterns
- testing-expert.mdc      # Testing patterns
- security-expert.mdc     # Security patterns
```

## Skill Loading

Expert skills have `alwaysApply: false` - they're loaded by agents based on context:

- **Frontend agents** → `typescript-expert` + framework expert + `testing-expert`
- **Backend agents** → `typescript-expert` + `api-expert` + `security-expert`
- **All agents** → `security-expert` for security reviews

## Creating New Expert Skills

1. Create `{domain}-expert.mdc` in this directory
2. Set `alwaysApply: false`
3. Bundle related rules with practical examples
4. Include code review checklist
5. Reference related rules at the bottom

## Skill Structure

```markdown
---
description: {Domain} expert - {key topics}
globs: [relevant file patterns]
alwaysApply: false
---

# {Domain} Expert Skill

## Overview
- What this skill covers
- Which rules it bundles

## 1. Topic One
- Code examples (good/bad)
- Common patterns

## 2. Topic Two
...

## Code Review Checklist
- [ ] Item 1
- [ ] Item 2

## Quick Reference (TOON format)

## Related Rules
- `rule1.mdc` - Description
- `rule2.mdc` - Description
```

---

**Version:** 1.1.5
**Last Updated:** 2025-12-15
