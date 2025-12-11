# /misc:document - Create feature documentation

**Purpose:** Create feature documentation (specs, guides, API docs)
**Aliases:** `document`, `doc`, `docs`

---

## Overview

Generate professional documentation for features, APIs, or components without full workflow execution.

**Use when:**
- Need documentation for existing code
- Creating specs before implementation
- Documenting APIs
- Writing user guides

---

## Usage

```bash
# Document a feature
/misc:document feature "User Authentication"

# Document an API
/misc:document api "src/api/authApi.ts"

# Document a component
/misc:document component "src/components/UserProfile.tsx"

# Create technical spec
/misc:document spec "Add dark mode support"

# Create user guide
/misc:document guide "How to use authentication"
```

---

## Document Types

### 1. Feature Documentation

```bash
/misc:document feature "Feature Name"
```

**Template:** `.cursor/templates/implementation-summary.md`

**Output:** `.cursor/documents/features/[feature-name].md`

**Includes:**
- Overview
- Features list
- Architecture diagram
- File structure
- API reference
- Usage examples
- Testing info
- Deployment notes

### 2. API Documentation

```bash
/misc:document api "src/api/[file].ts"
```

**Output:** `.cursor/documents/api/[api-name].md`

**Includes:**
- Endpoints
- Request/Response types
- Error codes
- Usage examples
- Mock API setup

### 3. Component Documentation

```bash
/misc:document component "src/components/[Component].tsx"
```

**Output:** `.cursor/documents/components/[component-name].md`

**Includes:**
- Props interface
- Usage examples
- Component structure
- State management
- Styling info
- Accessibility notes
- Platform notes

### 4. Technical Specification

```bash
/misc:document spec "Feature description"
```

**Template:** `.cursor/templates/tech-spec.md`

**Output:** `.cursor/documents/specs/[spec-name].md`

**Includes:**
- Requirements
- Architecture
- Data models
- API specification
- Security considerations
- Testing strategy

### 5. User Guide

```bash
/misc:document guide "Guide topic"
```

**Output:** `.cursor/documents/guides/[guide-name].md`

**Includes:**
- Step-by-step instructions
- Screenshots placeholders
- Common issues
- Best practices

---

## Output Location

All documents are stored in `.cursor/documents/`:

```
.cursor/documents/
├── features/          # Feature documentation
│   └── user-authentication.md
├── api/               # API documentation
│   └── auth-api.md
├── components/        # Component documentation
│   └── user-profile.md
├── specs/             # Technical specifications
│   └── dark-mode-spec.md
└── guides/            # User guides
    └── authentication-guide.md
```

---

## Execution Steps

1. **Identify document type** from user request
2. **Load appropriate template** from `.cursor/templates/`
3. **Analyze codebase** (if documenting existing code)
4. **Generate documentation** following template structure
5. **Save to correct location** in `.cursor/documents/`
6. **Return path** to generated document

---

## Templates

| Document Type | Template |
|---------------|----------|
| Feature | `templates/implementation-summary.md` |
| API | `templates/api-doc.md` (or inline) |
| Component | `templates/component-doc.md` (or inline) |
| Spec | `templates/tech-spec.md` |
| Guide | `templates/user-guide.md` (or inline) |
| Test Plan | `templates/test-plan.md` |
| Requirements | `templates/requirements.md` |
| LLD | `templates/lld.md` |
| Deployment | `templates/deployment-guide.md` |

---

## Agent Selection

When this command is invoked, the appropriate agent is selected based on document type:

| Document Type | Agent |
|---------------|-------|
| Feature | `pm-operations-orchestrator` |
| API | Backend agent (nodejs/python/go/laravel) |
| Component | Frontend agent (react/vue/angular/react-native) |
| Spec | `pm-operations-orchestrator` |
| Guide | `pm-operations-orchestrator` |

---

## Success Criteria

- Documentation generated
- Proper format applied
- Saved to `.cursor/documents/` folder
- Path returned to user

---

**Source:** Aura Frog v1.1.5
**Updated:** 2025-12-08
