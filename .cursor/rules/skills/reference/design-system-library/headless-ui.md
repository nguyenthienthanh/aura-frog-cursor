# Headless UI - Implementation Guide

**Design System:** Headless UI
**Type:** Headless UI Component Library
**Platforms:** React, Vue
**Package:** `@headlessui/react`, `@headlessui/vue`
**From:** Tailwind Labs

---

## Key Concept

Headless UI provides completely unstyled, fully accessible UI components designed to integrate with Tailwind CSS. Unlike Radix, it's more opinionated about transitions and comes from Tailwind Labs.

---

## Installation

```bash
npm install @headlessui/react
```

---

## Component Patterns (React + Tailwind)

### Dialog (Modal)

```tsx
import { Dialog, Transition } from '@headlessui/react';
import { Fragment, useState } from 'react';

export function Modal({ isOpen, onClose, title, children }) {
  return (
    <Transition appear show={isOpen} as={Fragment}>
      <Dialog as="div" className="relative z-50" onClose={onClose}>
        <Transition.Child
          as={Fragment}
          enter="ease-out duration-300"
          enterFrom="opacity-0"
          enterTo="opacity-100"
          leave="ease-in duration-200"
          leaveFrom="opacity-100"
          leaveTo="opacity-0"
        >
          <div className="fixed inset-0 bg-black/50" />
        </Transition.Child>

        <div className="fixed inset-0 overflow-y-auto">
          <div className="flex min-h-full items-center justify-center p-4">
            <Dialog.Panel className="w-full max-w-md rounded-2xl bg-white p-6 shadow-xl">
              <Dialog.Title className="text-lg font-medium">
                {title}
              </Dialog.Title>
              <div className="mt-4">{children}</div>
            </Dialog.Panel>
          </div>
        </div>
      </Dialog>
    </Transition>
  );
}
```

### Menu (Dropdown)

```tsx
import { Menu, Transition } from '@headlessui/react';

export function Dropdown({ items }) {
  return (
    <Menu as="div" className="relative">
      <Menu.Button className="rounded-lg bg-gray-100 px-4 py-2">
        Options
      </Menu.Button>

      <Transition
        enter="transition ease-out duration-100"
        enterFrom="transform opacity-0 scale-95"
        enterTo="transform opacity-100 scale-100"
        leave="transition ease-in duration-75"
        leaveFrom="transform opacity-100 scale-100"
        leaveTo="transform opacity-0 scale-95"
      >
        <Menu.Items className="absolute right-0 mt-2 w-56 rounded-lg bg-white shadow-lg">
          {items.map((item) => (
            <Menu.Item key={item.label}>
              {({ active }) => (
                <button
                  onClick={item.onClick}
                  className={`${active ? 'bg-gray-100' : ''} w-full px-3 py-2 text-left text-sm`}
                >
                  {item.label}
                </button>
              )}
            </Menu.Item>
          ))}
        </Menu.Items>
      </Transition>
    </Menu>
  );
}
```

### Listbox (Select)

```tsx
import { Listbox, Transition } from '@headlessui/react';

export function Select({ options, value, onChange, label }) {
  return (
    <Listbox value={value} onChange={onChange}>
      <Listbox.Label className="block text-sm font-medium">{label}</Listbox.Label>
      <Listbox.Button className="relative w-full rounded-lg border py-2.5 pl-3 pr-10 text-left">
        {value?.name || 'Select option'}
      </Listbox.Button>
      <Listbox.Options className="absolute z-10 mt-1 max-h-60 w-full overflow-auto rounded-lg bg-white shadow-lg">
        {options.map((option) => (
          <Listbox.Option
            key={option.id}
            value={option}
            className={({ active }) => `${active ? 'bg-blue-100' : ''} cursor-pointer py-2 pl-10 pr-4`}
          >
            {option.name}
          </Listbox.Option>
        ))}
      </Listbox.Options>
    </Listbox>
  );
}
```

### Switch (Toggle)

```tsx
import { Switch } from '@headlessui/react';

export function Toggle({ label, enabled, onChange }) {
  return (
    <Switch.Group>
      <div className="flex items-center gap-3">
        <Switch
          checked={enabled}
          onChange={onChange}
          className={`${enabled ? 'bg-blue-600' : 'bg-gray-200'}
            relative inline-flex h-6 w-11 items-center rounded-full transition-colors`}
        >
          <span
            className={`${enabled ? 'translate-x-6' : 'translate-x-1'}
              inline-block h-4 w-4 transform rounded-full bg-white transition-transform`}
          />
        </Switch>
        <Switch.Label className="text-sm">{label}</Switch.Label>
      </div>
    </Switch.Group>
  );
}
```

### Tabs

```tsx
import { Tab } from '@headlessui/react';

export function Tabs({ tabs }) {
  return (
    <Tab.Group>
      <Tab.List className="flex space-x-1 rounded-xl bg-gray-100 p-1">
        {tabs.map((tab) => (
          <Tab
            key={tab.label}
            className={({ selected }) =>
              `w-full rounded-lg py-2.5 text-sm font-medium
               ${selected ? 'bg-white text-blue-700 shadow' : 'text-gray-600 hover:text-gray-900'}`
            }
          >
            {tab.label}
          </Tab>
        ))}
      </Tab.List>
      <Tab.Panels className="mt-4">
        {tabs.map((tab, idx) => (
          <Tab.Panel key={idx} className="rounded-xl bg-white p-4">
            {tab.content}
          </Tab.Panel>
        ))}
      </Tab.Panels>
    </Tab.Group>
  );
}
```

---

## Render Props Pattern

All Headless UI components use render props to expose state:

```tsx
<Menu.Item>
  {({ active, disabled }) => (
    <button className={active ? 'bg-blue-500' : ''}>
      Menu Item
    </button>
  )}
</Menu.Item>
```

---

## Best Practices

### DO

```tsx
// Use Transition for smooth animations
<Transition enter="..." leave="...">

// Use Fragment to avoid extra DOM elements
<Transition as={Fragment}>

// Use render props for dynamic styling
{({ active }) => <button className={active ? '...' : '...'}>}
```

---

## Available Components

**Menu & Selection:** Menu, Listbox, Combobox, Radio Group
**Overlay:** Dialog, Popover
**Layout:** Disclosure, Tab
**Forms:** Switch
**Utility:** Transition, FocusTrap, Portal

---

**Last Updated:** 2025-12-04
**Headless UI Version:** 2.x
