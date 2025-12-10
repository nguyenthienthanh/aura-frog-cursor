# Project Code Examples

Real code examples from this project that AI should follow when generating new code.

## Component Examples

### Basic Component

```typescript
// src/components/ui/Button.tsx
import React from 'react';
import { Pressable, Text } from 'react-native';

interface ButtonProps {
  title: string;
  onPress: () => void;
  variant?: 'primary' | 'secondary' | 'outline';
  disabled?: boolean;
}

export function Button({
  title,
  onPress,
  variant = 'primary',
  disabled = false,
}: ButtonProps) {
  const baseStyles = 'px-4 py-2 rounded-lg';
  const variantStyles = {
    primary: 'bg-primary-500 text-white',
    secondary: 'bg-secondary-500 text-white',
    outline: 'border border-primary-500 text-primary-500',
  };

  return (
    <Pressable
      testID="button"
      onPress={onPress}
      disabled={disabled}
      className={`${baseStyles} ${variantStyles[variant]} ${disabled ? 'opacity-50' : ''}`}
    >
      <Text className="text-center font-medium">{title}</Text>
    </Pressable>
  );
}
```

### Feature Component

```typescript
// src/components/features/UserCard.tsx
import React from 'react';
import { View, Text, Image } from 'react-native';
import { Button } from '@/components/ui';
import type { User } from '@/types';

interface UserCardProps {
  user: User;
  onViewProfile: (userId: string) => void;
}

export function UserCard({ user, onViewProfile }: UserCardProps) {
  const handlePress = useCallback(() => {
    onViewProfile(user.id);
  }, [user.id, onViewProfile]);

  return (
    <View testID={`user-card-${user.id}`} className="bg-white rounded-xl p-4 shadow-sm">
      <Image
        source={{ uri: user.avatarUrl }}
        className="w-16 h-16 rounded-full"
        testID="user-avatar"
      />
      <Text className="text-lg font-bold text-gray-900 mt-2">
        {user.name}
      </Text>
      <Text className="text-sm text-gray-500">
        {user.email}
      </Text>
      <Button
        title="View Profile"
        onPress={handlePress}
        variant="outline"
      />
    </View>
  );
}
```

## Hook Examples

### Data Fetching Hook

```typescript
// src/hooks/useUsers.ts
import { useState, useCallback, useEffect } from 'react';
import { userApi } from '@/services';
import type { User } from '@/types';

interface UseUsersReturn {
  users: User[];
  loading: boolean;
  error: Error | null;
  refresh: () => Promise<void>;
}

export function useUsers(): UseUsersReturn {
  const [users, setUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  const refresh = useCallback(async () => {
    try {
      setLoading(true);
      setError(null);
      const data = await userApi.getAll();
      setUsers(data);
    } catch (err) {
      setError(err instanceof Error ? err : new Error('Failed to fetch users'));
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    refresh();
  }, [refresh]);

  return { users, loading, error, refresh };
}
```

### Form Hook

```typescript
// src/hooks/useForm.ts
import { useState, useCallback } from 'react';

interface UseFormOptions<T> {
  initialValues: T;
  validate: (values: T) => Partial<Record<keyof T, string>>;
  onSubmit: (values: T) => Promise<void>;
}

export function useForm<T extends Record<string, unknown>>({
  initialValues,
  validate,
  onSubmit,
}: UseFormOptions<T>) {
  const [values, setValues] = useState<T>(initialValues);
  const [errors, setErrors] = useState<Partial<Record<keyof T, string>>>({});
  const [submitting, setSubmitting] = useState(false);

  const handleChange = useCallback((field: keyof T, value: unknown) => {
    setValues((prev) => ({ ...prev, [field]: value }));
    setErrors((prev) => ({ ...prev, [field]: undefined }));
  }, []);

  const handleSubmit = useCallback(async () => {
    const validationErrors = validate(values);
    if (Object.keys(validationErrors).length > 0) {
      setErrors(validationErrors);
      return;
    }

    try {
      setSubmitting(true);
      await onSubmit(values);
    } finally {
      setSubmitting(false);
    }
  }, [values, validate, onSubmit]);

  return { values, errors, submitting, handleChange, handleSubmit };
}
```

## API Service Example

```typescript
// src/services/userApi.ts
import { apiClient } from './apiClient';
import type { User, CreateUserDTO, UpdateUserDTO } from '@/types';

export const userApi = {
  getAll: async (): Promise<User[]> => {
    const response = await apiClient.get<{ data: User[] }>('/users');
    return response.data.data;
  },

  getById: async (id: string): Promise<User> => {
    const response = await apiClient.get<{ data: User }>(`/users/${id}`);
    return response.data.data;
  },

  create: async (data: CreateUserDTO): Promise<User> => {
    const response = await apiClient.post<{ data: User }>('/users', data);
    return response.data.data;
  },

  update: async (id: string, data: UpdateUserDTO): Promise<User> => {
    const response = await apiClient.patch<{ data: User }>(`/users/${id}`, data);
    return response.data.data;
  },

  delete: async (id: string): Promise<void> => {
    await apiClient.delete(`/users/${id}`);
  },
};
```

## Test Example

```typescript
// src/components/ui/__tests__/Button.test.tsx
import React from 'react';
import { render, fireEvent, screen } from '@testing-library/react-native';
import { Button } from '../Button';

describe('Button', () => {
  describe('rendering', () => {
    it('should render with title', () => {
      render(<Button title="Click me" onPress={jest.fn()} />);

      expect(screen.getByText('Click me')).toBeVisible();
    });

    it('should render with primary variant by default', () => {
      render(<Button title="Click me" onPress={jest.fn()} />);

      expect(screen.getByTestId('button')).toHaveStyle({
        backgroundColor: expect.any(String),
      });
    });
  });

  describe('interactions', () => {
    it('should call onPress when pressed', () => {
      const onPress = jest.fn();
      render(<Button title="Click me" onPress={onPress} />);

      fireEvent.press(screen.getByTestId('button'));

      expect(onPress).toHaveBeenCalledTimes(1);
    });

    it('should not call onPress when disabled', () => {
      const onPress = jest.fn();
      render(<Button title="Click me" onPress={onPress} disabled />);

      fireEvent.press(screen.getByTestId('button'));

      expect(onPress).not.toHaveBeenCalled();
    });
  });
});
```

## Type Definition Example

```typescript
// src/types/user.ts
export interface User {
  id: string;
  email: string;
  name: string;
  avatarUrl: string | null;
  role: UserRole;
  createdAt: string;
  updatedAt: string;
}

export type UserRole = 'admin' | 'user' | 'guest';

export interface CreateUserDTO {
  email: string;
  name: string;
  password: string;
  role?: UserRole;
}

export interface UpdateUserDTO {
  name?: string;
  avatarUrl?: string | null;
  role?: UserRole;
}
```

## References

- Conventions: `conventions.md`
- Rules: `rules.md`
- Project config: `project-config.yaml`
