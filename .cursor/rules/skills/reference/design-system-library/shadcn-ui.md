# shadcn/ui - Implementation Guide

**Design System:** shadcn/ui
**Based On:** Radix UI Primitives + Tailwind CSS
**Platforms:** React, Next.js

---

## Key Concept

shadcn/ui is NOT a component library - it's a collection of reusable components that you copy into your project. You own the code.

---

## Installation

```bash
npx shadcn@latest init
npx shadcn@latest add button card form dialog table
```

---

## Project Structure

```
components/
└── ui/           # shadcn components
    ├── button.tsx
    ├── card.tsx
    └── dialog.tsx
lib/
└── utils.ts      # cn() utility
components.json   # shadcn config
```

---

## Component Patterns

### Button

```tsx
import { Button } from "@/components/ui/button"

<Button>Default</Button>
<Button variant="secondary">Secondary</Button>
<Button variant="destructive">Destructive</Button>
<Button variant="outline">Outline</Button>
<Button variant="ghost">Ghost</Button>

// Sizes
<Button size="sm">Small</Button>
<Button size="lg">Large</Button>
<Button size="icon"><PlusIcon /></Button>

// Loading
<Button disabled>
  <Loader2 className="mr-2 h-4 w-4 animate-spin" />
  Loading
</Button>
```

### Form with React Hook Form + Zod

```tsx
import { zodResolver } from "@hookform/resolvers/zod"
import { useForm } from "react-hook-form"
import * as z from "zod"
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form"
import { Input } from "@/components/ui/input"

const formSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
})

export function LoginForm() {
  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
  })

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
        <FormField
          control={form.control}
          name="email"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Email</FormLabel>
              <FormControl>
                <Input {...field} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
        <Button type="submit">Sign In</Button>
      </form>
    </Form>
  )
}
```

### Card

```tsx
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card"

<Card>
  <CardHeader>
    <CardTitle>Create Project</CardTitle>
    <CardDescription>Deploy in one-click.</CardDescription>
  </CardHeader>
  <CardContent>
    <Input placeholder="Project name" />
  </CardContent>
  <CardFooter className="flex justify-between">
    <Button variant="outline">Cancel</Button>
    <Button>Deploy</Button>
  </CardFooter>
</Card>
```

### Dialog

```tsx
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog"

<Dialog>
  <DialogTrigger asChild>
    <Button>Edit Profile</Button>
  </DialogTrigger>
  <DialogContent>
    <DialogHeader>
      <DialogTitle>Edit Profile</DialogTitle>
    </DialogHeader>
    <div className="py-4">
      <Input />
    </div>
    <Button>Save changes</Button>
  </DialogContent>
</Dialog>
```

---

## Dark Mode

```tsx
// Install next-themes
import { ThemeProvider } from "next-themes"

<ThemeProvider attribute="class" defaultTheme="system">
  {children}
</ThemeProvider>
```

---

## Best Practices

### DO
```tsx
// Use cn() for conditional classes
import { cn } from "@/lib/utils"
<div className={cn("flex", isActive && "bg-primary")} />

// Extend components properly
const CustomButton = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, ...props }, ref) => (
    <Button ref={ref} className={cn("custom", className)} {...props} />
  )
)
```

### DON'T
```tsx
// Don't modify ui/ files directly
// Don't use inline styles
<Button style={{ backgroundColor: 'red' }} />  // BAD
```

---

**Last Updated:** 2025-12-05
