#!/bin/bash
#
# Aura Frog - Visual Regression Auto-Fix Loop
#
# Runs visual regression in a loop, analyzing differences and
# suggesting fixes until pixel-perfect match or max iterations.
#
# Usage:
#   ./scripts/visual/auto-fix-loop.sh <url> <reference> [threshold] [max_iterations]
#
# Example:
#   ./scripts/visual/auto-fix-loop.sh http://localhost:3000 design.png 1 5
#
# Version: 1.9.0

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# Configuration
VISUAL_DIR=".cursor/visual"
URL="${1:-http://localhost:3000}"
REFERENCE="${2:-}"
THRESHOLD="${3:-1}"
MAX_ITERATIONS="${4:-5}"

# Ensure directories exist
mkdir -p "$VISUAL_DIR"
mkdir -p "$VISUAL_DIR/iterations"

# Check dependencies
check_dependencies() {
  local missing=()

  if ! command -v compare &> /dev/null; then
    missing+=("ImageMagick")
  fi

  if ! command -v npx &> /dev/null; then
    missing+=("Node.js/npx")
  fi

  if [[ ${#missing[@]} -gt 0 ]]; then
    echo -e "${RED}Missing dependencies: ${missing[*]}${NC}"
    exit 1
  fi
}

# Capture screenshot
capture() {
  local iteration="$1"
  local output="$VISUAL_DIR/iterations/iteration-${iteration}.png"

  npx playwright screenshot "$URL" "$output" \
    --viewport-size="1920,1080" \
    --full-page \
    2>/dev/null

  echo "$output"
}

# Compare and return diff percentage
compare() {
  local current="$1"
  local reference="$2"
  local diff_output="$VISUAL_DIR/iterations/diff-$(date +%Y%m%d-%H%M%S).png"

  local width=$(identify -format "%w" "$current" 2>/dev/null)
  local height=$(identify -format "%h" "$current" 2>/dev/null)
  local total_pixels=$((width * height))

  local diff_pixels=$(compare -metric AE "$current" "$reference" "$diff_output" 2>&1 || true)

  if ! [[ "$diff_pixels" =~ ^[0-9]+$ ]]; then
    diff_pixels=$(echo "$diff_pixels" | grep -oE '[0-9]+' | head -1)
  fi

  local diff_percent=$(echo "scale=2; ($diff_pixels / $total_pixels) * 100" | bc)

  echo "$diff_percent"
}

# Analyze differences (basic implementation)
analyze_diff() {
  local diff_image="$1"

  echo -e "${CYAN}Analyzing differences...${NC}"

  # This is a placeholder - in practice, you would use
  # more sophisticated image analysis tools

  # Get dominant diff colors (areas that are most different)
  local colors=$(convert "$diff_image" -colors 5 -format "%c" histogram:info: 2>/dev/null | head -5)

  echo "  Diff regions detected. Review diff image for details."
}

# Main auto-fix loop
main() {
  check_dependencies

  if [[ -z "$REFERENCE" ]]; then
    echo "Usage: $0 <url> <reference.png> [threshold] [max_iterations]"
    exit 1
  fi

  if [[ ! -f "$REFERENCE" ]]; then
    echo -e "${RED}Reference image not found: $REFERENCE${NC}"
    exit 1
  fi

  echo -e "${CYAN}"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "  🎨 VISUAL REGRESSION AUTO-FIX LOOP"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo -e "${NC}"
  echo ""
  echo "  URL:            $URL"
  echo "  Reference:      $REFERENCE"
  echo "  Threshold:      ${THRESHOLD}%"
  echo "  Max Iterations: $MAX_ITERATIONS"
  echo ""

  local iteration=1
  local passed=false

  while [[ $iteration -le $MAX_ITERATIONS ]]; do
    echo -e "${CYAN}━━━ Iteration $iteration/$MAX_ITERATIONS ━━━${NC}"
    echo ""

    # Capture current state
    echo -e "${CYAN}📸 Capturing screenshot...${NC}"
    local current=$(capture $iteration)
    echo "  Saved: $current"
    echo ""

    # Compare
    echo -e "${CYAN}🔍 Comparing...${NC}"
    local diff_percent=$(compare "$current" "$REFERENCE")
    echo "  Pixel Diff: ${diff_percent}% (threshold: ${THRESHOLD}%)"
    echo ""

    # Check if passed
    local pass=$(echo "$diff_percent <= $THRESHOLD" | bc)

    if [[ "$pass" -eq 1 ]]; then
      echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
      echo -e "${GREEN}✅ PASSED after $iteration iteration(s)${NC}"
      echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
      echo ""
      echo "  Final Pixel Diff: ${diff_percent}%"
      passed=true
      break
    fi

    # Analyze and suggest fixes
    echo -e "${YELLOW}❌ Diff exceeds threshold${NC}"
    echo ""
    echo -e "${CYAN}📋 Analysis:${NC}"
    echo "  Review the diff image at: $VISUAL_DIR/iterations/"
    echo ""
    echo -e "${CYAN}💡 Suggested Actions:${NC}"
    echo "  1. Check color values against design tokens"
    echo "  2. Verify spacing matches 8px grid"
    echo "  3. Confirm font sizes match typography scale"
    echo "  4. Check border-radius and shadow values"
    echo ""

    if [[ $iteration -lt $MAX_ITERATIONS ]]; then
      echo -e "${YELLOW}Waiting for fixes before next iteration...${NC}"
      echo "Press Enter after making fixes, or Ctrl+C to exit."
      read -r
    fi

    ((iteration++))
  done

  if [[ "$passed" != "true" ]]; then
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${RED}❌ FAILED after $MAX_ITERATIONS iterations${NC}"
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "  Manual review required."
    echo "  Check diff images in: $VISUAL_DIR/iterations/"
    exit 1
  fi
}

main "$@"
