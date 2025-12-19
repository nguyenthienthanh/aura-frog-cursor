# Command: project:reload-env

**Category:** Project
**Priority:** Medium
**Syntax:** `project:reload-env`

---

## Description

Load or reload environment variables from the project's `.envrc` file. This command reads the `.envrc` file and makes all exported variables available for the current session.

**Use cases:**
- After editing `.envrc` with new API keys
- After switching projects
- When environment variables are not loading properly
- To verify which environment variables are set

---

## When to Use

- After modifying integration credentials (JIRA, Slack, Figma, Confluence)
- When starting a new session and env vars aren't loaded
- To debug environment variable issues

---

## Execution Steps

### 1. Detect .envrc Location

**Search order:**
1. Project root (current directory): `./.envrc`
2. Project .cursor folder: `./.cursor/.envrc`

```bash
PROJECT_ROOT=$(pwd)

if [ -f "$PROJECT_ROOT/.envrc" ]; then
  ENVRC_PATH="$PROJECT_ROOT/.envrc"
elif [ -f "$PROJECT_ROOT/.cursor/.envrc" ]; then
  ENVRC_PATH="$PROJECT_ROOT/.cursor/.envrc"
else
  echo "No .envrc file found"
  echo "   Run 'project:init' to create one"
  exit 1
fi
```

### 2. Parse and Load Environment Variables

**Safe parsing approach (handles special characters):**

```bash
# Read .envrc and extract export statements
while IFS= read -r line || [ -n "$line" ]; do
  # Skip comments and empty lines
  [[ "$line" =~ ^[[:space:]]*# ]] && continue
  [[ -z "${line// }" ]] && continue

  # Match export statements
  if [[ "$line" =~ ^[[:space:]]*export[[:space:]]+([A-Za-z_][A-Za-z0-9_]*)= ]]; then
    # Extract variable name and value
    var_name="${BASH_REMATCH[1]}"

    # Get value (handle quoted and unquoted)
    if [[ "$line" =~ ^[[:space:]]*export[[:space:]]+[A-Za-z_][A-Za-z0-9_]*=\"([^\"]*)\" ]]; then
      var_value="${BASH_REMATCH[1]}"
    elif [[ "$line" =~ ^[[:space:]]*export[[:space:]]+[A-Za-z_][A-Za-z0-9_]*=\'([^\']*)\' ]]; then
      var_value="${BASH_REMATCH[1]}"
    elif [[ "$line" =~ ^[[:space:]]*export[[:space:]]+[A-Za-z_][A-Za-z0-9_]*=([^[:space:]]*) ]]; then
      var_value="${BASH_REMATCH[1]}"
    fi

    # Export the variable
    export "$var_name=$var_value"
    echo "   $var_name"
  fi
done < "$ENVRC_PATH"
```

### 3. Verify Key Variables

**Check critical variables are set:**

```bash
echo ""
echo "Environment Status:"
echo ""

# Integrations
echo "Integration Credentials:"
[ -n "$JIRA_URL" ] && echo "   JIRA (configured)" || echo "   JIRA (not configured)"
[ -n "$FIGMA_API_TOKEN" ] && echo "   Figma (configured)" || echo "   Figma (not configured)"
[ -n "$SLACK_BOT_TOKEN" ] && echo "   Slack (configured)" || echo "   Slack (not configured)"
[ -n "$CONFLUENCE_URL" ] && echo "   Confluence (configured)" || echo "   Confluence (not configured)"

# Workflow Settings
echo ""
echo "Workflow Settings:"
[ -n "$AURA_FROG_DEFAULT_COVERAGE" ] && echo "   Coverage: $AURA_FROG_DEFAULT_COVERAGE%" || echo "   Coverage: 80% (default)"
[ -n "$AURA_FROG_TDD_ENFORCE" ] && echo "   TDD: $AURA_FROG_TDD_ENFORCE" || echo "   TDD: true (default)"
```

---

## Output

```markdown
---------------------------------------------------------------
Environment Loaded Successfully
---------------------------------------------------------------

Source: ./.envrc

Environment Status:

Integration Credentials:
   JIRA (configured)
   Figma (configured)
   Slack (not configured)
   Confluence (not configured)

Workflow Settings:
   Coverage: 80% (default)
   TDD: true (default)

Tip: Edit .envrc and run 'project:reload-env' to apply changes
```

---

## Example Usage

### Example 1: Load Environment After Editing

```
You: project:reload-env

Cursor AI:
Loading environment from .envrc...

Source: ./.envrc

Loaded variables:
   JIRA_URL
   JIRA_EMAIL
   JIRA_API_TOKEN
   FIGMA_API_TOKEN
   CONFLUENCE_URL

Environment Status:
[Full status output...]

Environment loaded successfully!
```

### Example 2: No .envrc Found

```
You: project:reload-env

Cursor AI:
No .envrc file found

To create one, run:
   project:init

Or use the setup script:
   ./setup.sh /path/to/project
```

---

## Important Notes

### Auto-Loading .envrc

**Cursor AI should auto-load .envrc at session start.**

See: `rules/core/env-loading.mdc`

### Security

- **Never log API key values** - only show "(set)" or "(not set)"
- **Don't commit .envrc with secrets** - add to .gitignore
- **Use .envrc.template** for sharing configuration structure

### direnv Integration

If using `direnv`:
```bash
# Allow direnv to load .envrc
direnv allow

# Reload after changes
direnv reload
```

---

## Related Commands

- `project:init` - Initialize project with .envrc
- `project:regen` - Regenerate project context
- `setup:integrations` - Configure integration credentials
- `workflow:start` - Start workflow (uses loaded env vars)

---

## Technical Details

### Supported Variable Formats

```bash
# All these formats are supported:
export VAR_NAME="value"
export VAR_NAME='value'
export VAR_NAME=value
```

### Special Characters

The parser handles:
- Quoted values with spaces
- URLs with special characters
- API tokens with special characters

### Environment Scope

Variables are loaded for the current Cursor IDE session only. They persist until:
- Session ends
- Variables are overwritten
- `project:reload-env` is run again

---

**Source:** Aura Frog v1.1.9
**Last Updated:** 2025-12-04
