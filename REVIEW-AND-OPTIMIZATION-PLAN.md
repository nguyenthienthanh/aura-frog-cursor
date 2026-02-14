# Aura Frog Cursor - Review & Optimization Plan

**Date:** 2026-02-14
**Reviewer:** Claude Opus 4.6
**Repo Version:** 1.11.0

---

## Executive Summary

Aura Frog Cursor is an ambitious Cursor IDE configuration system with 13 MCP servers, 20 agents, 50 core rules, 46 skills, 94 commands, and a 9-phase TDD workflow. While comprehensive, the repo suffers from **critical context window bloat** that actively degrades AI performance. Community research and Cursor's own data confirm that excessive `alwaysApply` rules and MCP servers consume tokens that should be reserved for actual code understanding.

**Key Finding:** 50 core rules (all `alwaysApply: true`) + 6 auto-invoke skills (also `alwaysApply: true`) = **~280KB of rules injected into EVERY conversation**. This is far beyond community-recommended thresholds and likely causes Cursor to truncate or ignore rules, producing the opposite of the intended effect.

---

## Part 1: Critical Issues (Must Fix)

### 1.1 `alwaysApply: true` Overload — THE #1 Problem

**Current State:**
- 50 core rules: ALL have `alwaysApply: true` (~10,961 lines / ~280KB)
- 6 auto-invoke skills: also `alwaysApply: true` (~1,500+ lines)
- Total: ~56 files force-loaded into every single conversation

**Why This Is Destructive:**
- Cursor's context window is finite. Every token spent on rules is a token NOT spent on understanding your code.
- Community consensus: "Tokens used for instructions reduce the available context for code understanding, and extremely verbose guidance leads to diminishing returns."
- Cursor's own engineers implemented "dynamic context discovery" in Jan 2026 specifically because static context loading wastes 47% of tokens.
- After a few messages, rules at the beginning of context get deprioritized by recency bias — the AI literally "forgets" earlier rules.

**Recommendation:** Reduce `alwaysApply: true` to **maximum 5-8 truly universal rules**. Move everything else to `Auto Attached` (glob-based) or `Agent Selected` (description-based).

**Proposed `alwaysApply: true` survivors (max 8):**

| Rule | Justification |
|------|---------------|
| `agent-identification.mdc` | Required every response (banner) |
| `execution.mdc` | Core execution gates |
| `safety.mdc` | Safety is non-negotiable |
| `approval-gates.mdc` | Human approval at phase gates |
| `code-quality.mdc` | Universal quality baseline |
| `kiss-principle.mdc` | Prevents over-engineering |
| `smart-commenting.mdc` | WHY not WHAT (concise) |
| `token-awareness.mdc` | Meta-awareness of token usage |

**Move to Auto Attached (glob-based):**

| Rule | Trigger Glob |
|------|-------------|
| `seo-standards.mdc` | `**/seo/**`, `**/meta/**` |
| `accessibility.mdc` | `**/*.tsx`, `**/*.jsx`, `**/*.vue` |
| `frontend-excellence.mdc` | `**/*.tsx`, `**/*.css`, `**/*.scss` |
| `state-management.mdc` | `**/store/**`, `**/redux/**`, `**/zustand/**` |
| `performance.mdc` | `**/*.ts`, `**/*.tsx` |
| `theme-consistency.mdc` | `**/*.css`, `**/*.scss`, `**/theme/**` |
| `pixel-accuracy.mdc` | `**/*.css`, `**/*.tsx` |
| `design-system-usage.mdc` | `**/components/**` |
| `logging.mdc` | `**/logger/**`, `**/logging/**` |
| `error-handling.mdc` | `**/*.ts`, `**/*.tsx` |
| `sast-security.mdc` | `**/*.ts`, `**/*.js`, `**/*.py` |
| And ~30 more... | Based on relevance patterns |

**Move to Agent Selected (description-based):**

| Rule | When Relevant |
|------|--------------|
| `git-workflow.mdc` | Git operations |
| `dependency-management.mdc` | Package management |
| `cross-review.mdc` | Code review tasks |
| `feedback-brainstorming.mdc` | Brainstorming sessions |
| `estimation.mdc` | Estimation tasks |
| `impact-analysis.mdc` | Change analysis |
| `workflow-deliverables.mdc` | Workflow active |
| `workflow-navigation.mdc` | Workflow active |
| `deliverable-persistence.mdc` | Document storage |

---

### 1.2 Redundant Rules — LLMs Already Know This

**Rules that teach the AI things it already knows well:**

| Rule | Issue |
|------|-------|
| `modern-javascript.mdc` | Claude/GPT already knows modern JS. This wastes tokens. |
| `dry-caution.mdc` | "Rule of Three" is well-known — only add if AI fails repeatedly. |
| `yagni.mdc` | YAGNI is a well-known principle the AI already follows. |
| `naming-conventions.mdc` | LLMs generate good names by default. Only specify project-specific conventions. |
| `file-extensions.mdc` | AI uses correct extensions. Only needed if it keeps getting them wrong. |
| `codebase-consistency.mdc` | Vague — "be consistent" is understood by default. |

**Recommendation:** Delete or merge these into a single concise "Project Standards" rule (<50 lines) with only project-SPECIFIC deviations from defaults.

---

### 1.3 `.cursorrules` File Is Outdated & Redundant

**Current State:** The root `.cursorrules` file says `Version: 1.1.9` and `Last Updated: 2025-12-22`, but the project is at v1.11.0. It also says "Agents (16)" when there are 20, and "Commands (70+)" when there are 94.

**Issue:** `.cursorrules` is the deprecated legacy format. Cursor loads it into EVERY conversation alongside the `.cursor/rules/` system, creating **double context loading** for overlapping content.

**Recommendation:** Delete `.cursorrules` entirely. All its content is already covered (and more up-to-date) in `.cursor/rules/core/` files.

---

### 1.4 Massive Individual Rule Files

Several rule files far exceed the community-recommended **100-line limit**:

| File | Lines | Issue |
|------|-------|-------|
| `testing-expert.mdc` | 647 | Should be split or compressed |
| `seo-expert.mdc` | 629 | Could be lazy-loaded reference |
| `test-writer.mdc` | 576 | Too verbose for auto-invoke |
| `frontend-excellence.mdc` | 564 | `alwaysApply: true` — this alone eats significant context |
| `react-expert.mdc` | 554 | Acceptable for expert (on-demand) |
| `angular-expert.mdc` | 551 | Acceptable for expert (on-demand) |
| `api-expert.mdc` | 536 | Acceptable for expert (on-demand) |
| `smart-commenting.mdc` | 473 | Way too long for an always-applied rule |
| `approval-gates.mdc` | 445 | Could be compressed significantly |
| `tech-spec-requirement.mdc` | 425 | Could be compressed |

**Recommendation:**
- Any `alwaysApply: true` rule MUST be under 100 lines. Compress or split.
- Expert skills (on-demand) can be longer but still benefit from compression.
- `smart-commenting.mdc` at 473 lines always-applied is egregious. Reduce to <50 lines with essential rules only.

---

## Part 2: Architecture Issues

### 2.1 Overlapping & Duplicated Content

| Overlap | Files | Issue |
|---------|-------|-------|
| Security rules | `sast-security.mdc` (core) + `security-expert.mdc` (agent) + `security-expert.mdc` (skill) | Three files covering security — merge or clearly delineate |
| Git workflow | `git-workflow.mdc` (core) + `git-workflow.mdc` (auto-invoke skill) | Two files with same name, both about git |
| SEO | `seo-standards.mdc` (core) + `seo-bundle.mdc` (skill) + `seo-expert.mdc` (skill) + `web-seo.mdc` (agent) + `ai-discovery.mdc` (reference) | 5 files for SEO — massive redundancy |
| Testing | `code-quality.mdc` + `test-writer.mdc` + `testing-patterns.mdc` + `testing-expert.mdc` + `qa-expert.mdc` + `qa-automation.mdc` | 6 files touching testing |
| Code quality | `code-quality.mdc` + `code-reviewer.mdc` + `code-simplifier.mdc` + `linting-standards.mdc` + `lint-after-implementation.mdc` | 5 overlapping quality files |

**Recommendation:** Audit for duplicated guidance. Merge related files. Each piece of advice should exist in exactly ONE file.

---

### 2.2 "TOON Format" — Custom Syntax With No Tooling

The `.cursorrules` and some other files use a custom "TOON" format (Token-Optimized Notation). While the intent (save tokens) is good, it:
- Has no syntax highlighting, linting, or validation tooling
- Adds cognitive overhead for contributors
- Is not recognized by any standard parser
- Only saves marginal tokens compared to compact markdown

**Recommendation:** Evaluate actual token savings of TOON vs compact markdown. If <10% savings, remove TOON and use standard markdown for better maintainability.

---

### 2.3 Learning System — Complexity vs Value

The learning system (scripts in `scripts/learn/`, auto-learn skill, learning-analyzer skill, memory MCP server) adds significant complexity:
- `auto-learn.mdc`: 4,190 lines
- `learning-analyzer.mdc`: 3,792 lines
- `self-improve.mdc`: 4,572 lines
- Plus shell scripts, Supabase integration

**Question:** Is this actually being used and providing value? Self-improving AI rules sound appealing but in practice:
- Cursor doesn't persist state between sessions by default
- The memory MCP server has limited reliability
- Auto-generated rules can contradict hand-crafted ones

**Recommendation:** Evaluate usage metrics. If low usage, simplify to just the memory MCP server + a single compact learning rule. Remove Supabase dependency unless actively used.

---

## Part 3: Items to Remove or Simplify

### 3.1 Candidates for Removal

| Item | Reason |
|------|--------|
| `.cursorrules` (root) | Deprecated format, outdated content, redundant with `.cursor/rules/` |
| `modern-javascript.mdc` | LLMs already know modern JS |
| `yagni.mdc` | Well-known principle, already in AI training data |
| `dry-caution.mdc` | Same as above |
| `codebase-consistency.mdc` | Too vague to be actionable |
| `file-extensions.mdc` | AI uses correct extensions by default |
| `toon-format.mdc` | Custom format with no tooling — questionable ROI |
| `model-router.mdc` | Tries to route between Haiku/Sonnet/Opus — Cursor handles this, not rules |
| `mcp-startup-check.mdc` | Startup validation should be in setup script, not a rule consuming tokens every conversation |
| `memory-auto-load.mdc` | If learning system is simplified, this goes too |
| Duplicate security/SEO/testing files | Keep one authoritative source per topic |
| `voice-operations.mdc` agent | Very niche (ElevenLabs voice streaming) — does anyone use this? |
| `game-developer.mdc` agent | Very niche (Godot 4.x) — add only if project uses Godot |

### 3.2 Candidates for Merging

| Merge Into | Source Files |
|------------|-------------|
| `security.mdc` (single) | `sast-security.mdc` + `security-expert.mdc` (core) |
| `quality-standards.mdc` | `code-quality.mdc` + `linting-standards.mdc` + `lint-after-implementation.mdc` + `codebase-consistency.mdc` |
| `principles.mdc` (<30 lines) | `kiss-principle.mdc` + `yagni.mdc` + `dry-caution.mdc` |
| `workflow-rules.mdc` | `workflow-navigation.mdc` + `workflow-deliverables.mdc` + `workflow-system.mdc` |
| `seo-complete.mdc` | `seo-standards.mdc` + `seo-bundle.mdc` |

### 3.3 Commands Audit

94 commands across 23 categories is a lot. Key questions:
- How many are actually used regularly?
- Commands are loaded on-demand (good), but 23 categories makes discovery hard.

**Recommendation:** Track usage. Consolidate to ~10-12 categories. Remove commands that overlap with standard Cursor functionality.

---

## Part 4: MCP Server Optimization

### 4.1 Current: 9 Enabled Servers

**Problem:** Each MCP server exposes multiple tools. Cursor has a hard limit of **40 tools total**. With 9 servers averaging 10-30 tools each, many tools are silently dropped.

**Token cost:** A standard 3-server setup already consumes >20% of context window before any work begins.

### 4.2 Recommended: Start with 3-4 Core Servers

**Tier 1 — Always Enabled (Essential):**

| Server | Justification |
|--------|---------------|
| `context7` | Documentation lookup — high value, low tool count |
| `playwright` | E2E testing — core workflow need |
| `github` | Git operations — essential for PR/issue workflow |

**Tier 2 — Enable Per-Project:**

| Server | When |
|--------|------|
| `vitest` | Projects using vitest |
| `figma` | Design-heavy projects |
| `atlassian` | Teams using JIRA |
| `slack` | Teams needing notifications |

**Tier 3 — Remove from Default Config:**

| Server | Reason |
|--------|--------|
| `filesystem` | Cursor already has full filesystem access built-in. This MCP server is redundant and wastes tool slots. |
| `memory` | Limited reliability, adds complexity. Use `.cursor/documents/` for persistence instead. |

---

## Part 5: Structural Improvements

### 5.1 Version Inconsistencies

| Location | Version | Correct? |
|----------|---------|----------|
| `VERSION` | 1.11.0 | Source of truth |
| `README.md` | 1.11.0 | OK |
| `CHANGELOG.md` | 1.11.0 | OK |
| `.cursorrules` | 1.1.9 | WRONG — outdated |
| `.cursor/rules/core/README.md` | Needs check | Likely outdated |
| `.cursorrules` Quick Reference | "Agents (16), Commands (70+)" | WRONG — now 20/94 |

### 5.2 No Tests for the Configuration Itself

This repo has no validation that:
- All `.mdc` files have valid frontmatter
- `alwaysApply` / `globs` are correctly configured
- Version numbers are in sync
- MCP server commands are valid
- No broken cross-references between files

**Recommendation:** Add a CI validation script that checks:
- MDC frontmatter validity
- Version consistency across all files
- No duplicate rule names
- Total `alwaysApply` count doesn't exceed threshold

### 5.3 `.claude/` Directory

The `.claude/` directory has its own `CLAUDE.md`, `settings.json`, and project contexts. This is good for Claude Code compatibility, but:
- `CLAUDE.md` mandates version/changelog updates for "ANY code change" — this is heavy process for a config repo
- The learning system in `.claude/learning/` adds more complexity

**Recommendation:** Keep `.claude/` but simplify `CLAUDE.md` to essentials only.

---

## Part 6: Prioritized Action Plan

### Phase 1: Critical (High Impact, Do First)
1. **Reduce `alwaysApply: true` from 50 to 5-8 rules** — Biggest performance win
2. **Delete `.cursorrules`** — Removes deprecated double-loading
3. **Remove `filesystem` MCP server** — Redundant with Cursor built-in
4. **Compress always-applied rules to <100 lines each**

### Phase 2: Important (Medium Impact)
5. **Merge duplicate content** (security, SEO, testing, quality)
6. **Remove redundant rules** (modern-javascript, yagni, dry-caution, etc.)
7. **Reclassify auto-invoke skills** — Most should be `Agent Selected`
8. **Reduce enabled MCP servers to 3-4 core**

### Phase 3: Refinement (Lower Impact, Maintenance)
9. **Add CI validation script** for MDC files and version consistency
10. **Evaluate TOON format** — Replace with compact markdown if ROI is low
11. **Simplify learning system** — Cut from 3 skills + scripts to 1 skill
12. **Audit and consolidate commands** — 23 → ~12 categories
13. **Remove niche agents** unless actively used (voice-operations, game-developer)

### Phase 4: Documentation
14. **Fix version inconsistencies** across all files
15. **Update README** with accurate counts after optimization
16. **Update CHANGELOG** with optimization changes

---

## Estimated Impact

| Metric | Before | After (Projected) |
|--------|--------|-------------------|
| `alwaysApply` rules | 50+ | 5-8 |
| Context tokens per conversation (rules only) | ~50,000-80,000 | ~5,000-10,000 |
| MCP servers (enabled) | 9 | 3-4 core |
| MCP tool token overhead | ~20,000-40,000 | ~8,000-15,000 |
| Available context for actual code | ~40-50% | ~75-85% |
| Total rule files | 127 .mdc | ~80-90 .mdc |
| Core rules | 50 | ~25-30 (merged + removed) |

**Net effect:** ~2-3x more context window available for the AI to understand and work with actual project code, resulting in significantly better code generation quality.

---

## Sources

- [Cursor Dynamic Context Discovery (Jan 2026)](https://www.infoq.com/news/2026/01/cursor-dynamic-context-discovery/) — 46.9% token reduction
- [MCP Context Overload (EclipseSource)](https://eclipsesource.com/blogs/2026/01/22/mcp-context-overload/) — Why more tools make AI worse
- [Cursor Rules Best Practices (Elementor Engineers)](https://medium.com/elementor-engineers/cursor-rules-best-practices-for-developers-16a438a4935c)
- [The Token Tax (Peakvance)](https://medium.com/@peakvance/guide-to-cursor-rules-engineering-context-speed-and-the-token-tax-16c0560a686a)
- [MCP Tool Overload (Lunar.dev)](https://www.lunar.dev/post/why-is-there-mcp-tool-overload-and-how-to-solve-it-for-your-ai-agents)
- [Tool-Space Interference (Microsoft Research)](https://www.microsoft.com/en-us/research/blog/tool-space-interference-in-the-mcp-era/)
- [Cursor IDE Performance Issues (Community)](https://www.arsturn.com/blog/the-love-hate-relationship-with-cursor-why-some-devs-think-its-getting-worse)
