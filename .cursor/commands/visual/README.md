# Visual Regression Commands

Commands for pixel-perfect UI testing with automated fix loops.

---

## Overview

Visual regression testing ensures your UI implementation matches design references exactly. The auto-fix loop iterates until pixel-perfect match is achieved.

**Skill:** `.cursor/rules/skills/auto-invoke/visual-regression.mdc`
**Rule:** `.cursor/rules/core/pixel-accuracy.mdc`

---

## Commands

| Command | Purpose | When to Use |
|---------|---------|-------------|
| `/visual:test` | Run visual regression on current URL | After UI implementation |
| `/visual:compare` | Compare against specific reference | Design verification |
| `/visual:loop` | Run auto-fix loop | Iterative fixing |
| `/visual:baseline` | Update baseline screenshots | After approved changes |
| `/visual:report` | Generate visual diff report | Before PR submission |

---

## Quick Start

```bash
# 1. Start your dev server
npm run dev

# 2. Run visual test against reference
/visual:test http://localhost:3000 reference.png

# 3. Or run auto-fix loop
/visual:loop http://localhost:3000 design.png 1 5
```

---

## Requirements

- **ImageMagick** - For image comparison
- **Playwright** - For screenshot capture

```bash
# Install dependencies
brew install imagemagick
npx playwright install
```

---

## Directory Structure

```
.cursor/visual/
├── reference/          # Design reference images
├── current/            # Current implementation screenshots
├── diff/               # Diff images (red = differences)
└── iterations/         # Auto-fix loop iterations
```

---

## Configuration

Create `.cursor/visual-regression.yaml`:

```yaml
visual_regression:
  threshold: 1              # Max pixel diff % (default 1%)
  max_iterations: 5         # Auto-fix attempts
  screenshot_width: 1920
  screenshot_height: 1080
```

---

## MCP Integration

### Playwright MCP (Screenshots)
```javascript
// Capture via Playwright MCP
await playwright.screenshot({
  url: 'http://localhost:3000',
  path: '.cursor/visual/current.png'
});
```

### Figma MCP (Design Reference)
```javascript
// Fetch from Figma
const design = await figma.getImage({
  fileId: 'ABC123',
  nodeId: '1:234'
});
```

---

**Version:** 1.10.0
