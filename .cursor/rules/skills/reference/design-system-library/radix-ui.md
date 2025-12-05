# Radix UI - Implementation Guide

**Design System:** Radix UI Primitives
**Type:** Headless UI Component Library
**Platforms:** React
**Package:** `@radix-ui/react-*`

---

## Key Concept

Radix UI provides unstyled, accessible UI primitives. You bring your own styles (Tailwind, CSS, styled-components, etc.). This gives maximum flexibility while ensuring accessibility.

---

## Installation

Install individual primitives as needed:

```bash
npm install @radix-ui/react-dialog
npm install @radix-ui/react-dropdown-menu
npm install @radix-ui/react-select
npm install @radix-ui/react-tabs
npm install @radix-ui/react-tooltip
npm install @radix-ui/react-accordion
npm install @radix-ui/react-checkbox
npm install @radix-ui/react-switch
```

---

## Component Patterns (with Tailwind)

### Dialog (Modal)

```tsx
import * as Dialog from '@radix-ui/react-dialog';

export function Modal({ trigger, title, children }) {
  return (
    <Dialog.Root>
      <Dialog.Trigger asChild>{trigger}</Dialog.Trigger>
      <Dialog.Portal>
        <Dialog.Overlay className="fixed inset-0 bg-black/50" />
        <Dialog.Content className="fixed left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 w-full max-w-md bg-white rounded-xl p-6 shadow-xl">
          <Dialog.Title className="text-lg font-semibold">
            {title}
          </Dialog.Title>
          <div className="mt-4">{children}</div>
          <Dialog.Close asChild>
            <button className="absolute top-4 right-4 p-1 rounded-full hover:bg-gray-100">
              Close
            </button>
          </Dialog.Close>
        </Dialog.Content>
      </Dialog.Portal>
    </Dialog.Root>
  );
}
```

### Select

```tsx
import * as Select from '@radix-ui/react-select';

export function SelectInput({ placeholder, options, value, onChange }) {
  return (
    <Select.Root value={value} onValueChange={onChange}>
      <Select.Trigger className="inline-flex items-center justify-between w-full px-3 py-2 border rounded-lg">
        <Select.Value placeholder={placeholder} />
        <Select.Icon>▼</Select.Icon>
      </Select.Trigger>

      <Select.Portal>
        <Select.Content className="bg-white rounded-lg shadow-lg border overflow-hidden">
          <Select.Viewport className="p-1">
            {options.map((option) => (
              <Select.Item
                key={option.value}
                value={option.value}
                className="flex items-center px-2 py-2 rounded-md cursor-pointer hover:bg-gray-100"
              >
                <Select.ItemText>{option.label}</Select.ItemText>
              </Select.Item>
            ))}
          </Select.Viewport>
        </Select.Content>
      </Select.Portal>
    </Select.Root>
  );
}
```

### Checkbox

```tsx
import * as Checkbox from '@radix-ui/react-checkbox';
import { CheckIcon } from 'lucide-react';

export function CheckboxInput({ id, label, checked, onCheckedChange }) {
  return (
    <div className="flex items-center gap-2">
      <Checkbox.Root
        id={id}
        checked={checked}
        onCheckedChange={onCheckedChange}
        className="w-5 h-5 rounded border border-gray-300 data-[state=checked]:bg-blue-600 data-[state=checked]:border-blue-600"
      >
        <Checkbox.Indicator className="flex items-center justify-center text-white">
          <CheckIcon className="w-3.5 h-3.5" />
        </Checkbox.Indicator>
      </Checkbox.Root>
      <label htmlFor={id} className="text-sm text-gray-700 cursor-pointer">
        {label}
      </label>
    </div>
  );
}
```

### Switch

```tsx
import * as Switch from '@radix-ui/react-switch';

export function SwitchInput({ id, label, checked, onCheckedChange }) {
  return (
    <div className="flex items-center gap-2">
      <Switch.Root
        id={id}
        checked={checked}
        onCheckedChange={onCheckedChange}
        className="w-11 h-6 bg-gray-200 rounded-full data-[state=checked]:bg-blue-600 cursor-pointer"
      >
        <Switch.Thumb className="block w-5 h-5 bg-white rounded-full shadow-md translate-x-0.5 data-[state=checked]:translate-x-[22px] transition-transform" />
      </Switch.Root>
      <label htmlFor={id} className="text-sm text-gray-700 cursor-pointer">
        {label}
      </label>
    </div>
  );
}
```

### Tooltip

```tsx
import * as Tooltip from '@radix-ui/react-tooltip';

export function TooltipWrapper({ children, content, side = 'top' }) {
  return (
    <Tooltip.Provider delayDuration={300}>
      <Tooltip.Root>
        <Tooltip.Trigger asChild>{children}</Tooltip.Trigger>
        <Tooltip.Portal>
          <Tooltip.Content
            side={side}
            className="px-3 py-1.5 text-sm text-white bg-gray-900 rounded-md shadow-md"
            sideOffset={5}
          >
            {content}
            <Tooltip.Arrow className="fill-gray-900" />
          </Tooltip.Content>
        </Tooltip.Portal>
      </Tooltip.Root>
    </Tooltip.Provider>
  );
}
```

---

## Data Attributes for Styling

Radix components expose data attributes for styling different states:

```css
[data-state="open"] { }
[data-state="closed"] { }
[data-state="checked"] { }
[data-state="unchecked"] { }
[data-disabled] { }
[data-highlighted] { }
```

---

## Best Practices

### DO

```tsx
// Use asChild to compose with your own components
<Dialog.Trigger asChild>
  <Button>Open</Button>
</Dialog.Trigger>

// Use Portal for overlays
<Dialog.Portal>
  <Dialog.Overlay />
  <Dialog.Content />
</Dialog.Portal>

// Use data attributes for styling
className="data-[state=checked]:bg-blue-600"
```

### DON'T

```tsx
// Don't skip Portal for overlays (causes z-index issues)
<Dialog.Overlay />  // Without Portal - BAD

// Don't forget accessibility - always include proper labels
```

---

## Available Primitives

**Overlay:** Dialog, Alert Dialog, Popover, Hover Card, Tooltip, Context Menu, Dropdown Menu
**Forms:** Checkbox, Radio Group, Select, Switch, Slider, Toggle
**Navigation:** Tabs, Navigation Menu
**Layout:** Accordion, Collapsible, Scroll Area

---

**Last Updated:** 2025-12-04
**Radix UI Version:** Latest
