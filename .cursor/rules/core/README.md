# Cursor Rules - Core Quality Standards

This directory contains 21+ core quality rules converted from Aura Frog to Cursor IDE MDC format.

## Core Rules (21 Requested)

1. **tdd-workflow.mdc** - Test-Driven Development with RED-GREEN-REFACTOR cycle
2. **kiss-principle.mdc** - Keep It Simple, avoid over-engineering
3. **dry-caution.mdc** - DRY principle with Rule of Three
4. **cross-review.mdc** - Cross-review workflow for quality assurance
5. **code-quality.mdc** - TypeScript strict mode, error handling, testing standards
6. **error-handling.mdc** - Structured error handling with typed classes
7. **logging.mdc** - Structured logging with proper levels and sanitization
8. **naming-conventions.mdc** - Consistent naming patterns
9. **smart-commenting.mdc** - Explain WHY not WHAT, avoid redundant comments
10. **api-design.mdc** - RESTful API design conventions
11. **state-management.mdc** - Predictable state management patterns
12. **performance.mdc** - Performance optimization for web and mobile
13. **accessibility.mdc** - WCAG accessibility standards
14. **dependency-management.mdc** - Safe dependency management
15. **safety.mdc** - Safety rules for external system interactions
16. **git-workflow.mdc** - Git branching, commits, and PR conventions
17. **theme-consistency.mdc** - No hardcoded colors/spacing, use theme values
18. **yagni.mdc** - You Aren't Gonna Need It principle
19. **file-extensions.mdc** - Use correct file extensions (TSX for JSX, TS for utils)
20. **architecture.mdc** - Dual-file architecture pattern
21. **hooks-access.mdc** - Direct hook access, avoid destructuring

## Additional Rules (Bonus)

- **agent-identification.mdc** - Agent identification banner (Aura Frog specific)
- **approval-gates.mdc** - Approval gates workflow
- **execution.mdc** - Execution rules
- **priority-hierarchy.mdc** - Priority hierarchy
- **token-awareness.mdc** - Token usage awareness

## MDC Format

All rules use the Cursor MDC format:

```markdown
---
description: Brief 1-sentence description for Cursor AI
globs: []
alwaysApply: true
---

# Rule Title

[Content...]

## References
- Project conventions: `project-contexts/[project]/conventions.md`
- Related rules: `[rule].mdc`
```

## Usage

These rules are automatically loaded by Cursor AI when you work in this codebase. They provide:

- **Consistent Standards**: Same quality rules across all code
- **Context-Aware Guidance**: Cursor AI uses these to guide code generation
- **Linting Integration**: Works with ESLint and other tools
- **Project Flexibility**: Reference project-specific conventions in `project-contexts/`

## Key Features

1. **Always Apply**: All rules use `alwaysApply: true`
2. **Generic Content**: Rules are framework-agnostic where possible
3. **Project References**: Point to `project-contexts/[project]/` for specifics
4. **Clear Examples**: Include good/bad code examples
5. **Checklists**: Provide actionable review checklists

## Maintenance

To update rules:
1. Edit the `.mdc` file directly
2. Cursor AI will automatically reload
3. Commit changes to git for team sharing

## Integration with Project

Project-specific configurations go in:
- `.claude/project-contexts/[project-name]/conventions.md`
- `.claude/project-contexts/[project-name]/rules.md`
- `.claude/project-contexts/[project-name]/examples.md`

This keeps core rules generic and reusable across projects.
