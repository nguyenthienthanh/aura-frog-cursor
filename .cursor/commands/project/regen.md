# /project:regen - Regenerate CLAUDE.md with Smart Merge

## Description

Regenerates the project's CLAUDE.md file while preserving user-added content. Uses marker-based sections to distinguish between auto-managed and user-managed content.

**What it does:**
1. Reads existing CLAUDE.md
2. Extracts user content (everything after `<!-- AURA-FROG-AUTO-END -->`)
3. Regenerates auto-managed section from latest template
4. Merges user content back
5. Updates version and date

## Usage

```
/project:regen
```

## How It Works

### Marker System

The CLAUDE.md file uses HTML comment markers:

```markdown
<!-- AURA-FROG-AUTO-START -->
... auto-managed content (banner reference, MCP servers, etc.) ...
<!-- AURA-FROG-AUTO-END -->

... user content (preserved on regen) ...
```

### What Gets Updated

| Section | On Regen |
|---------|----------|
| Header (project name, version) | Updated |
| `<!-- AURA-FROG-AUTO-START -->` to `<!-- AURA-FROG-AUTO-END -->` | Replaced with latest template |
| Everything after `<!-- AURA-FROG-AUTO-END -->` | **Preserved** |

### What Gets Preserved

- Project-specific settings
- Custom rules
- Custom integrations
- Any user-added sections

## Execution Steps

1. **Read existing CLAUDE.md** - Get current content
2. **Extract metadata** - Project name, tech stack from header
3. **Extract user section** - Everything after `<!-- AURA-FROG-AUTO-END -->`
4. **Load template** - From `.cursor/templates/project-claude.md`
5. **Replace placeholders** - [PROJECT_NAME], [TECH_STACK], [DATE]
6. **Merge** - New auto section + preserved user section
7. **Write back** - Save to `.claude/CLAUDE.md`

## Example

### Before Regen

```markdown
# Aura Frog - MyApp

**Aura Frog Version:** 1.1.8  <!-- old version -->

<!-- AURA-FROG-AUTO-START -->
... old banner format without MCP visibility ...
<!-- AURA-FROG-AUTO-END -->

## Project-Specific Settings

### Custom Rules
- Always use NativeWind for styling
```

### After Regen

```markdown
# Aura Frog - MyApp

**Aura Frog Version:** 1.1.9  <!-- updated -->

<!-- AURA-FROG-AUTO-START -->
... NEW banner format WITH MCP visibility ...
<!-- AURA-FROG-AUTO-END -->

## Project-Specific Settings

### Custom Rules
- Always use NativeWind for styling  <!-- PRESERVED -->
```

## Related Commands

- `/project:init` - First-time project initialization
- `/project:detect` - Re-detect tech stack

## Notes

- **Safe by default**: User content is always preserved
- **Banner reference**: Template references `.cursor/rules/core/agent-identification.mdc`
- **Idempotent**: Can run multiple times safely
- **No data loss**: User sections are never overwritten

---

**Source:** Aura Frog v1.1.9
**Updated:** 2025-12-22
