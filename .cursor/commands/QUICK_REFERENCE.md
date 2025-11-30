# Aura Frog Commands - Quick Reference

**70 Commands Organized by Category**

---

## 🚀 Getting Started

```bash
# 1. Initialize (required first step)
/project:init

# 2. Start a workflow
/workflow:start "Your task description"

# 3. Check status
/workflow:status

# 4. Approve phase
/workflow:approve
```

---

## 📋 Workflow (18 commands)

### Core Workflow
- `/workflow:start` - Start 9-phase workflow
- `/workflow:status` - Show current status
- `/workflow:approve` - Approve and continue
- `/workflow:reject` - Reject and request changes
- `/workflow:modify` - Modify current work

### Multi-Session
- `/workflow:handoff` - Save state (at 150K+ tokens)
- `/workflow:resume` - Continue in new session

### Monitoring
- `/workflow:progress` - Timeline view
- `/workflow:metrics` - Performance metrics
- `/workflow:tokens` - Token usage
- `/workflow:budget` - Token budget
- `/workflow:predict` - ETA prediction

### Individual Phases
- `/workflow:phase-1` - Requirements Analysis
- `/workflow:phase-2` - Technical Planning
- `/workflow:phase-3` - Design/UI Breakdown
- `/workflow:phase-4` - Test Planning
- `/workflow:phase-5a` - TDD RED (Write Tests)
- `/workflow:phase-5b` - TDD GREEN (Implement)
- `/workflow:phase-5c` - TDD REFACTOR (Optimize)
- `/workflow:phase-6` - Code Review
- `/workflow:phase-7` - QA Validation
- `/workflow:phase-8` - Documentation
- `/workflow:phase-9` - Team Notification

---

## 🐛 Bug Fix (3 commands)

- `/bugfix:quick` - Fast fix (auto-approve Phase 1-2)
- `/bugfix:fix` - Standard bug fix workflow
- `/bugfix:hotfix` - Emergency production fix

---

## 🧪 Testing (4 commands)

- `/test:unit` - Generate unit tests
- `/test:e2e` - Create end-to-end tests
- `/test:coverage` - Check test coverage
- `/test:document` - Generate test docs

---

## ✅ Quality (3 commands)

- `/quality:check` - Run linter, formatter, types
- `/quality:debt` - Analyze technical debt
- `/quality:complexity` - Measure code complexity

---

## 🔒 Security (3 commands)

- `/security:scan` - Vulnerability scan
- `/security:audit` - Complete security audit
- `/security:deps` - Check dependencies

---

## 🚀 Deploy (3 commands)

- `/deploy:setup` - Setup deployment
- `/deploy:docker-create` - Create Docker config
- `/deploy:cicd-create` - Generate CI/CD pipeline

---

## 📦 Project (5 commands)

- `/project:init` - Initialize Aura Frog ⭐
- `/project:detect` - Detect project type
- `/project:regen` - Regenerate context
- `/project:list` - List projects
- `/project:switch` - Switch projects

---

## 🤖 Agent (4 commands)

- `/agent:list` - List all 24 agents
- `/agent:info` - Show agent details
- `/agent:activate` - Activate agent manually
- `/agent:deactivate` - Deactivate agent

---

## 📋 Planning (3 commands)

- `/planning:plan` - Create development plan
- `/planning:refine` - Refine existing plan
- `/planning:list` - List all plans

---

## ⚙️ Setup (2 commands)

- `/setup:activate` - Activate Aura Frog
- `/setup:integrations` - Configure JIRA, Slack, Figma

---

## 🎨 Performance (4 commands)

- `/perf:analyze` - Analyze performance
- `/perf:optimize` - Optimize performance
- `/perf:bundle` - Analyze bundle size
- `/perf:lighthouse` - Run Lighthouse audit

---

## 🔧 API (2 commands)

- `/api:design` - Design API endpoints
- `/api:test` - Test API endpoints

---

## 🗄️ Database (2 commands)

- `/db:design` - Design database schema
- `/db:optimize` - Optimize queries

---

## 📊 Monitor (2 commands)

- `/monitor:setup` - Setup error monitoring
- `/monitor:errors` - Analyze error logs

---

## 📝 Other Commands

### Logs (1)
- `/logs:analyze` - Analyze application logs

### Review (1)
- `/review:fix` - Fix code review issues

### Skill (1)
- `/skill:create` - Create custom skill

### Misc (4)
- `/misc:document` - Generate documentation
- `/misc:refactor` - Refactor code
- `/misc:help` - Show help
- `/misc:execute` - Execute custom command

---

## 🔥 Most Used Commands

1. `/project:init` - Initialize (required first time)
2. `/workflow:start` - Start any task
3. `/workflow:status` - Check progress
4. `/workflow:approve` - Continue workflow
5. `/bugfix:quick` - Fast bug fixes
6. `/test:unit` - Add tests
7. `/workflow:handoff` - Save long workflows
8. `/workflow:resume` - Continue workflows

---

## 💡 Common Patterns

### New Feature
```bash
/workflow:start "Add user profile screen"
```

### Bug Fix
```bash
/bugfix:quick "Fix button disabled state"
```

### Refactoring
```bash
/misc:refactor src/components/LargeComponent.tsx
```

### Add Tests
```bash
/test:unit src/Component.tsx --coverage=85
```

### Multi-Session Workflow
```bash
# Session 1
/workflow:start "Large feature"
# ... work work work ...
/workflow:handoff

# Session 2
/workflow:resume {workflow-id}
```

---

## 📊 Token Management

- **Total:** 200,000 tokens/session
- **Warning:** 150,000 tokens (75%)
- **Action:** Use `/workflow:handoff`

---

## 🎯 Integration Setup

In `.envrc`:
```bash
# JIRA
export JIRA_URL="https://company.atlassian.net"
export JIRA_EMAIL="your@email.com"
export JIRA_API_TOKEN="token"

# Figma
export FIGMA_ACCESS_TOKEN="figd_token"

# Slack
export SLACK_BOT_TOKEN="xoxb-token"
export SLACK_CHANNEL_ID="C123"
```

---

**Need help?** Run `/misc:help`
