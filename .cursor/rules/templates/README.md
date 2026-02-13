# Aura Frog Documentation Templates

This directory contains documentation templates used throughout the Aura Frog 9-phase workflow. Each template corresponds to specific workflow phases and provides a structured format for generating consistent, high-quality documentation.

## What Are Templates?

Templates are **structured markdown documents** that define the format and content for deliverables in each workflow phase. They ensure:
- Consistent documentation across projects
- Comprehensive coverage of all necessary details
- Easy handoff between team members
- Professional, stakeholder-ready outputs

## Available Templates

### Phase 1: Requirements Analysis

#### requirements.mdc
**Purpose:** Document requirements, user stories, and acceptance criteria

**Sections:**
- Overview
- Functional Requirements (FR-001, FR-002, etc.)
- Non-Functional Requirements (Performance, Security, Usability)
- User Stories
- Dependencies, Assumptions, Constraints
- Risks and Mitigations
- Success Criteria
- Initial Estimation (story points, time, confidence)

**Output Example:** `.cursor/logs/workflows/[id]/requirements.md`

---

### Phase 2: Technical Planning

#### tech-spec.mdc
**Purpose:** Define comprehensive technical specification with visualizations

**Sections:**
- Overview and Stakeholders
- Requirements Summary
- Architecture (high-level, component structure, data flow)
- **Diagrams (Mermaid)** - Sequence, ERD, Architecture, State diagrams
- Data Models (frontend, backend, database)
- API Specification (all endpoints with examples)
- State Management (global, server, local)
- Security Considerations
- Performance Targets
- Error Handling Strategy
- Testing Strategy
- Deployment Strategy
- Rollback Plan
- Dependencies
- Timeline & Milestones

**Output Example:** `.cursor/logs/workflows/[id]/tech-spec.md`

**Related:**
- `lld.mdc` for detailed component design
- `mermaid-diagrams.mdc` skill for diagram syntax

---

#### lld.mdc (Low-Level Design)
**Purpose:** Detailed component-level design

**Sections:**
- Component Architecture (hierarchy, responsibilities)
- Data Structures (TypeScript interfaces, types)
- API Endpoints (detailed request/response)
- State Management (local, global, server)
- File Structure
- Functions & Methods (signatures, logic, implementation)
- Error Handling
- Performance Optimizations
- Testing Strategy

**Output Example:** `.cursor/logs/workflows/[id]/lld.md`

---

### Phase 4: Test Planning

#### test-plan.mdc
**Purpose:** Define comprehensive testing strategy

**Sections:**
- Test Strategy (scope, test types, coverage goals)
- Test Environment (devices, OS, browsers, network)
- Test Cases Summary (categorized by priority)
- Test Categories (rendering, interactions, API, errors, performance)
- Risk Assessment
- Test Schedule
- Test Tools & Frameworks
- Success Criteria

**Output Example:** `.cursor/logs/workflows/[id]/test-plan.md`

---

#### test-cases.mdc
**Purpose:** Document individual test case specifications

**Sections:**
- Test Case ID and Priority
- Description
- Pre-conditions
- Steps to Execute
- Expected Results
- Test Code (actual Jest/testing-library code)

**Output Example:** `.cursor/logs/workflows/[id]/test-cases.md`

**Note:** Used in Phase 4 (planning) and Phase 5a (implementation)

---

### Phase 8: Documentation

#### implementation-summary.mdc
**Purpose:** Summarize what was built and how it performed

**Sections:**
- Executive Summary
- Implementation Details (components, files, technologies)
- Test Results (coverage, breakdown)
- Performance Metrics
- Challenges & Solutions
- Code Quality Metrics
- Deployment Timeline and Status
- Documentation Links
- Feature Adoption and Analytics
- Team Contributors
- Known Issues
- Lessons Learned
- Next Steps

**Output Example:** `.cursor/logs/workflows/[id]/implementation-summary.md`

---

#### deployment-guide.mdc
**Purpose:** Document deployment procedures

**Sections:**
- Pre-Deployment Checklist
- Environment Configuration
- Deployment Steps (pre-deploy, staging, smoke tests, production)
- Post-Deployment Verification
- Rollback Plan
- Troubleshooting Common Issues
- Support Contacts
- Known Issues
- Deployment History

**Output Example:** `.cursor/logs/workflows/[id]/deployment-guide.md`

---

#### confluence-page.mdc
**Purpose:** Generate Confluence-ready wiki documentation

**Format:** Confluence wiki markup

**Sections:**
- Overview
- Implementation Details
- Test Results (in table format)
- Architecture (code blocks with diagrams)
- API Endpoints (formatted examples)
- Features (completed and future)
- Performance Metrics (tables)
- User Metrics
- Challenges & Solutions
- Deployment Timeline
- Screenshots (with image tags)
- Documentation Links
- Team Information
- Next Steps

**Output Example:** `.cursor/logs/workflows/[id]/confluence-page.txt`

**Special:** Uses Confluence markup (`h1.`, `||table||`, `{code}`, etc.)

---

## Template Usage by Phase

| Phase | Templates Used | Purpose |
|-------|----------------|---------|
| 1. Requirements Analysis | `requirements.mdc` | Document what needs to be built |
| 2. Technical Planning | `tech-spec.mdc`, `lld.mdc`, `mermaid-diagrams.mdc` | Define how it will be built + visualizations |
| 3. Design Review | *(Uses tech-spec)* | Validate design alignment |
| 4. Test Planning | `test-plan.mdc`, `test-cases.mdc` | Plan testing approach |
| 5a. Write Tests (RED) | `test-cases.mdc` | Implement test code |
| 5b. Implementation (GREEN) | *(Code implementation)* | Make tests pass |
| 5c. Refactor | *(Code improvement)* | Optimize and clean up |
| 6. Code Review | *(Review against tech-spec)* | Validate quality |
| 7. QA Validation | *(Execute test-plan)* | Verify functionality |
| 8. Documentation | `implementation-summary.mdc`, `deployment-guide.mdc`, `confluence-page.mdc` | Document everything |
| 9. Notification | `confluence-page.mdc` | Share with stakeholders |

## Template Relationships

### Document Flow

```
requirements.mdc (Phase 1)
      ↓ feeds into
tech-spec.mdc (Phase 2)
  + mermaid-diagrams.mdc → Sequence, ERD, Architecture diagrams
      ↓ feeds into
test-plan.mdc (Phase 4)
      ↓ feeds into
test-cases.mdc (Phase 4/5a)
      ↓ tested via
(Implementation - Phase 5b/5c)
      ↓ documented in
implementation-summary.mdc (Phase 8)
deployment-guide.mdc (Phase 8)
confluence-page.mdc (Phase 8)
```

### Cross-References

**Requirements → Tech Spec:**
- Requirements become functional requirements in tech spec
- User stories inform architecture decisions

**Tech Spec → Test Plan:**
- API endpoints become integration test cases
- Components become unit test targets
- Performance targets become performance test criteria

**Test Plan → Test Cases:**
- Test categories become individual test case groups
- Success criteria become test assertions

**All Phases → Implementation Summary:**
- Requirements define what was built
- Tech spec defines how it was built
- Test results validate it was built correctly
- Deployment guide shows it was deployed successfully

## Project Customization

### Using Project Context

Templates reference project-specific conventions from:
- `.cursor/project-contexts/[project]/conventions.md` - Naming, structure
- `.cursor/project-contexts/[project]/examples.md` - Code patterns
- `.cursor/project-contexts/[project]/project-config.yaml` - Tech stack
- `.cursor/project-contexts/[project]/rules.md` - Quality standards

### Customizing Templates

To create project-specific templates:
1. Copy template to `.cursor/rules/templates/custom/`
2. Modify sections as needed
3. Add project-specific sections
4. Reference in workflow configuration

### Example Customizations

**For Mobile Apps:**
- Add app store submission checklist
- Include platform-specific sections (iOS/Android)
- Add device compatibility matrix

**For Web Apps:**
- Add browser compatibility matrix
- Include SEO checklist
- Add accessibility audit section

**For Backend Services:**
- Add API versioning strategy
- Include database migration procedures
- Add monitoring and alerting setup

## Template Best Practices

### 1. Always Start from Template
Don't write documentation from scratch - use the template as foundation.

### 2. Fill In All Sections
Even if brief, address every section. Use "N/A" if truly not applicable.

### 3. Use Examples
Include concrete examples, code snippets, API responses.

### 4. Link Everything
Link to JIRA, PRs, Confluence, demos, screenshots.

### 5. Keep It Updated
Update documentation as implementation evolves.

### 6. Make It Readable
Use tables, code blocks, formatting for clarity.

### 7. Include Visuals
Add diagrams, screenshots, charts where helpful.

## Common Patterns

### Tables for Structure
Use tables for requirements, test cases, metrics, timelines.

### Code Blocks for Examples
Use fenced code blocks with language tags for syntax highlighting.

### Checklists for Validation
Use checkboxes for checklists, success criteria, deployment steps.

### Sections for Organization
Use clear heading hierarchy (h2, h3, h4) for navigation.

## Output Locations

Templates generate files in workflow directory:
```
.cursor/logs/workflows/[workflow-id]/
├── requirements.md
├── tech-spec.md
├── lld.md
├── test-plan.md
├── test-cases.md
├── implementation-summary.md
├── deployment-guide.md
└── confluence-page.txt
```

## Integration with Cursor

Templates are MDC (Markdown Context) files:
- Indexed by Cursor IDE
- Activated contextually during workflow
- Provide structure for AI-generated documentation
- Ensure consistency across projects

## Version Control

**Commit Templates:** Templates are version-controlled in `.cursor/rules/templates/`

**Commit Outputs:** Generated documentation in `.cursor/logs/workflows/` should:
- Be committed for project history
- Be linked in PRs and JIRA tickets
- Be copied to Confluence for stakeholder access

## Related Documentation

- **Hooks:** `.cursor/rules/hooks/` - Lifecycle hooks that use these templates
- **Core Rules:** `.cursor/rules/core.mdc` - Overall Aura Frog behavior
- **Agents:** `.cursor/rules/agents/` - Agent-specific documentation patterns
- **Project Context:** `.cursor/project-contexts/[project]/` - Project conventions

---

**Version:** 1.11.0
**Adapted from:** Aura Frog templates system
**For:** Cursor IDE
**Date:** 2025-12-11
