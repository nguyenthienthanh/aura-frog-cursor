# /workflow:start - Initialize and Start 9-Phase Workflow

## Description

Starts a complete 9-phase Aura Frog workflow for any development task. This is the primary entry point for structured, TDD-driven development with automatic project context loading, agent orchestration, and approval gates.

The workflow includes:
- Phase 1: Requirements Analysis
- Phase 2: Technical Planning
- Phase 3: Design/UI Breakdown
- Phase 4: Test Planning
- Phase 5: TDD Implementation (RED → GREEN → REFACTOR)
- Phase 6: Code Review
- Phase 7: QA Validation
- Phase 8: Documentation
- Phase 9: Team Notification

## Usage

```
/workflow:start "<task-description>"
```

## Arguments

- `<task-description>` - Description of the task to implement (required)

## Execution Steps

1. **Initialize Workflow**
   - Generate unique workflow ID
   - Create workflow state file in `.cursor/logs/workflows/{workflow-id}/`
   - Load project context from `.cursor/project-contexts/[project]/`

2. **Detect and Activate Agents**
   - Analyze task description for keywords
   - Auto-select appropriate agents (mobile, web, backend, etc.)
   - Always activate: pm-operations-orchestrator, project-context-manager

3. **Execute Phase 1: Requirements Analysis**
   - Analyze requirements
   - Identify issues and strategy
   - Create success criteria
   - Estimate effort and risk
   - Generate deliverable: `PHASE_1_REQUIREMENTS_ANALYSIS.md`

4. **Show Approval Gate**
   - Present Phase 1 results
   - Wait for user approval, rejection, or modification
   - Options: `/workflow:approve`, `/workflow:reject`, `/workflow:modify`

## Examples

### Example 1: Add New Feature
```
/workflow:start "Implement user authentication with JWT"
```
Starts a full workflow to implement authentication from requirements through deployment.

### Example 2: Refactor Component
```
/workflow:start "Refactor UserProfile component - split into smaller pieces"
```
Analyzes component, plans refactoring strategy, implements with TDD.

### Example 3: Fix Bug
```
/workflow:start "Fix bug in payment processing API - orders not completing"
```
Analyzes bug, creates fix strategy, implements with tests.

## References

- Related commands: `/workflow:status`, `/workflow:approve`, `/workflow:handoff`
- Project context: `.cursor/project-contexts/[project]/project-config.yaml`
- Workflow state: `.cursor/logs/workflows/{workflow-id}/workflow-state.json`
- Skills: `.cursor/rules/skills/auto-invoke/workflow-orchestrator.mdc`

## Notes

**Key Features:**
- **Automatic Project Context Loading** - Uses your project conventions, tech stack, and patterns
- **Agent Auto-Selection** - Picks the right specialized agents for your task
- **TDD Enforcement** - Phases 5a-5c enforce Test-Driven Development
- **Approval Gates** - Review and approve each phase before proceeding
- **Token Management** - Tracks usage, suggests handoff at 75%
- **Integration Support** - JIRA, Figma, Slack integration when configured

**First Time Setup:**
If you haven't initialized Aura Frog for your project yet, run `/project:init` first to create project context.

**Workflow Recovery:**
- Use `/workflow:handoff` when approaching token limit (>150K/200K)
- Use `/workflow:resume {workflow-id}` to continue in new session

---

**Source:** Aura Frog v1.1.4
**Converted:** 2025-11-30
