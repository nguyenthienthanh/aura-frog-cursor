# Documents Directory

**Purpose:** Stores generated documentation from `document` command

---

## Structure

```
documents/
├── README.md
├── features/          # Feature documentation
│   ├── user-authentication.md
│   └── dark-mode.md
├── api/               # API documentation
│   ├── auth-api.md
│   └── user-api.md
├── components/        # Component documentation
│   ├── user-profile.md
│   └── button.md
├── specs/             # Technical specifications
│   ├── dark-mode-spec.md
│   └── api-refactor-spec.md
└── guides/            # User guides
    ├── authentication-guide.md
    └── deployment-guide.md
```

---

## Document Types

### 1. Feature Documentation
```bash
document feature "User Authentication"
# Output: documents/features/user-authentication.md
```

**Contains:**
- Feature overview
- Architecture diagram
- File structure
- API reference
- Usage examples
- Testing info

### 2. API Documentation
```bash
document api "src/api/authApi.ts"
# Output: documents/api/auth-api.md
```

**Contains:**
- Endpoint list
- Request/response types
- Error codes
- Usage examples

### 3. Component Documentation
```bash
document component "src/components/UserProfile.tsx"
# Output: documents/components/user-profile.md
```

**Contains:**
- Props interface
- Usage examples
- Component structure
- Styling
- Accessibility

### 4. Technical Specifications
```bash
document spec "Add dark mode support"
# Output: documents/specs/dark-mode-spec.md
```

**Contains:**
- Requirements
- Technical approach
- Implementation plan
- Testing strategy

### 5. User Guides
```bash
document guide "How to use authentication"
# Output: documents/guides/authentication-guide.md
```

**Contains:**
- Step-by-step instructions
- Common issues
- Best practices

---

## Organization

### By Type
- **features/** - Business features
- **api/** - Backend services
- **components/** - UI components
- **specs/** - Technical specifications
- **guides/** - User documentation

### Naming Convention
- Lowercase with hyphens
- Descriptive names
- Example: `user-profile-component.md`

---

## Integration

### With Workflow
```bash
# Phase 8 (Documentation) automatically generates docs
workflow:start "Add feature"
# Creates documentation in this folder
```

---

## Best Practices

1. **Descriptive names** - Use clear, searchable names
2. **Keep updated** - Regenerate when code changes
3. **Link related docs** - Reference other documents
4. **Include examples** - Show real usage

---

**Note:** Documents are generated artifacts. They can be regenerated anytime using the `document` command.
