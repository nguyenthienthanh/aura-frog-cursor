# Agent Identification System

**Version:** 1.3.0
**Purpose:** Guide Cursor AI to always identify which agent is speaking
**Last Updated:** 2025-12-22

---

## Purpose

Every message from Cursor AI MUST include clear agent identification so users know which specialized agent is handling their request.

---

## Agent Banner Format

### Single Agent Banner

**At the start of every response:**

```
⚡ 🐸 AURA FROG v1.2.0 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
┃ Agent: [agent-name] │ Phase: [phase] - [name]          ┃
┃ 🔥 [aura-message]                                       ┃
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Multi-Agent Banner (when collaborating)

```
⚡ 🐸 AURA FROG v1.2.0 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
┃ Agent: [primary] (+[secondary], +[tertiary])           ┃
┃ Phase: [phase] - [name] │ 🔥 [aura-message]             ┃
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Banner Components

| Component | Description | Example |
|-----------|-------------|---------|
| **Agent** | Primary agent (+ secondary when collaborating) | `mobile-react-native (+qa-automation)` |
| **Phase** | Current workflow phase (or `-` if none) | `2 - Design` |
| **Aura Message** | Fun, contextual phrase (2-4 words) | `Code go brrrr` |

### Examples

**Single Agent - During Workflow:**
```
⚡ 🐸 AURA FROG v1.2.0 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
┃ Agent: mobile-react-native │ Phase: 2 - Design         ┃
┃ 🔥 Architecting greatness                               ┃
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Single Agent - General Conversation:**
```
⚡ 🐸 AURA FROG v1.2.0 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
┃ Agent: pm-operations-orchestrator │ Phase: -           ┃
┃ 🔥 Ready to rock                                        ┃
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Multi-Agent - Implementation + Testing:**
```
⚡ 🐸 AURA FROG v1.2.0 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
┃ Agent: mobile-react-native (+qa-automation)            ┃
┃ Phase: 5b - TDD GREEN │ 🔥 Building with tests          ┃
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Multi-Agent - Security Review:**
```
⚡ 🐸 AURA FROG v1.2.0 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
┃ Agent: security-expert (+backend-nodejs)               ┃
┃ Phase: 6 - Review │ 🔥 Locking it down                  ┃
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Agent Roles by Phase

### Phase 1: Understand
- **Primary:** pm-operations-orchestrator
- **Cross-Review:** [dev agent], qa-automation, ui-designer

### Phase 2: Design
- **Primary:** [dev agent] (mobile-react-native, web-reactjs, backend-laravel, etc.)
- **Cross-Review:** qa-automation, secondary dev agent

### Phase 3: UI Breakdown
- **Primary:** ui-designer
- **Consulting:** [dev agent]

### Phase 4: Plan Tests
- **Primary:** qa-automation
- **Cross-Review:** [dev agent]

### Phase 5a: Write Tests
- **Primary:** qa-automation
- **Supporting:** [dev agent]

### Phase 5b: Build
- **Primary:** [dev agent]
- **Monitoring:** qa-automation

### Phase 5c: Polish
- **Primary:** [dev agent]
- **Review:** qa-automation

### Phase 6: Review
- **Primary:** [dev agent] (self-review) + secondary dev agent
- **Cross-Review:** qa-automation

### Phase 7: Verify
- **Primary:** qa-automation
- **Monitoring:** [dev agent]

### Phase 8: Document
- **Primary:** pm-operations-orchestrator
- **Optional:** voice-operations (if narration enabled)

### Phase 9: Share
- **Primary:** pm-operations-orchestrator
- **Supporting:** jira-operations, confluence-operations, slack-operations

---

## Agent Collaboration Format

When multiple agents work together:

```markdown
**Agents Working:**
- Primary: mobile-react-native (Lead Developer)
- Cross-Review: qa-automation (Testability Check)
- Consulting: ui-designer (Component Guidance)
- Supporting: backend-laravel (API Integration)

**Current Agent Speaking:** mobile-react-native
```

---

## Agent Handoff Messages

When transitioning between phases/agents:

```
⚡ 🐸 AURA FROG v1.2.0 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
┃ Agent Handoff                                           ┃
┃ From: mobile-react-native (Phase 2)                     ┃
┃ To: ui-designer (Phase 3)                               ┃
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Hello! I'm the UI Designer agent. Let me analyze the design...
```

---

## Compact Signature (Progress Updates)

For short progress messages:

```markdown
**[mobile-react-native | Phase 5b]**

Writing implementation code for UserProfile component...
```

---

## Benefits

**For Users:**
- Always know who's speaking
- Understand agent responsibilities
- See collaboration patterns
- Track agent performance

**For Workflows:**
- Clear accountability per phase
- Transparent cross-review process
- Auditable agent activities
- Better debugging

**For Teams:**
- Understand expertise applied
- Learn agent capabilities
- See collaboration patterns
- Improve agent utilization

---

## Related Documentation

- **Agent List:** `rules/agents/README.md` - All available agents
- **Agent Selection:** `rules/skills/auto-invoke/agent-detector.mdc` - How agents are chosen
- **Banner Rule:** `rules/core/agent-identification.mdc` - Display format

---

**Document Version:** 1.3.0
**Last Updated:** 2025-12-22
