# Aura Frog Agents - Cursor IDE Format

## Overview

This directory contains 24 specialized Aura Frog agents converted to Cursor IDE MDC format.

## Conversion Status

**Completed:** 3/24 agents (12.5%)
**Template Ready:** 21/24 agents (87.5%)

### ✅ Completed Agents

1. **mobile-react-native.mdc** - React Native + Expo development expert
2. **smart-agent-detector.mdc** - Intelligent agent selection system
3. **qa-automation.mdc** - QA automation and testing expert

### 🔄 Remaining Agents

See **`.cursor/AGENT_CONVERSION_GUIDE.md`** for complete list and conversion instructions.

## How to Convert Remaining Agents

1. **Read the guide:** `.cursor/AGENT_CONVERSION_GUIDE.md`
2. **Study examples:** Review completed `.mdc` files in this directory
3. **Follow template:** Use provided MDC format template
4. **Copy glob patterns:** Reference glob pattern table in guide
5. **Test:** Verify agent activates with matching files

## MDC Format Structure

```markdown
---
description: "One-sentence agent description"
globs:
  - "**/*.{ext}"
  - "**/pattern/**/*"
alwaysApply: false
---

# Agent Name

## Role & Expertise
## When to Activate
## Technical Skills
## Best Practices
## Integration with Other Agents
## References
```

## Quick Reference

### File Locations
- **Source agents:** `~/.claude/plugins/marketplaces/aurafrog/aura-frog/agents/`
- **Target location:** `.cursor/rules/agents/`
- **Conversion guide:** `.cursor/AGENT_CONVERSION_GUIDE.md`
- **Summary:** `.cursor/CONVERSION_SUMMARY.md`

### Key Differences

| Aspect | Claude Code | Cursor IDE |
|--------|-------------|------------|
| Extension | `.md` | `.mdc` |
| Frontmatter | Optional | Required |
| Activation | Priority + keywords | Glob patterns |
| Always Active | Multiple | Only smart-agent-detector |

### Glob Patterns Quick Ref

- **React Native:** `**/*.tsx`, `**/*.phone.tsx`, `**/*.tablet.tsx`
- **Vue.js:** `**/*.vue`, `**/composables/**/*`
- **Tests:** `**/*.test.ts`, `**/__tests__/**/*`
- **DevOps:** `**/Dockerfile`, `**/.github/workflows/**/*`

## Time Estimate

- **Per Agent:** 10-15 minutes
- **Total (21 remaining):** 3.5-5 hours

## Priority Order

1. pm-operations-orchestrator (Workflow coordinator)
2. backend-nodejs (Primary backend)
3. security-expert (Security scanning)
4. devops-cicd (Deployment)
5. Others as needed

## Documentation

- **Complete guide:** `.cursor/AGENT_CONVERSION_GUIDE.md`
- **Full summary:** `.cursor/CONVERSION_SUMMARY.md`
- **Examples:** This directory (completed `.mdc` files)

## Getting Started

```bash
# 1. Read the comprehensive guide
cat .cursor/AGENT_CONVERSION_GUIDE.md

# 2. Study completed examples
cat .cursor/rules/agents/mobile-react-native.mdc
cat .cursor/rules/agents/smart-agent-detector.mdc
cat .cursor/rules/agents/qa-automation.mdc

# 3. Start converting
# Follow guide for each remaining agent
```

## Support

For detailed instructions, glob patterns, templates, and examples:
**Read:** `.cursor/AGENT_CONVERSION_GUIDE.md`

---

**Status:** Templates ready, conversion in progress
**Target:** 24/24 agents in Cursor MDC format
