# Mantine - Implementation Guide

**Design System:** Mantine v7+
**Type:** Full-Featured Component Library
**Platforms:** React, Next.js, Remix, Gatsby
**Package:** `@mantine/core`, `@mantine/hooks`, `@mantine/form`

---

## Installation

```bash
# Core (required)
npm install @mantine/core @mantine/hooks

# Form handling
npm install @mantine/form

# Notifications
npm install @mantine/notifications
```

---

## Setup

### Next.js App Router

```tsx
// app/layout.tsx
import '@mantine/core/styles.css';
import '@mantine/notifications/styles.css';

import { ColorSchemeScript, MantineProvider } from '@mantine/core';

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <head>
        <ColorSchemeScript />
      </head>
      <body>
        <MantineProvider>{children}</MantineProvider>
      </body>
    </html>
  );
}
```

---

## Component Patterns

### Buttons

```tsx
import { Button, ActionIcon, Group } from '@mantine/core';
import { IconPlus, IconTrash } from '@tabler/icons-react';

<Button>Filled (default)</Button>
<Button variant="light">Light</Button>
<Button variant="outline">Outline</Button>
<Button variant="subtle">Subtle</Button>
<Button color="red">Red</Button>
<Button leftSection={<IconPlus size={16} />}>Add Item</Button>
<Button loading>Loading</Button>

<ActionIcon variant="filled" color="red">
  <IconTrash size={16} />
</ActionIcon>
```

### Forms

```tsx
import { TextInput, PasswordInput, Select, Checkbox, Button } from '@mantine/core';
import { useForm } from '@mantine/form';

const form = useForm({
  initialValues: { email: '', password: '' },
  validate: {
    email: (value) => (/^\S+@\S+$/.test(value) ? null : 'Invalid email'),
  },
});

<form onSubmit={form.onSubmit(handleSubmit)}>
  <TextInput label="Email" {...form.getInputProps('email')} />
  <PasswordInput label="Password" mt="md" {...form.getInputProps('password')} />
  <Button type="submit" fullWidth mt="xl">Sign in</Button>
</form>
```

### Cards

```tsx
import { Card, Image, Text, Badge, Button, Group } from '@mantine/core';

<Card shadow="sm" padding="lg" radius="md" withBorder>
  <Card.Section>
    <Image src="/image.jpg" height={160} alt="Norway" />
  </Card.Section>

  <Group justify="space-between" mt="md" mb="xs">
    <Text fw={500}>Norway Fjord Adventures</Text>
    <Badge color="pink">On Sale</Badge>
  </Group>

  <Text size="sm" c="dimmed">
    With Fjord Tours you can explore more.
  </Text>

  <Button color="blue" fullWidth mt="md" radius="md">
    Book now
  </Button>
</Card>
```

### Modals

```tsx
import { Modal, Button } from '@mantine/core';
import { useDisclosure } from '@mantine/hooks';

const [opened, { open, close }] = useDisclosure(false);

<Button onClick={open}>Open Modal</Button>

<Modal opened={opened} onClose={close} title="Authentication" centered>
  <TextInput label="Email" />
  <Button fullWidth mt="xl" onClick={close}>
    Sign in
  </Button>
</Modal>
```

### Notifications

```tsx
import { notifications } from '@mantine/notifications';
import { IconCheck } from '@tabler/icons-react';

notifications.show({
  title: 'Success',
  message: 'Your profile has been saved',
  color: 'green',
  icon: <IconCheck size={16} />,
});
```

---

## Layout & Spacing

```tsx
import { Container, Flex, Grid, Group, Stack } from '@mantine/core';

<Flex gap="md" align="center" justify="space-between">
  <div>Left</div>
  <div>Right</div>
</Flex>

<Stack gap="md">
  <div>First</div>
  <div>Second</div>
</Stack>

<Grid>
  <Grid.Col span={{ base: 12, md: 6, lg: 4 }}>Responsive</Grid.Col>
</Grid>
```

---

## Dark Mode

```tsx
import { useMantineColorScheme, ActionIcon } from '@mantine/core';
import { IconSun, IconMoon } from '@tabler/icons-react';

function ColorSchemeToggle() {
  const { colorScheme, toggleColorScheme } = useMantineColorScheme();

  return (
    <ActionIcon onClick={() => toggleColorScheme()} variant="outline">
      {colorScheme === 'dark' ? <IconSun size={18} /> : <IconMoon size={18} />}
    </ActionIcon>
  );
}
```

---

## Hooks

```tsx
import {
  useDisclosure,
  useLocalStorage,
  useMediaQuery,
  useDebouncedValue,
} from '@mantine/hooks';

const [opened, { open, close, toggle }] = useDisclosure(false);
const [value, setValue] = useLocalStorage({ key: 'my-key', defaultValue: '' });
const isMobile = useMediaQuery('(max-width: 768px)');
const [debouncedSearch] = useDebouncedValue(search, 300);
```

---

## Best Practices

### DO

```tsx
// Use theme values
<Text c="dimmed" fz="sm">

// Use consistent spacing props
<Stack gap="md">

// Use built-in hooks
const [opened, { toggle }] = useDisclosure();
```

### DON'T

```tsx
// Don't use inline styles for theme values
<Box style={{ color: '#666' }}>  // BAD

// Don't skip the required CSS import
// @mantine/core/styles.css must be imported
```

---

**Last Updated:** 2025-12-04
**Mantine Version:** 7.x
