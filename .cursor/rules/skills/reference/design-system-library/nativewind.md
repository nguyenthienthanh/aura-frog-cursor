# NativeWind - Implementation Guide

**Design System:** NativeWind v4
**Based On:** Tailwind CSS for React Native
**Platforms:** React Native, Expo
**Package:** `nativewind`, `tailwindcss`

---

## Key Concept

NativeWind allows you to use Tailwind CSS utility classes in React Native. It compiles Tailwind classes to React Native StyleSheet at build time.

---

## Installation

### Expo Project

```bash
npx expo install nativewind tailwindcss
npx tailwindcss init
```

---

## Configuration

### tailwind.config.js

```javascript
module.exports = {
  content: [
    './App.{js,jsx,ts,tsx}',
    './app/**/*.{js,jsx,ts,tsx}',
    './src/**/*.{js,jsx,ts,tsx}',
    './components/**/*.{js,jsx,ts,tsx}',
  ],
  presets: [require('nativewind/preset')],
  theme: {
    extend: {
      colors: {
        primary: {
          500: '#3b82f6',
          600: '#2563eb',
        },
      },
    },
  },
  plugins: [],
}
```

### babel.config.js

```javascript
module.exports = function (api) {
  api.cache(true);
  return {
    presets: [
      ['babel-preset-expo', { jsxImportSource: 'nativewind' }],
      'nativewind/babel',
    ],
  };
};
```

---

## Component Patterns

### Basic Usage

```tsx
import { View, Text, Pressable } from 'react-native';

export function Card() {
  return (
    <View className="bg-white rounded-xl p-4 shadow-md">
      <Text className="text-lg font-semibold text-gray-900">
        Card Title
      </Text>
      <Text className="text-gray-600 mt-2">
        Card description goes here.
      </Text>
    </View>
  );
}
```

### Buttons

```tsx
import { Pressable, Text, ActivityIndicator } from 'react-native';

export function PrimaryButton({ children, onPress, loading, disabled }) {
  return (
    <Pressable
      onPress={onPress}
      disabled={disabled || loading}
      className="bg-blue-600 rounded-lg py-3 px-6 flex-row items-center justify-center active:bg-blue-700 disabled:opacity-50"
    >
      {loading && <ActivityIndicator color="white" className="mr-2" />}
      <Text className="text-white font-semibold text-base">
        {children}
      </Text>
    </Pressable>
  );
}
```

### Form Inputs

```tsx
import { View, Text, TextInput } from 'react-native';

export function Input({ label, error, ...props }) {
  return (
    <View className="space-y-1">
      {label && (
        <Text className="text-sm font-medium text-gray-700">{label}</Text>
      )}
      <TextInput
        className={`border rounded-lg px-4 py-3 text-base text-gray-900 ${error ? 'border-red-500' : 'border-gray-300'}`}
        placeholderTextColor="#9CA3AF"
        {...props}
      />
      {error && <Text className="text-sm text-red-500">{error}</Text>}
    </View>
  );
}
```

### Lists

```tsx
import { View, Text, Pressable } from 'react-native';

export function ListItem({ title, subtitle, onPress }) {
  return (
    <Pressable
      onPress={onPress}
      className="flex-row items-center py-4 px-4 bg-white active:bg-gray-50"
    >
      <View className="flex-1">
        <Text className="text-base font-medium text-gray-900">{title}</Text>
        {subtitle && (
          <Text className="text-sm text-gray-500 mt-0.5">{subtitle}</Text>
        )}
      </View>
    </Pressable>
  );
}
```

---

## Dark Mode

```tsx
// In tailwind.config.js
module.exports = {
  darkMode: 'class',
}

// Usage
<View className="bg-white dark:bg-gray-900">
  <Text className="text-gray-900 dark:text-white">
    Adapts to dark mode
  </Text>
</View>

// Toggle dark mode
import { useColorScheme } from 'nativewind';

function App() {
  const { colorScheme, toggleColorScheme } = useColorScheme();
  // ...
}
```

---

## Safe Area

```tsx
<View className="pt-safe">Header with top safe area</View>
<View className="pb-safe">Footer with bottom safe area</View>
```

---

## Best Practices

### DO

```tsx
// Use className for all styling
<View className="flex-1 bg-white p-4">

// Use consistent spacing from theme
<View className="gap-4 p-4">

// Group related classes logically
<Pressable
  className="flex-row items-center gap-2 bg-blue-600 rounded-lg py-3 px-4 active:bg-blue-700"
>
```

### DON'T

```tsx
// Don't mix StyleSheet and className
<View className="p-4" style={{ marginTop: 10 }}>  // BAD

// Don't use arbitrary values when theme values exist
<View className="p-[17px]">  // BAD

// Don't forget dark mode variants
<View className="bg-white">  // Add dark:bg-gray-900
```

---

## Common Utilities

**Layout:** `flex-1`, `flex-row`, `items-center`, `justify-between`, `gap-{n}`
**Spacing:** `p-{n}`, `m-{n}`, `px-{n}`, `py-{n}`
**Typography:** `text-{size}`, `font-{weight}`, `text-{color}`
**Borders:** `rounded-{size}`, `border`, `border-{color}`
**Interactive:** `active:bg-{color}`, `disabled:opacity-50`

---

**Last Updated:** 2025-12-04
**NativeWind Version:** 4.x
