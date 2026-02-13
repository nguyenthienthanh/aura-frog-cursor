# /design:stitch

## Description

Generate UI designs using Google Stitch AI with optimized prompts. Creates component designs from text descriptions.

## Usage

```
/design:stitch "Component description"
/design:stitch "Login form with email, password, remember me, and social auth buttons"
```

## Process

1. Parse design description
2. Generate optimized Stitch AI prompt
3. Include design system tokens (colors, spacing, typography)
4. Generate component specification
5. Output implementation-ready structure

## Output

- Component structure (HTML/JSX)
- Style specifications (Tailwind/CSS)
- Responsive breakpoints
- Accessibility annotations
- Interaction states (hover, focus, active, disabled)

## Related Commands

- `/design:stitch-review` - Review generated designs
- `/workflow:phase-3` - UI breakdown phase

---

**Source:** Aura Frog v1.11.0
**Created:** 2026-02-13
