# Phase 3: UI Breakdown (Design Analysis)

## Purpose
Analyze UI/UX requirements, extract design tokens, break down components, and create implementation strategy for visual elements.

## Prerequisites
- Phase 2 (Design) completed and approved
- Technical design document available
- Figma designs or wireframes (if available)
- Design system documentation
- UI designer agent selected

## Inputs
- Technical Design Document from Phase 2
- Figma design files or screenshots
- Design system specifications
- Component library documentation
- Accessibility requirements

## Execution Steps

### 1. Design Analysis (15 min)
- Review Figma designs or wireframes
- Extract design specifications
- Identify unique visual components
- Note interactions and animations
- Document responsive behavior

### 2. Design Token Extraction (20 min)
Extract and document:
- **Colors**: Primary, secondary, semantic colors
- **Typography**: Font families, sizes, weights, line heights
- **Spacing**: Margins, paddings, gaps (8px grid, etc.)
- **Borders**: Radius, width, colors
- **Shadows**: Elevation levels
- **Animations**: Transitions, durations, easing

### 3. Component Breakdown (25 min)
For each screen/feature:
- Break into atomic components
- Define component variants (states, sizes, themes)
- Map components to design system
- Identify new components vs. existing
- Plan component composition

### 4. Layout Strategy (15 min)
- Define layout patterns (Stack, Grid, Flex)
- Plan responsive breakpoints
- Document spacing system usage
- Define container constraints
- Plan scrolling behavior

### 5. Interaction Design (15 min)
Document:
- Touch targets (minimum 44x44pt)
- Gesture handling
- Animations and transitions
- Loading states
- Error states
- Empty states
- Success states

### 6. Accessibility Planning (15 min)
- Semantic HTML/component structure
- ARIA labels and roles
- Keyboard navigation
- Screen reader support
- Color contrast compliance (WCAG AA)
- Focus management

### 7. Implementation Strategy (15 min)
- Order of component implementation
- Dependencies between components
- Styling approach (CSS-in-JS, Tailwind, etc.)
- Asset requirements (icons, images)
- Animation libraries needed

## Deliverables
- UI Breakdown Document (`PHASE_3_DESIGN_REVIEW.md`)
- Design tokens specification
- Component hierarchy and variants
- Layout specifications
- Interaction patterns documentation
- Accessibility checklist
- Asset list
- Implementation order plan

## Approval Gate
Present summary to user including:
- Component breakdown (count and types)
- Design token extraction
- Accessibility considerations
- Implementation approach
- Next steps (Phase 4: Test Planning)

**Valid responses:**
- `approve` → AUTO-CONTINUE to Phase 4
- `reject: [reason]` → Revise UI breakdown
- `modify: [changes]` → Adjust specific components
- `skip` → If no UI work needed, jump to Phase 4

## Auto-Continue Behavior
After approval, IMMEDIATELY proceed to Phase 4 (Test Planning).

## Quality Gates
**Must Pass:**
- All components identified
- Design tokens extracted
- Accessibility requirements defined
- Touch targets meet minimum size (44x44pt)
- Color contrast meets WCAG AA

**Should Pass:**
- Component reusability maximized
- Design system consistency maintained
- Responsive behavior documented
- Animations specified

## Token Awareness
- **Typical usage**: 20-40K tokens (~30K average)
- **Cumulative**: ~100K / 200K (50%)
- Display token usage at approval gate

## Common Mistakes to Avoid
- Creating too many unique components (not reusing)
- Ignoring design system components
- Skipping accessibility considerations
- Missing touch target sizes
- Not documenting component states
- Forgetting responsive behavior
- Over-complicating component hierarchy

## Phase Skipping Rules
**Skip this phase if:**
- No UI changes required (backend-only, API, data migration)
- Pure refactoring with no visual changes
- Bug fix with no UI impact

**Reference**: `~/.cursor/plugins/marketplaces/aurafrog/aura-frog/skills/workflow-orchestrator/phase-skipping.md`

## References
- Project context: `.cursor/project-contexts/[project]/`
- Related phases: Phase 2 (Design), Phase 4 (Test Planning)
- Rules: `.cursor/rules/core/accessibility.mdc`, `.cursor/rules/core/design-system.mdc`
- Skills: `figma-integration`
