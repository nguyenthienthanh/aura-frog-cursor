# /workflow:reject - Reject current phase and restart with feedback  

## Description

Reject current phase and restart with feedback  

**Original command:** `workflow:reject`

## Usage

```
/workflow:reject [arguments]
```

## Execution Steps

1. Load command configuration
2. Execute command logic
3. Return results

## Examples

1: Requirements Phase
```
User: /workflow:reject Missing edge cases for empty input scenarios

Agent Response:
🔄 Phase 1 rejected. Restarting with feedback...

Feedback: Missing edge cases for empty input scenarios

Updating requirements analysis to include:
- Empty caption handling
- Null/undefined data handling
- Network timeout scenarios
- API failure edge cases

[Generates updated requirements document]

═══════════════════════════════════════════════════════════
🎯 PHASE 1 COMPLETE: Requirements Analysis (Updated)
═══════════════════════════════════════════════════════════

📊 Summary:
Updated requirements with additional edge cases

✅ Changes Made:
   • Added 4 edge case scenarios
   • Updated acceptance criteria
   • Enhanced risk assessment

[New approval gate...]
```

## References

- Original Aura Frog command: `workflow:reject`
- Project context: `.cursor/project-contexts/[project]/`
- Workflow state: `.cursor/logs/workflows/`

## Notes

This command has been converted from Aura Frog format to Cursor slash command format.
All functionality from the original command is preserved.

---

**Source:** Aura Frog v1.2.0
**Converted:** 2025-11-30
