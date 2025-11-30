# Phase 2: Design (Technical Planning)

## Purpose
Create comprehensive technical design, define architecture, plan component structure, and make all technical decisions before implementation begins.

## Prerequisites
- Phase 1 (Understand) completed and approved
- Requirements document available
- Project conventions loaded from `.cursor/project-contexts/[project]/`
- Development agent selected (e.g., `mobile-react-native`, `web-reactjs`)

## Inputs
- Requirements Analysis Document from Phase 1
- User stories and acceptance criteria
- Project tech stack and architecture patterns
- Design system components (if applicable)
- Existing codebase structure

## Execution Steps

### 1. Review Requirements (5 min)
- Read Phase 1 requirements document
- Understand all user stories and acceptance criteria
- Note technical constraints and dependencies
- Identify integration points

### 2. Architecture Design (30 min)
- Define overall architecture approach
- Choose architectural patterns (MVC, MVVM, Clean Architecture, etc.)
- Design data flow and state management strategy
- Plan API integration approach
- Design error handling strategy
- Plan offline/caching strategy (if applicable)

### 3. Component Structure (30 min)
- Break down feature into components/modules
- Define component hierarchy
- Identify reusable components
- Plan component props and interfaces
- Design component communication patterns
- Follow KISS principle (Keep It Simple, Stupid)

### 4. Data Modeling (20 min)
- Define data structures and types
- Design state shape
- Plan API request/response models
- Design local storage schema (if needed)
- Define validation rules

### 5. Integration Planning (15 min)
- Map API endpoints needed
- Define API contracts
- Plan third-party SDK integration
- Design analytics tracking points
- Plan feature flags (if applicable)

### 6. Technical Decisions (20 min)
Document key decisions:
- Libraries/packages to use
- State management approach
- Navigation strategy
- Styling approach
- Performance optimizations
- Security considerations

### 7. Cross-Review (20 min)
Design must be reviewed by:
- **Secondary Dev Agent**: Architecture soundness, KISS compliance
- **QA Agent**: Testability, automation feasibility
- **Security Expert** (if applicable): Security vulnerabilities

Consolidate feedback and refine design.

### 8. Documentation (20 min)
Create technical design document including:
- Architecture overview with diagrams
- Component structure
- Data models
- API contracts
- Technical decisions rationale
- Implementation plan

## Deliverables
- Technical Design Document (`PHASE_2_TECHNICAL_PLANNING.md`)
- Architecture diagram
- Component hierarchy diagram
- Data flow diagram
- API contract specifications
- Type definitions outline
- Secondary dev review checklist
- QA testability review checklist

## Approval Gate
Present summary to user including:
- Architecture approach
- Component breakdown
- Key technical decisions
- Cross-review results
- Next steps (Phase 3: UI Breakdown)

**Valid responses:**
- `approve` → AUTO-CONTINUE to Phase 3
- `reject: [reason]` → Redesign with feedback
- `modify: [changes]` → Adjust specific parts

## Auto-Continue Behavior
After approval, IMMEDIATELY proceed to Phase 3 (UI Breakdown). If no UI involved, skip to Phase 4 (Test Planning).

## Quality Gates
**Must Pass:**
- Architecture follows project conventions
- KISS principle applied (no over-engineering)
- All components identified
- State management strategy defined
- Cross-review approved

**Should Pass:**
- Diagrams included
- Performance considerations documented
- Security considerations addressed
- Reusability maximized

## Token Awareness
- **Typical usage**: 35-60K tokens (~45K average)
- **Cumulative**: ~70K / 200K (35%)
- Display token usage at approval gate

## Common Mistakes to Avoid
- Over-engineering (violates KISS principle)
- Premature abstraction
- Ignoring project conventions
- Skipping architecture diagrams
- Not considering testability
- Missing cross-review
- Choosing unfamiliar libraries without justification

## KISS Principle Enforcement
**Always prefer:**
- Simple solutions over complex
- Standard patterns over custom
- Readable code over clever code
- Solving today's problem, not tomorrow's

**Avoid:**
- Premature abstraction (wait for Rule of Three)
- Over-configuration
- Unnecessary layers
- Complex inheritance hierarchies

## References
- Project context: `.cursor/project-contexts/[project]/`
- Related phases: Phase 1 (Understand), Phase 3 (UI)
- Templates: `~/.claude/plugins/marketplaces/aurafrog/aura-frog/templates/tech-spec.md`
- Rules: `.cursor/rules/core/kiss-principle.mdc`, `.cursor/rules/core/architecture-patterns.mdc`
- Skills: `api-designer`, `refactor-expert`
