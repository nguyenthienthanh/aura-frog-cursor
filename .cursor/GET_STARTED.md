# Getting Started with Aura Frog in Cursor IDE

⚡ 🐸 **Welcome to Aura Frog** - Code with main character energy in Cursor IDE!

---

## 📖 Quick Start (5 Minutes)

### Step 1: Install Aura Frog

**Option A: Using Setup Script (Recommended)**

```bash
# Clone the repository
git clone https://github.com/nguyenthienthanh/aura-frog-cursor.git

# Run setup script
./aura-frog-cursor/setup.sh /path/to/your/project
```

The setup script will:
- Copy `.cursor` folder to your project
- Create `.cursor/.envrc` from template
- Prompt for JIRA and Figma credentials (optional)
- Add `.cursor/.envrc` to `.gitignore`

**Option B: Manual Installation**

```bash
# Copy .cursor folder to your project
cp -r aura-frog-cursor/.cursor /path/to/your/project/
cp aura-frog-cursor/.cursorrules /path/to/your/project/
```

### Step 2: Verify Installation

Check that all files are in place:

```bash
# From your project root
ls .cursor/

# You should see:
# - AGENTS.md
# - rules/ (with core/, agents/, skills/, hooks/, templates/)
# - commands/ (with workflow/, bugfix/, test/, etc.)
# - workflows/ (with phases/)
# - scripts/
# - project-contexts/
# - Documentation files
```

### Step 3: Initialize Project

Run the project initialization command:

```bash
/project:init
```

This will:
- Detect your tech stack (React Native, etc.)
- Create project context in `.cursor/project-contexts/[project]/`
- Extract conventions from your codebase
- Generate project-specific rules
- Set up directory structure

### Step 4: Review Generated Context

```bash
cat .cursor/project-contexts/[project]/conventions.md
```

This file contains your project's:
- File naming patterns
- Directory structure
- Import conventions
- Code style preferences

**Important:** Review and edit if needed! This is how Aura Frog learns YOUR patterns.

### Step 5: Start Your First Workflow

```bash
/workflow:start "Add dark mode toggle to settings"
```

Aura Frog will:
1. Detect the best agent (mobile-react-native for this project)
2. Load your project conventions
3. Start Phase 1: Requirements Analysis
4. Guide you through all 9 phases
5. Ask for approval at each step

That's it! You're ready to build with Aura Frog. 🎉

---

## 🎯 Understanding the System

### The 9-Phase Workflow

Aura Frog uses a structured TDD (Test-Driven Development) workflow:

```
┌─────────────────────────────────────────────┐
│  PLANNING & PREPARATION (Phases 1-4)        │
│  ◆ Understand → Design (+Diagrams) → UI →  │
│    Plan Tests                               │
│  ⏱️ 2-3 hours │ 📊 ~135K tokens             │
└─────────────────────────────────────────────┘
           ↓
┌─────────────────────────────────────────────┐
│  BUILD & POLISH (Phase 5)                   │
│  ◆ RED (Tests) → GREEN (Code) → REFACTOR   │
│  ⏱️ 5-9 hours │ 📊 ~130K tokens             │
└─────────────────────────────────────────────┘
           ↓
┌─────────────────────────────────────────────┐
│  REVIEW & VERIFY (Phases 6-7)               │
│  ◆ Code Review → QA Validation             │
│  ⏱️ 1-2 hours │ 📊 ~55K tokens              │
└─────────────────────────────────────────────┘
           ↓
┌─────────────────────────────────────────────┐
│  DOCUMENT & SHARE (Phases 8-9)              │
│  ◆ Documentation → Notifications            │
│  ⏱️ 1-2 hours │ 📊 ~25K tokens              │
└─────────────────────────────────────────────┘
```

**Total:** ~345K tokens (exceeds 200K limit!)

**Solution:** Use handoff/resume for multi-session workflows.

### Agent Identification Banner

Every response shows (single or multi-agent):

**Single Agent:**
```
⚡ 🐸 AURA FROG v1.1.5 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
┃ Agent: mobile-react-native │ Phase: 2 - Design         ┃
┃ 🔥 Code go brrrr                                        ┃
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Multiple Agents (collaboration):**
```
⚡ 🐸 AURA FROG v1.1.5 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
┃ Agent: mobile-react-native (+qa-automation)            ┃
┃ Phase: 5b - TDD GREEN │ 🔥 Building with tests          ┃
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

- **Agent:** Primary agent (+ secondary agents when collaborating)
- **Phase:** Workflow phase (or `-` if none)
- **Aura Message:** Fun, contextual phrase (changes each time)

### 24 Specialized Agents

Aura Frog has 24 specialized agents that auto-activate based on context:

**Development (11):**
- mobile-react-native, mobile-flutter
- web-angular, web-vuejs, web-reactjs, web-nextjs
- backend-nodejs, backend-python, backend-go, backend-laravel
- database-specialist

**Quality & Security (3):**
- security-expert, qa-automation, ui-designer

**DevOps & Operations (5):**
- devops-cicd, jira-operations, confluence-operations
- slack-operations, voice-operations

**Infrastructure (5):**
- agent-detector (ALWAYS active - selects other agents)
- pm-operations-orchestrator, project-detector
- project-config-loader, project-context-manager

**Auto-Selection:** The `agent-detector` analyzes your message and files to pick the best agent automatically.

---

## 🚀 Common Tasks

### Starting a New Feature

```bash
# Full 9-phase workflow
/workflow:start "Implement user profile editing"

# The system will:
# 1. Select appropriate agent
# 2. Load project context
# 3. Guide through phases
# 4. Create Mermaid diagrams (Phase 2):
#    - Sequence diagram (API flow)
#    - ERD (database changes)
#    - Architecture diagram (if multi-service)
# 5. Request approval at each step
# 6. Auto-continue after approval
```

### Quick Bug Fix

```bash
# Skip early phases for urgent fixes
/bugfix:quick "Login button disabled after password change"

# Faster workflow:
# - Auto-approves Phase 1-2 (minimal requirements)
# - Still enforces TDD (Phase 5)
# - Still requires code review (Phase 6-7)
```

### Adding Tests

```bash
# Add unit tests to existing code
/test:unit src/components/LoginButton.tsx

# Add E2E tests
/test:e2e "user authentication flow"

# Check coverage
/test:coverage
```

### Code Quality Checks

```bash
# Run quality analysis
/quality:check

# Analyze technical debt
/quality:debt

# Check complexity
/quality:complexity
```

### Security Audits

```bash
# Security scan
/security:scan

# Dependency audit
/security:deps

# Full security audit
/security:audit
```

### Refactoring

```bash
# Refactor with full workflow
/misc:refactor src/screens/ProfileScreen.tsx

# The system will:
# - Analyze current code
# - Suggest refactoring approach
# - Write tests first (TDD)
# - Refactor safely
# - Verify tests still pass
```

---

## 🔄 Multi-Session Workflows

### The Challenge

Cursor has a 200K token limit per session. Complex workflows can exceed this.

**Example:**
- Phase 1-4: ~135K tokens
- Phase 5: ~130K tokens
- **Total: 265K tokens** ❌ Exceeds limit!

### The Solution: Handoff & Resume

**Step 1: Monitor Tokens**

The system shows token usage at each phase:

```
📊 Token Usage: ~152K / 200K (76%)
⚠️ Warning: Approaching token limit
```

**Step 2: Save State (Handoff)**

When reaching ~150K tokens:

```bash
/workflow:handoff
```

This saves:
- Complete workflow state
- All phase artifacts
- Current context
- To: `.cursor/workflow-contexts/[workflow-id]/`

**Step 3: Continue in New Session (Resume)**

Open a new Cursor session and run:

```bash
/workflow:resume {workflow-id}

# Example:
/workflow:resume user-profile-editing-20251130-143000
```

Aura Frog will:
- Restore complete workflow state
- Load all artifacts
- Continue from where you left off
- Seamlessly proceed through remaining phases

**Best Practice:**
- Handoff after Phase 4 (~135K tokens)
- Continue Phase 5-9 in new session (~130K tokens)

---

## ⚙️ Configuration

### Project Context

Located at: `.cursor/project-contexts/[project]/`

**Files:**

1. **`project-config.yaml`** - Tech stack configuration
```yaml
project:
  name: "[your-project-name]"
  type: "[project-type]"
  tech_stack:
    platform: "[Platform]"
    language: "[Language]"
    ui: "[UI Framework]"
    state: "[State Management]"
```

2. **`conventions.md`** - Naming and structure patterns
```markdown
# File Naming Conventions
- Components: PascalCase (e.g., Button.tsx)
- Hooks: camelCase with "use" prefix (e.g., useAuth.ts)
- Utilities: camelCase (e.g., formatDate.ts)

# Directory Structure
src/
├── components/    # Reusable components
├── screens/       # Screen components
├── hooks/         # Custom hooks
└── utils/         # Utility functions
```

3. **`rules.md`** - Project-specific quality rules
```markdown
# Project Rules
- Always use TypeScript strict mode
- Minimum test coverage: 80%
- All components must be tested
- Use ESLint and Prettier
```

4. **`examples.md`** - Code examples
```markdown
# Component Example
```typescript
export const Button: React.FC<ButtonProps> = ({ title, onPress }) => {
  return (
    <Pressable onPress={onPress}>
      <Text>{title}</Text>
    </Pressable>
  );
};
```
```

**Customization:**

Edit these files to teach Aura Frog YOUR patterns. The system will:
- Follow YOUR naming conventions
- Match YOUR code style
- Respect YOUR quality standards
- Use YOUR examples as templates

**Priority:**
```
Project Context > Aura Frog Rules > Generic Defaults
```

### Integrations (Optional)

Configure JIRA, Figma, Slack, Confluence:

```bash
/setup:integrations
```

This guides you through setting up:
- JIRA ticket fetching
- Figma design extraction
- Slack notifications
- Confluence documentation

**Environment Variables (`.cursor/.envrc`):**

```bash
# JIRA (same Atlassian credentials work for Confluence)
export JIRA_URL="https://company.atlassian.net"
export JIRA_EMAIL="user@company.com"
export JIRA_API_TOKEN="your-token"

# Figma
export FIGMA_ACCESS_TOKEN="your-token"

# Slack
export SLACK_WEBHOOK_URL="https://hooks.slack.com/..."

# Confluence (optional - defaults to JIRA credentials)
# export CONFLUENCE_URL="https://company.atlassian.net/wiki"
# export CONFLUENCE_EMAIL="user@company.com"
# export CONFLUENCE_API_TOKEN="your-token"
```

**Note:** Confluence uses the same Atlassian account as JIRA, so JIRA credentials work for both.

Then you can:

```bash
# Fetch JIRA ticket
/workflow:start "PROJ-1234"
# Auto-fetches ticket details!

# Extract Figma design
/workflow:start "Implement https://figma.com/file/ABC123..."
# Auto-extracts design tokens!
```

---

## 📚 Available Commands

### Workflow Commands (18)

```bash
/workflow:start "task"       # Initialize 9-phase workflow
/workflow:status             # Show current progress
/workflow:approve            # Approve current phase
/workflow:reject "reason"    # Reject and provide feedback
/workflow:modify "changes"   # Request modifications
/workflow:stop               # Stop workflow
/workflow:handoff            # Save state (multi-session)
/workflow:resume {id}        # Continue workflow
/workflow:skip-phase         # Skip current phase (if allowed)
/workflow:restart            # Restart workflow
/workflow:tokens             # Show token usage
/workflow:logs               # View workflow logs
/workflow:list               # List all workflows
/workflow:cleanup            # Clean old workflows
/workflow:export             # Export workflow report
/workflow:validate           # Validate workflow state
/workflow:back               # Go back to previous phase
/workflow:context            # Show current context
```

### Quick Commands (10)

```bash
/bugfix:quick "desc"         # Fast bug fix
/bugfix:standard "desc"      # Standard bug fix
/bugfix:hotfix "desc"        # Critical hotfix
/test:unit {file}            # Add unit tests
/test:e2e "flow"             # Add E2E tests
/test:coverage               # Check test coverage
/test:document               # Document tests
/misc:refactor {file}        # Refactor code
/misc:document "type" "name" # Generate documentation
/misc:help                   # Show help
```

### Project & Agent Commands (9)

```bash
/project:init                # Initialize project
/project:detect              # Detect project type
/project:config              # Show configuration
/project:list                # List projects
/project:switch "name"       # Switch project
/agent:list                  # List all agents
/agent:info "name"           # Show agent details
/agent:activate "name"       # Activate agent
/agent:deactivate            # Deactivate current
```

### Quality, Security, Deploy (9)

```bash
/quality:check               # Quality analysis
/quality:debt                # Technical debt
/quality:complexity          # Complexity metrics
/security:scan               # Security scan
/security:audit              # Full audit
/security:deps               # Dependency check
/deploy:setup                # Deploy setup
/deploy:docker-create        # Create Dockerfile
/deploy:cicd-create          # Create CI/CD
```

**See all:** `/misc:help` or check `.cursor/commands/QUICK_REFERENCE.md`

---

## 🎓 Learning More

### Documentation Files

Start here:
1. **`GET_STARTED.md`** - This file (you are here!)
2. **`QUICK_REFERENCE.md`** - Command cheat sheet
3. **`MASTER_CONVERSION_REPORT.md`** - Complete system overview

Dive deeper:
4. **`AGENTS.md`** - Main AI instructions
5. **`workflows/QUICK_REFERENCE.md`** - Workflow guide
6. **`commands/README.md`** - All commands
7. **`rules/core/README.md`** - Quality rules

Advanced:
8. **`workflows/STATE_MANAGEMENT.md`** - Multi-session workflows
9. **`CONVERSION_ARCHITECTURE.md`** - System design
10. **`MIGRATION_FROM_CLAUDE.md`** - If migrating from Claude Code

### Example Workflows

**Feature Implementation:**
```bash
# 1. Start workflow
/workflow:start "Add dark mode support"

# 2. System guides through phases:
#    Phase 1: Requirements (auto-continues after approval)
#    Phase 2: Design (auto-continues after approval)
#    ...
#    Phase 9: Share

# 3. If token limit approaching (at ~150K):
/workflow:handoff

# 4. In new session:
/workflow:resume dark-mode-support-20251130-100000
```

**Bug Fix:**
```bash
# 1. Quick fix
/bugfix:quick "App crashes when user logs out"

# 2. System:
#    - Auto-approves early phases
#    - Still enforces TDD
#    - Still requires review
#    - Faster turnaround
```

**Code Review:**
```bash
# 1. After implementation
/review:fix

# 2. System:
#    - Loads code-reviewer skill
#    - Checks security
#    - Checks performance
#    - Checks quality
#    - Provides feedback
```

---

## 🐛 Troubleshooting

### "Agent not activating correctly"

**Solution:**
```bash
# Manually activate agent
/agent:activate "mobile-react-native"

# Or check detection logic
/agent:info "mobile-react-native"
```

### "Token limit exceeded"

**Solution:**
```bash
# Save and resume in new session
/workflow:handoff

# In new Cursor session:
/workflow:resume {workflow-id}
```

### "Project context not loading"

**Solution:**
```bash
# Reinitialize project
/project:init

# Or manually check
cat .cursor/project-contexts/[project]/conventions.md
```

### "Command not found"

**Solution:**
```bash
# Check available commands
/misc:help

# Or check documentation
cat .cursor/commands/README.md
```

### "Workflow stuck"

**Solution:**
```bash
# Check status
/workflow:status

# View logs
/workflow:logs

# Restart if needed
/workflow:restart
```

---

## 💡 Pro Tips

### 1. Use Project Context

Always run `/project:init` first! It teaches Aura Frog YOUR patterns.

### 2. Review Before Approving

Each phase shows deliverables. Review them carefully before approving.

### 3. Modify, Don't Reject

If close but not perfect:
```bash
/workflow:modify "Change API endpoint from /users to /api/users"
```

Instead of rejecting and starting over.

### 4. Token Awareness

Watch token usage. Handoff at ~150K to avoid hitting limit.

### 5. Use Quick Commands

For simple tasks, use quick commands:
- `/bugfix:quick` for bugs
- `/test:unit` for tests
- `/misc:refactor` for refactoring

No need for full 9-phase workflow every time!

### 6. Integrate Tools

Connect JIRA, Figma for seamless workflows:
```bash
/workflow:start "PROJ-1234"
# Auto-fetches ticket details!
```

### 7. Customize Examples

Edit `.cursor/project-contexts/[project]/examples.md` with YOUR code examples. Aura Frog will follow those patterns.

### 8. Check Documentation

All commands have detailed docs:
```bash
cat .cursor/commands/workflow/start.md
```

---

## 🎯 Next Steps

1. ✅ **Run** `/project:init` to set up your project
2. ✅ **Review** generated conventions in `project-contexts/`
3. ✅ **Start** first workflow: `/workflow:start "Your task"`
4. ✅ **Explore** commands with `/misc:help`
5. ✅ **Configure** integrations (optional): `/setup:integrations`
6. ✅ **Read** workflow guide: `workflows/QUICK_REFERENCE.md`

---

## Need Help?

- **Quick Reference:** `.cursor/commands/QUICK_REFERENCE.md`
- **Workflow Help:** `.cursor/workflows/QUICK_REFERENCE.md`
- **Agents Guide:** `.cursor/AGENTS.md`
- **Original Aura Frog:** [github.com/nguyenthienthanh/aura-frog](https://github.com/nguyenthienthanh/aura-frog)

---

**Welcome to Aura Frog!**

Code with main character energy. Let's build something amazing!

---

**Version:** 1.1.5
**Last Updated:** 2025-12-11
