# Phase 1: Understand (Requirements Analysis)

## Purpose
Thoroughly understand the business requirement, extract user stories, identify stakeholders, and define success criteria before any technical decisions are made.

## Prerequisites
- Project context loaded from `.cursor/project-contexts/[project]/`
- JIRA ticket or user requirement available
- Appropriate agent selected (typically `pm-operations-orchestrator`)

## Inputs
- JIRA ticket ID or feature description
- Product requirements document (PRD) if available
- Figma designs or wireframes (optional)
- Related documentation
- Stakeholder feedback

## Execution Steps

### 1. Requirement Gathering (10 min)
- Fetch JIRA ticket details (if applicable)
- Read related documentation (Confluence, PRD)
- Extract key information: summary, description, priority, components
- Identify issue type: Story, Bug, Task, Epic

### 2. Clarify Ambiguities (15 min)
Ask clarifying questions:
- **Business**: What problem does this solve? Who are target users? Expected impact?
- **Technical**: Which platforms? Regions? Device types? Integration requirements?
- **Design**: Are designs ready? Design system to follow? Accessibility requirements?

Wait for user responses before proceeding.

### 3. User Story Breakdown (15 min)
- Extract user stories in format: "As a [role], I want to [action], so that [benefit]"
- Define SMART acceptance criteria (Specific, Measurable, Achievable, Relevant, Testable)
- Identify edge cases and error scenarios
- Assign priorities: Must Have, Should Have, Could Have, Won't Have

### 4. Technical Feasibility (10 min)
- Check platform limitations and SDK compatibility
- Identify external dependencies
- Identify internal dependencies
- Assess technical risks and define mitigations
- Estimate timeline

### 5. Cross-Review (15 min)
Requirements must be reviewed by:
- **Dev Agent**: Technical feasibility, clarity, integration points
- **QA Agent**: Testable criteria, measurable metrics, edge cases
- **UI Designer** (if applicable): Design requirements, UI/UX considerations

Consolidate feedback and address concerns.

### 6. Documentation (15 min)
Create comprehensive requirements document including:
- Executive summary
- Business goals and success metrics
- User stories with acceptance criteria
- Functional and non-functional requirements
- Dependencies and risks
- Timeline estimate
- Traceability matrix

## Deliverables
- Requirements Analysis Document (`PHASE_1_REQUIREMENTS_ANALYSIS.md`)
- User stories with acceptance criteria
- Edge cases documentation
- Risk assessment with mitigations
- Traceability matrix
- Dev technical review checklist
- QA testability review checklist
- UI design review checklist (if applicable)

## Approval Gate
Present summary to user including:
- Feature overview
- Number of user stories and effort estimate
- Key findings and concerns
- Next steps (Phase 2: Design)

**Valid responses:**
- `approve` → AUTO-CONTINUE to Phase 2
- `reject: [reason]` → Restart with feedback
- `modify: [changes]` → Adjust deliverables
- `clarify: [questions]` → Answer questions, then re-present

## Auto-Continue Behavior
After user approves, IMMEDIATELY proceed to Phase 2 (Design) without waiting for additional input. Show agent banner for Phase 2 and begin technical design.

## Quality Gates
**Must Pass:**
- All acceptance criteria are testable
- No ambiguous requirements
- All dependencies identified
- Risks documented with mitigations
- User approved requirements

**Should Pass:**
- Success metrics defined
- Timeline estimated
- Edge cases documented
- Cross-review complete

## Token Awareness
- **Typical usage**: 15-35K tokens (~25K average)
- **Cumulative**: 25K / 200K (12.5%)
- Display token usage at approval gate

## Common Mistakes to Avoid
- Skipping clarification questions
- Accepting vague acceptance criteria
- Ignoring edge cases
- Missing dependencies
- Proceeding without approval
- Making technical decisions (save for Phase 2)
- Skipping cross-review process

## References
- Project context: `.cursor/project-contexts/[project]/`
- Related phases: Phase 2 (Design)
- Templates: `~/.cursor/plugins/marketplaces/aurafrog/aura-frog/templates/requirements-doc.md`
- Rules: `.cursor/rules/core/cross-review.mdc`
- Skills: `jira-integration`, `project-context-loader`
