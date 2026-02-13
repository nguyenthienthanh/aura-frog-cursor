# /visual:loop

Run visual regression auto-fix loop until pixel-perfect or max iterations.

---

## Usage

```bash
/visual:loop <url> <reference> [threshold] [max_iterations]
```

---

## Parameters

| Parameter | Required | Default | Description |
|-----------|----------|---------|-------------|
| `url` | Yes | - | URL to capture |
| `reference` | Yes | - | Path to reference image |
| `threshold` | No | 1 | Max allowed pixel diff % |
| `max_iterations` | No | 5 | Max fix attempts |

---

## CRITICAL: Cursor MUST Execute Loop

When user runs `/visual:loop`, Cursor **MUST**:

1. Run visual comparison
2. If failed, analyze differences
3. Apply CSS/style fixes
4. Re-run comparison
5. Repeat until pass or max iterations

```bash
# Run auto-fix loop
./scripts/visual/auto-fix-loop.sh "$URL" "$REFERENCE" "$THRESHOLD" "$MAX_ITERATIONS"
```

---

## Auto-Fix Process

```
Iteration 1/5
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📸 Capturing screenshot...
🔍 Comparing... Pixel Diff: 3.2% (threshold: 1%)
❌ Diff exceeds threshold

📋 Issues Found:
  • Color mismatch: .header background (#1a1a30 → #1a1a2e)
  • Spacing issue: .card padding (12px → 16px)
  • Font size: .title (22px → 24px)

💡 Applying fixes...
  ✓ Updated .header background-color
  ✓ Updated .card padding
  ✓ Updated .title font-size

Iteration 2/5
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📸 Capturing screenshot...
🔍 Comparing... Pixel Diff: 0.8% (threshold: 1%)
✅ PASSED after 2 iterations
```

---

## Example

```bash
/visual:loop http://localhost:3000/dashboard .cursor/visual/reference/dashboard.png 1 5
```

---

## What Cursor Should Do

For each iteration:

1. **Capture** - Take screenshot using Playwright MCP
2. **Compare** - Calculate pixel difference
3. **Analyze** - Identify problem areas (colors, spacing, fonts, layout)
4. **Fix** - Apply targeted CSS corrections to source files
5. **Verify** - Re-capture and compare

---

## Fix Strategies

### Color Fixes
```css
/* Detected: Color mismatch */
.header {
  background-color: #1a1a2e; /* was: #1a1a30 */
}
```

### Spacing Fixes
```css
/* Detected: Padding mismatch */
.card {
  padding: 16px; /* was: 12px */
}
```

### Typography Fixes
```css
/* Detected: Font size mismatch */
.title {
  font-size: 24px; /* was: 22px */
}
```

---

**Version:** 1.11.0
