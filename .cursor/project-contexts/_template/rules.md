# Project Quality Rules

This file defines project-specific quality rules that override Aura Frog defaults.

## Linting Rules

### ESLint/TSLint Compliance

**Rule:** All generated code MUST pass the project's linter without errors.

```yaml
Enforcement:
  - Run linter before committing
  - Fix all errors (warnings can be addressed later)
  - Use project's lint config, not defaults
```

### Critical Lint Rules

These rules are NON-NEGOTIABLE for this project:

```yaml
Must Pass:
  - no-console          # No console.log (use logger instead)
  - no-any              # No TypeScript any type
  - no-unused-vars      # No unused variables/imports
  - react-hooks/*       # All React hooks rules
  - @typescript-eslint/strict-*  # TypeScript strict rules
```

### Allowed Exceptions

```yaml
Can Ignore (with comment):
  - // eslint-disable-next-line no-console  # For debugging only
  - // @ts-ignore  # ONLY when interfacing with untyped libs
```

## TypeScript Rules

### Strict Mode Requirements

```yaml
Required:
  - strict: true in tsconfig.json
  - No 'any' type (use 'unknown' + type guards)
  - No '!' non-null assertions (use optional chaining)
  - Explicit return types on exported functions
```

### Type Safety

```typescript
// GOOD: Proper typing
function getUser(id: string): User | null {
  return users.find(u => u.id === id) ?? null;
}

// BAD: Using any
function getUser(id: any): any {
  return users.find(u => u.id === id);
}
```

## Code Coverage

```yaml
Minimum Coverage:
  overall: 80%          # Project default (can override)
  critical_paths: 90%   # Auth, payments, security
  ui_components: 70%    # React components
  utilities: 95%        # Pure functions
```

## Import Rules

### Import Order (enforced by ESLint)

```typescript
// 1. React/Framework imports
import React from 'react';

// 2. Third-party libraries
import { useQuery } from '@tanstack/react-query';

// 3. Internal aliases (@/, ~/)
import { Button } from '@/components';

// 4. Relative imports
import { helper } from './utils';

// 5. Types (last)
import type { User } from '@/types';
```

## Git Workflow Rules

```yaml
Branch Naming:
  pattern: "<type>/<ticket>-<description>"
  types: [feature, bugfix, hotfix, refactor, chore]
  example: "feature/PROJ-123-add-login"

Commit Messages:
  pattern: "<type>(<scope>): <description>"
  types: [feat, fix, refactor, test, docs, style, chore]
  example: "feat(auth): add JWT refresh token"

PR Requirements:
  - All tests pass
  - Linter passes (0 errors)
  - Coverage threshold met
  - At least 1 approval
```

## Error Handling

```yaml
Requirements:
  - All async operations must have error handling
  - Use typed error classes
  - Log errors with context
  - Show user-friendly messages
```

## Performance Rules

```yaml
React/React Native:
  - Use useMemo for expensive calculations
  - Use useCallback for event handlers passed to children
  - Use React.memo for pure components
  - Avoid inline object/array creation in JSX

API Calls:
  - Implement pagination for lists
  - Cache frequently accessed data
  - Use optimistic updates where appropriate
```

## Security Rules

```yaml
NEVER Commit:
  - API keys or secrets
  - Passwords or tokens
  - .env files with real values
  - Private keys

Always:
  - Sanitize user input
  - Use parameterized queries
  - Validate on both client and server
  - Use HTTPS for all API calls
```

## References

- Project config: `project-config.yaml`
- Coding conventions: `conventions.md`
- Code examples: `examples.md`
