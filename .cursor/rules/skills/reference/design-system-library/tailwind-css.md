# Tailwind CSS - Implementation Guide

**Design System:** Tailwind CSS v3.4+
**Type:** Utility-First CSS Framework
**Platforms:** All frameworks

---

## Installation

```bash
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p
```

---

## Configuration

```javascript
// tailwind.config.js
module.exports = {
  content: ['./src/**/*.{js,ts,jsx,tsx,mdx}'],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        primary: {
          500: '#3b82f6',
          600: '#2563eb',
          700: '#1d4ed8',
        },
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
  ],
}
```

---

## Component Patterns

### Buttons

```tsx
// Primary
<button className="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700">
  Primary
</button>

// Secondary
<button className="border border-gray-300 text-gray-700 px-4 py-2 rounded-lg hover:bg-gray-50">
  Secondary
</button>

// Loading
<button className="bg-blue-600 text-white px-4 py-2 rounded-lg flex items-center gap-2" disabled>
  <svg className="animate-spin h-4 w-4" />
  Loading...
</button>
```

### Forms

```tsx
// Input
<div className="space-y-1">
  <label className="block text-sm font-medium text-gray-700">Email</label>
  <input
    type="email"
    className="block w-full rounded-lg border border-gray-300 px-3 py-2
               focus:border-blue-500 focus:ring-1 focus:ring-blue-500"
  />
</div>

// Checkbox
<label className="flex items-center gap-2">
  <input type="checkbox" className="h-4 w-4 rounded border-gray-300 text-blue-600" />
  <span className="text-sm text-gray-700">Remember me</span>
</label>
```

### Cards

```tsx
<div className="bg-white rounded-xl border border-gray-200 p-6 shadow-sm hover:shadow-md">
  <h3 className="text-lg font-semibold text-gray-900">Card Title</h3>
  <p className="mt-2 text-gray-600">Description</p>
</div>
```

### Tables

```tsx
<div className="overflow-x-auto rounded-lg border border-gray-200">
  <table className="min-w-full divide-y divide-gray-200">
    <thead className="bg-gray-50">
      <tr>
        <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Name</th>
      </tr>
    </thead>
    <tbody className="bg-white divide-y divide-gray-200">
      <tr className="hover:bg-gray-50">
        <td className="px-6 py-4 whitespace-nowrap">John Doe</td>
      </tr>
    </tbody>
  </table>
</div>
```

---

## Responsive Design

```tsx
// Breakpoints: sm (640px), md (768px), lg (1024px), xl (1280px)

// Responsive grid
<div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">

// Responsive visibility
<div className="hidden md:block">Desktop only</div>
<div className="md:hidden">Mobile only</div>

// Responsive text
<h1 className="text-2xl md:text-4xl lg:text-5xl font-bold">
```

---

## Dark Mode

```tsx
<div className="bg-white dark:bg-gray-900">
  <h1 className="text-gray-900 dark:text-white">Title</h1>
  <p className="text-gray-600 dark:text-gray-400">Text</p>
</div>
```

---

## Best Practices

### DO
```tsx
// Group related utilities
<div className="flex items-center justify-between gap-4">

// Use gap instead of margin
<div className="flex gap-4">  // GOOD

// Extract repeated patterns
@layer components {
  .btn-primary { @apply bg-blue-600 text-white px-4 py-2 rounded-lg; }
}
```

### DON'T
```tsx
// Avoid inline styles
<div style={{ padding: '16px' }}>  // BAD

// Avoid arbitrary values
<div className="p-[17px]">  // BAD - use p-4
```

---

## Utility Reference

- **Spacing:** `p-{0-96}`, `m-{0-96}`, `gap-{0-96}`
- **Flex:** `flex`, `items-center`, `justify-between`, `gap-4`
- **Grid:** `grid`, `grid-cols-{1-12}`, `col-span-{1-12}`
- **Text:** `text-{xs-9xl}`, `font-{thin-black}`, `text-{color}-{shade}`
- **Background:** `bg-{color}-{shade}`
- **Border:** `border`, `rounded-{none-full}`

---

**Last Updated:** 2025-12-05
