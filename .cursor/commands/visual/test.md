# /visual:test

Run visual regression test comparing implementation against design reference.

---

## Usage

```bash
/visual:test <url> <reference> [threshold]
```

---

## Parameters

| Parameter | Required | Default | Description |
|-----------|----------|---------|-------------|
| `url` | Yes | - | URL to capture (e.g., http://localhost:3000) |
| `reference` | Yes | - | Path to reference image |
| `threshold` | No | 1 | Max allowed pixel diff % |

---

## CRITICAL: Cursor MUST Execute

When user runs `/visual:test`, Cursor **MUST actually run the test**.

**DO NOT** just describe - **DO** execute:

```bash
# Source environment
source .envrc 2>/dev/null || true

# Run visual regression
./scripts/visual/visual-regression.sh --url "$URL" "$REFERENCE" "$THRESHOLD"
```

---

## Example

```bash
/visual:test http://localhost:3000 .cursor/visual/reference/homepage.png 1
```

Output:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎨 VISUAL REGRESSION RESULT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Reference: .cursor/visual/reference/homepage.png
  Current:   .cursor/visual/current/screenshot-20260114-120000.png
  Diff:      .cursor/visual/diff/diff-20260114-120000.png

  Image Size:    1920x1080
  Total Pixels:  2073600
  Diff Pixels:   8294
  Diff Percent:  0.4% (threshold: 1%)

  Status: ✅ PASSED

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Using with Figma

If you have a Figma URL:

```bash
# First fetch the design
/visual:test http://localhost:3000 figma://ABC123/1:234

# Cursor should:
# 1. Use Figma MCP to download the design frame
# 2. Save to .cursor/visual/reference/
# 3. Run visual comparison
```

---

**Version:** 1.11.0
