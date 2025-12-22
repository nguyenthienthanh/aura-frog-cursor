# Phase 9: Share (Notification & Archive)

## Purpose
Notify stakeholders, update project management tools, share knowledge, and archive workflow for future reference.

## Prerequisites
- Phase 8 (Document) completed and approved
- All documentation complete
- Feature fully implemented and tested
- Ready for deployment or deployed

## Inputs
- All phase deliverables (1-8)
- Implementation summary
- Test results
- Deployment guide
- Workflow state

## Execution Steps

### 1. JIRA Update (10 min)
If JIRA integration enabled:
```bash
# Update ticket status
# Add implementation summary
# Link to PR/branch
# Update story points (actual vs estimated)
# Add completion date
```

Updates:
- Status: In Progress → Done
- Add comment with implementation summary
- Attach key documents
- Update time tracking

### 2. Pull Request / Merge (15 min)
Create PR if not already created:
- Title: Feature name from Phase 1
- Description: Implementation summary
- Link to JIRA ticket
- List all changes
- Tag reviewers
- Add screenshots (if UI changes)

### 3. Slack Notification (5 min)
If Slack integration enabled:
```bash
# Post to relevant channel
# Include feature summary
# Link to PR
# Mention stakeholders
```

Message format:
```
🎉 Feature Complete: Social Media Sharing

✅ All acceptance criteria met
✅ Test coverage: 89%
✅ Code reviewed and approved
✅ Documentation complete

📋 JIRA: PROJ-1234
🔗 PR: #456
📚 Docs: [Link]

@product-team @qa-team
```

### 4. Confluence Update (10 min)
If Confluence integration enabled:
- Create feature page
- Add implementation summary
- Link to technical docs
- Add to release notes
- Update architecture docs

### 5. Knowledge Sharing (15 min)
Share learnings:
- What worked well
- What didn't work
- Lessons learned
- Best practices discovered
- Gotchas to avoid

Optional: Create knowledge base article.

### 6. Workflow Archive (5 min)
Archive workflow state:
```bash
# Save workflow state
# Archive deliverables
# Create handoff document (if needed)
# Store in logs directory
```

Location: `.cursor/logs/workflows/[workflow-id]/`

### 7. Metrics Collection (5 min)
Record metrics:
- Total time: Start to finish
- Token usage: Total consumed
- Test coverage: Final percentage
- Lines of code: Added/modified
- Story points: Estimated vs actual
- Phases completed: 9/9

### 8. Celebration (1 min)
Mark workflow as complete! 🎉

## Deliverables
- JIRA ticket updated (status: Done)
- Pull request created (if not already)
- Slack notification sent
- Confluence page created/updated
- Knowledge sharing article (optional)
- Workflow archive (`logs/workflows/[id]/`)
- Metrics report
- Workflow complete confirmation

**Completion Report Format:**
```markdown
# 🎉 Workflow Complete: Social Media Sharing

## Summary
Successfully implemented social media sharing feature with
Facebook and Instagram integration.

## Metrics
- Duration: 11 days (Estimated: 11 days) ✅
- Story Points: 34 (Estimated: 34) ✅
- Test Coverage: 89% (Goal: 80%) ✅
- Token Usage: 345K / 200K (173%) ⚠️ (Used handoff)

## Phase Breakdown
1. Understand: 30 min ✅
2. Design: 45 min ✅
3. UI: 35 min ✅
4. Test Planning: 40 min ✅
5a. TDD RED: 3 hours ✅
5b. TDD GREEN: 5 hours ✅
5c. TDD REFACTOR: 2 hours ✅
6. Review: 45 min ✅
7. Verify: 30 min ✅
8. Document: 1 hour ✅
9. Share: 30 min ✅

## Deliverables
✅ Requirements Analysis
✅ Technical Design
✅ UI Breakdown
✅ Test Plan
✅ Implementation (53 tests, all passing)
✅ Code Review
✅ QA Validation
✅ Documentation
✅ JIRA Updated
✅ PR Created
✅ Team Notified

## Links
- JIRA: PROJ-1234
- PR: #456
- Branch: feature/social-sharing
- Docs: /docs/features/social-sharing
- Workflow: logs/workflows/social-sharing-20251124-120000

## Lessons Learned
1. Native SDKs provide better UX than web URLs
2. Image compression saved significant bandwidth
3. TDD caught 8 edge case bugs early

## Next Steps
- Merge PR (requires 2 approvals)
- Deploy to staging
- QA regression test
- Deploy to production
- Monitor metrics

---

🙌 Great work team! Feature shipped successfully.
```

## Approval Gate
**SPECIAL:** This phase AUTO-EXECUTES after Phase 8 approval.

No additional approval needed for:
- JIRA updates
- Slack notifications
- Confluence updates
- Workflow archival

**User notification only** (no approval required):
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎉 WORKFLOW COMPLETE: Social Media Sharing
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

All 9 phases completed successfully!

📋 JIRA: Updated (PROJ-1234 → Done)
🔗 PR: Created (#456)
💬 Slack: Team notified
📚 Docs: Published
💾 Workflow: Archived

Next: Merge PR and deploy!

[View Completion Report]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Auto-Continue Behavior
**This is the FINAL phase.** No auto-continue.

Workflow ends here. User can:
- Start new workflow: `workflow:start "Next feature"`
- View metrics: `workflow:metrics`
- View archive: `workflow:history`

## Quality Gates
**Must Complete:**
- Workflow state archived
- Metrics collected

**Should Complete:**
- JIRA updated (if enabled)
- Slack notified (if enabled)
- Confluence updated (if enabled)
- PR created

## Token Awareness
- **Typical usage**: 3-10K tokens (~5K average)
- **Cumulative**: ~345K / 200K (172.5%) - **EXCEEDS LIMIT!**
- **Final total**: Track for future workflow planning

## Common Mistakes to Avoid
- Forgetting to update JIRA
- Not notifying stakeholders
- Missing PR description
- Not archiving workflow
- Forgetting to celebrate! 🎉

## MCP Integrations

All integrations use MCP servers (configured in `.cursor/mcp.json`).

### JIRA Update

Use `atlassian` MCP server:
- Tool: `jira_update_issue`
- Updates ticket status and adds comment

### Slack Notification

Use `slack` MCP server:
- Tool: `slack_post_message`
- Sends completion notification to channel

### Confluence Update

Use `atlassian` MCP server:
- Tool: `confluence_create_page`
- Creates documentation page in specified space

**Note:** Enable MCP servers in `.cursor/mcp.json` and add credentials to `.envrc`.

## Workflow Archive Structure
```
.cursor/logs/workflows/[workflow-id]/
├── workflow-state.json
├── deliverables/
│   ├── 01-requirements-analysis/
│   ├── 02-technical-planning/
│   ├── 03-design-review/
│   ├── 04-test-planning/
│   ├── 05-implementation/
│   ├── 06-code-review/
│   ├── 07-qa-validation/
│   ├── 08-documentation/
│   └── 09-notification/
├── execution.log
├── tokens.log
├── metrics.json
└── COMPLETION_REPORT.md
```

## Metrics Tracked
```json
{
  "workflow_id": "social-sharing-20251124-120000",
  "duration_total_ms": 950400000,
  "duration_total_hours": 11,
  "token_usage_total": 345000,
  "phases_completed": 9,
  "story_points_estimated": 34,
  "story_points_actual": 34,
  "test_coverage": 89,
  "tests_total": 53,
  "lines_added": 420,
  "lines_removed": 20,
  "bugs_found": 0,
  "completed_at": "2025-11-24T18:30:00Z"
}
```

## References
- Project context: `.cursor/project-contexts/[project]/`
- Related phases: Phase 8 (Document)
- Integration setup: `~/.cursor/plugins/marketplaces/aurafrog/aura-frog/docs/INTEGRATION_SETUP_GUIDE.md`
- Scripts: `~/.cursor/plugins/marketplaces/aurafrog/aura-frog/scripts/`
