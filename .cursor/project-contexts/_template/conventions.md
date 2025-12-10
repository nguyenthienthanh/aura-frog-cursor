# Project Coding Conventions

This file defines project-specific coding conventions for consistent code generation.

## File Naming

```yaml
Components:
  pattern: PascalCase
  example: UserProfile.tsx, LoginForm.tsx

Hooks:
  pattern: useCamelCase
  example: useAuth.ts, useUserData.ts

Utilities:
  pattern: camelCase
  example: formatDate.ts, validateEmail.ts

Constants:
  pattern: camelCase (file), UPPER_SNAKE_CASE (exports)
  example: apiEndpoints.ts → export const API_BASE_URL = '...'

Tests:
  pattern: [name].test.ts or [name].spec.ts
  example: UserProfile.test.tsx, useAuth.test.ts

Types:
  pattern: camelCase (file), PascalCase (types)
  example: user.ts → export interface User { ... }
```

## Directory Structure

```
src/
├── components/
│   ├── ui/              # Reusable UI components (Button, Input, Modal)
│   └── features/        # Feature-specific components
├── hooks/               # Custom React hooks
├── utils/               # Utility functions
├── services/            # API services
├── store/               # State management
├── types/               # TypeScript type definitions
├── constants/           # Constants and config
└── assets/              # Images, fonts, etc.
```

## Import Aliases

```yaml
Aliases:
  "@/": "src/"
  "@/components": "src/components"
  "@/hooks": "src/hooks"
  "@/utils": "src/utils"
  "@/types": "src/types"
  "@/services": "src/services"
  "@/store": "src/store"
  "@/constants": "src/constants"
  "@/assets": "src/assets"
```

## Component Structure

```typescript
// Standard component file structure

// 1. Imports
import React from 'react';
import { View, Text } from 'react-native';
import { Button } from '@/components/ui';
import type { ComponentProps } from './types';

// 2. Types/Interfaces (if not in separate file)
interface Props {
  title: string;
  onPress: () => void;
}

// 3. Component
export function ComponentName({ title, onPress }: Props) {
  // Hooks first
  const [state, setState] = useState(false);

  // Event handlers
  const handlePress = useCallback(() => {
    onPress();
  }, [onPress]);

  // Render
  return (
    <View testID="component-name">
      <Text>{title}</Text>
      <Button onPress={handlePress} />
    </View>
  );
}

// 4. Default export (optional)
export default ComponentName;
```

## Hook Structure

```typescript
// Standard hook file structure

import { useState, useCallback, useEffect } from 'react';
import { api } from '@/services';
import type { User } from '@/types';

interface UseUserDataReturn {
  user: User | null;
  loading: boolean;
  error: Error | null;
  refresh: () => void;
}

export function useUserData(userId: string): UseUserDataReturn {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  const refresh = useCallback(async () => {
    try {
      setLoading(true);
      const data = await api.getUser(userId);
      setUser(data);
    } catch (err) {
      setError(err as Error);
    } finally {
      setLoading(false);
    }
  }, [userId]);

  useEffect(() => {
    refresh();
  }, [refresh]);

  return { user, loading, error, refresh };
}
```

## Styling Conventions

### NativeWind (Tailwind for React Native)

```typescript
// Use className prop with Tailwind classes
<View className="flex-1 p-4 bg-white">
  <Text className="text-lg font-bold text-gray-900">
    Title
  </Text>
</View>
```

### Theme Colors

```yaml
Primary: primary-*     # Main brand color
Secondary: secondary-* # Secondary actions
Success: green-*       # Success states
Error: red-*           # Error states
Warning: yellow-*      # Warning states
Neutral: gray-*        # Text, borders, backgrounds
```

## Naming Conventions

```yaml
Variables:
  - camelCase for all variables
  - Descriptive names (not single letters except loop indices)
  - Boolean prefix: is, has, should, can (isLoading, hasError)

Functions:
  - camelCase
  - Verb + Noun pattern (fetchUser, handleSubmit, validateEmail)
  - Event handlers: handle + Event (handleClick, handleChange)

Constants:
  - UPPER_SNAKE_CASE for true constants
  - camelCase for config objects

Types/Interfaces:
  - PascalCase
  - Suffix with Props for component props (ButtonProps)
  - No I prefix for interfaces
```

## Testing Conventions

```typescript
// Test file structure
describe('ComponentName', () => {
  // Setup
  beforeEach(() => {
    // Reset mocks, setup test data
  });

  // Group by scenario
  describe('when user is logged in', () => {
    it('should display user name', () => {
      // Arrange
      const user = createMockUser();

      // Act
      render(<Component user={user} />);

      // Assert
      expect(screen.getByText(user.name)).toBeVisible();
    });
  });

  // Edge cases
  describe('edge cases', () => {
    it('should handle empty data', () => {
      // ...
    });
  });
});
```

## References

- Quality rules: `rules.md`
- Code examples: `examples.md`
- Project config: `project-config.yaml`
