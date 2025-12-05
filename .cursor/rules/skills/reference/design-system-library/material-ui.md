# Material UI (MUI) - Implementation Guide

**Design System:** Material UI v5+
**Based On:** Google Material Design 3
**Platforms:** React, Next.js
**Package:** `@mui/material`, `@mui/icons-material`, `@mui/x-data-grid`

---

## Installation

```bash
# Core
npm install @mui/material @emotion/react @emotion/styled

# Icons
npm install @mui/icons-material

# Data Grid (tables)
npm install @mui/x-data-grid
```

---

## Theme Setup

```typescript
// theme/theme.ts
import { createTheme } from '@mui/material/styles';

export const theme = createTheme({
  palette: {
    mode: 'light',
    primary: {
      main: '#1976d2',
    },
    secondary: {
      main: '#9c27b0',
    },
  },
  typography: {
    fontFamily: '"Roboto", "Helvetica", "Arial", sans-serif',
    button: {
      textTransform: 'none',
    },
  },
  shape: {
    borderRadius: 8,
  },
});
```

### Theme Provider

```tsx
import { ThemeProvider } from '@mui/material/styles';
import CssBaseline from '@mui/material/CssBaseline';

<ThemeProvider theme={theme}>
  <CssBaseline />
  {children}
</ThemeProvider>
```

---

## Component Patterns

### Buttons

```tsx
import Button from '@mui/material/Button';
import IconButton from '@mui/material/IconButton';
import SaveIcon from '@mui/icons-material/Save';

<Button variant="contained" color="primary">Save</Button>
<Button variant="outlined" color="secondary">Cancel</Button>
<Button variant="text">Learn More</Button>
<Button variant="contained" startIcon={<SaveIcon />}>Save</Button>

<IconButton color="primary" aria-label="delete">
  <DeleteIcon />
</IconButton>
```

### Forms

```tsx
import TextField from '@mui/material/TextField';
import FormControl from '@mui/material/FormControl';
import Select from '@mui/material/Select';
import MenuItem from '@mui/material/MenuItem';

<TextField
  label="Email"
  type="email"
  variant="outlined"
  fullWidth
  error={!!errors.email}
  helperText={errors.email?.message}
/>

<FormControl fullWidth>
  <InputLabel id="role-label">Role</InputLabel>
  <Select labelId="role-label" label="Role" value={role} onChange={handleChange}>
    <MenuItem value="admin">Admin</MenuItem>
    <MenuItem value="user">User</MenuItem>
  </Select>
</FormControl>
```

### Cards

```tsx
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import CardActions from '@mui/material/CardActions';
import Typography from '@mui/material/Typography';

<Card sx={{ maxWidth: 345 }}>
  <CardMedia component="img" height="140" image="/image.jpg" alt="Description" />
  <CardContent>
    <Typography gutterBottom variant="h5">Card Title</Typography>
    <Typography variant="body2" color="text.secondary">
      Card description goes here.
    </Typography>
  </CardContent>
  <CardActions>
    <Button size="small">Share</Button>
    <Button size="small">Learn More</Button>
  </CardActions>
</Card>
```

### Dialogs/Modals

```tsx
import Dialog from '@mui/material/Dialog';
import DialogTitle from '@mui/material/DialogTitle';
import DialogContent from '@mui/material/DialogContent';
import DialogActions from '@mui/material/DialogActions';

<Dialog open={open} onClose={handleClose} maxWidth="sm" fullWidth>
  <DialogTitle>Confirm Action</DialogTitle>
  <DialogContent>
    <Typography>Are you sure you want to proceed?</Typography>
  </DialogContent>
  <DialogActions>
    <Button onClick={handleClose}>Cancel</Button>
    <Button onClick={handleConfirm} variant="contained">Confirm</Button>
  </DialogActions>
</Dialog>
```

---

## Styling (sx Prop)

```tsx
<Box
  sx={{
    display: 'flex',
    flexDirection: 'column',
    gap: 2,
    p: 3,
    bgcolor: 'background.paper',
    borderRadius: 2,
    boxShadow: 1,
    '&:hover': {
      boxShadow: 3,
    },
  }}
>
  <Typography variant="h6">Title</Typography>
</Box>
```

---

## Responsive Design

```tsx
<Box
  sx={{
    width: {
      xs: '100%',
      sm: '50%',
      md: '33.33%',
    },
    display: {
      xs: 'none',
      md: 'block',
    },
  }}
/>

<Grid container spacing={2}>
  <Grid item xs={12} md={6} lg={4}>
    <Card>...</Card>
  </Grid>
</Grid>
```

---

## Best Practices

### DO

```tsx
// Use theme values
<Box sx={{ p: 2, gap: 2 }} />

// Use color tokens
<Typography color="text.secondary" />

// Use variants
<Button variant="contained" />

// Responsive values
<Box sx={{ display: { xs: 'none', md: 'block' } }} />
```

### DON'T

```tsx
// Avoid hardcoded values
<Box style={{ padding: '16px' }} />  // BAD

// Avoid inline colors
<Typography style={{ color: '#666' }} />  // BAD
```

---

**Last Updated:** 2025-12-04
**MUI Version:** 5.x / 6.x
