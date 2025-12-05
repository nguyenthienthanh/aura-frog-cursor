# Chakra UI - Implementation Guide

**Design System:** Chakra UI v2+
**Based On:** Styled System + Emotion
**Platforms:** React, Next.js
**Package:** `@chakra-ui/react`, `@emotion/react`, `@emotion/styled`

---

## Installation

```bash
npm install @chakra-ui/react @emotion/react @emotion/styled framer-motion
```

### Next.js App Router Setup

```tsx
// app/providers.tsx
'use client'

import { ChakraProvider, extendTheme } from '@chakra-ui/react'

const theme = extendTheme({
  colors: {
    brand: {
      500: '#0080e6',
      600: '#0066b3',
    },
  },
})

export function Providers({ children }: { children: React.ReactNode }) {
  return (
    <ChakraProvider theme={theme}>
      {children}
    </ChakraProvider>
  )
}
```

---

## Component Patterns

### Buttons

```tsx
import { Button, IconButton, ButtonGroup } from '@chakra-ui/react'
import { AddIcon, DeleteIcon } from '@chakra-ui/icons'

<Button colorScheme="blue">Primary</Button>
<Button colorScheme="gray" variant="outline">Outline</Button>
<Button variant="ghost">Ghost</Button>
<Button leftIcon={<AddIcon />} colorScheme="teal">Add Item</Button>
<Button isLoading colorScheme="blue">Loading</Button>
<IconButton aria-label="Delete" icon={<DeleteIcon />} colorScheme="red" />
```

### Forms

```tsx
import {
  FormControl,
  FormLabel,
  FormErrorMessage,
  Input,
  Select,
  Checkbox,
} from '@chakra-ui/react'

<FormControl isInvalid={!!errors.email}>
  <FormLabel>Email</FormLabel>
  <Input type="email" placeholder="you@example.com" />
  {errors.email && (
    <FormErrorMessage>{errors.email.message}</FormErrorMessage>
  )}
</FormControl>
```

### Cards

```tsx
import { Card, CardHeader, CardBody, CardFooter, Heading, Text } from '@chakra-ui/react'

<Card>
  <CardHeader>
    <Heading size="md">Card Title</Heading>
  </CardHeader>
  <CardBody>
    <Text>Card content goes here.</Text>
  </CardBody>
  <CardFooter>
    <Button colorScheme="blue">Action</Button>
  </CardFooter>
</Card>
```

### Modal

```tsx
import {
  Modal,
  ModalOverlay,
  ModalContent,
  ModalHeader,
  ModalBody,
  ModalCloseButton,
  useDisclosure,
} from '@chakra-ui/react'

const { isOpen, onOpen, onClose } = useDisclosure()

<Modal isOpen={isOpen} onClose={onClose} isCentered>
  <ModalOverlay />
  <ModalContent>
    <ModalHeader>Modal Title</ModalHeader>
    <ModalCloseButton />
    <ModalBody>Content</ModalBody>
  </ModalContent>
</Modal>
```

### Layout

```tsx
import { Box, Flex, Grid, Stack, Container } from '@chakra-ui/react'

<Flex align="center" justify="space-between">
  <Box>Left</Box>
  <Box>Right</Box>
</Flex>

<Stack spacing={4}>
  <Box>Item 1</Box>
  <Box>Item 2</Box>
</Stack>

<Grid templateColumns={{ base: '1fr', md: 'repeat(2, 1fr)', lg: 'repeat(3, 1fr)' }} gap={6}>
  {items.map(item => <GridItem key={item.id}>...</GridItem>)}
</Grid>
```

---

## Style Props

```tsx
<Box
  p={4}           // padding
  m={2}           // margin
  bg="blue.500"
  color="white"
  w="100%"        // width
  borderRadius="lg"
  boxShadow="md"
  fontSize={{ base: 'sm', md: 'md', lg: 'lg' }}
>
  Content
</Box>
```

---

## Dark Mode

```tsx
import { useColorMode, useColorModeValue } from '@chakra-ui/react'

function ThemeToggle() {
  const { colorMode, toggleColorMode } = useColorMode()
  const bg = useColorModeValue('white', 'gray.800')

  return <Box bg={bg}>...</Box>
}
```

---

## Best Practices

### DO

```tsx
// Use theme tokens
<Box bg="blue.500" color="white" p={4}>

// Use responsive arrays/objects
<Box fontSize={{ base: 'sm', md: 'md' }}>

// Use Stack for consistent spacing
<Stack spacing={4}>
```

### DON'T

```tsx
// Avoid inline styles
<Box style={{ backgroundColor: 'blue' }}>  // BAD

// Don't skip aria labels on icon buttons
<IconButton icon={<DeleteIcon />} />  // BAD - missing aria-label
```

---

**Last Updated:** 2025-12-04
**Chakra UI Version:** 2.x
