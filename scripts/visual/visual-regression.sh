#!/bin/bash
#
# Aura Frog - Visual Regression Testing
#
# Compares implementation screenshots against design references.
# Calculates pixel difference and generates diff images.
#
# Usage:
#   ./scripts/visual/visual-regression.sh <current> <reference> [threshold]
#   ./scripts/visual/visual-regression.sh --url <url> <reference> [threshold]
#
# Examples:
#   ./scripts/visual/visual-regression.sh current.png reference.png 1
#   ./scripts/visual/visual-regression.sh --url http://localhost:3000 reference.png
#
# Version: 1.9.0

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

# Configuration
VISUAL_DIR=".cursor/visual"
THRESHOLD="${3:-1}"  # Default 1% threshold

# Ensure directories exist
mkdir -p "$VISUAL_DIR"
mkdir -p "$VISUAL_DIR/reference"
mkdir -p "$VISUAL_DIR/current"
mkdir -p "$VISUAL_DIR/diff"

# Check dependencies
check_dependencies() {
  local missing=()

  if ! command -v compare &> /dev/null; then
    missing+=("ImageMagick (brew install imagemagick)")
  fi

  if [[ ${#missing[@]} -gt 0 ]]; then
    echo -e "${RED}Missing dependencies:${NC}"
    for dep in "${missing[@]}"; do
      echo "  - $dep"
    done
    echo ""
    echo "Install with: brew install imagemagick"
    exit 1
  fi
}

# Capture screenshot from URL using Playwright
capture_screenshot() {
  local url="$1"
  local output="$2"

  echo -e "${CYAN}📸 Capturing screenshot from: $url${NC}"

  # Use Playwright via npx
  npx playwright screenshot "$url" "$output" \
    --viewport-size="1920,1080" \
    --full-page \
    2>/dev/null || {
    echo -e "${RED}Failed to capture screenshot${NC}"
    echo "Ensure Playwright is installed: npx playwright install"
    exit 1
  }

  echo -e "${GREEN}✓ Screenshot saved: $output${NC}"
}

# Compare images and calculate difference
compare_images() {
  local current="$1"
  local reference="$2"
  local diff_output="$VISUAL_DIR/diff/diff-$(date +%Y%m%d-%H%M%S).png"

  echo -e "${CYAN}🔍 Comparing images...${NC}"
  echo "  Current:   $current"
  echo "  Reference: $reference"

  # Check files exist
  if [[ ! -f "$current" ]]; then
    echo -e "${RED}Error: Current image not found: $current${NC}"
    exit 1
  fi

  if [[ ! -f "$reference" ]]; then
    echo -e "${RED}Error: Reference image not found: $reference${NC}"
    exit 1
  fi

  # Get image dimensions
  local current_size=$(identify -format "%wx%h" "$current" 2>/dev/null)
  local reference_size=$(identify -format "%wx%h" "$reference" 2>/dev/null)

  if [[ "$current_size" != "$reference_size" ]]; then
    echo -e "${YELLOW}⚠ Image sizes differ: $current_size vs $reference_size${NC}"
    echo "  Resizing reference to match current..."
    convert "$reference" -resize "$current_size!" "$VISUAL_DIR/reference/resized.png"
    reference="$VISUAL_DIR/reference/resized.png"
  fi

  # Calculate total pixels
  local width=$(identify -format "%w" "$current")
  local height=$(identify -format "%h" "$current")
  local total_pixels=$((width * height))

  # Compare and get different pixels count
  local diff_pixels=$(compare -metric AE "$current" "$reference" "$diff_output" 2>&1 || true)

  # Handle non-numeric output
  if ! [[ "$diff_pixels" =~ ^[0-9]+$ ]]; then
    diff_pixels=$(echo "$diff_pixels" | grep -oE '[0-9]+' | head -1)
  fi

  # Calculate percentage
  local diff_percent=$(echo "scale=2; ($diff_pixels / $total_pixels) * 100" | bc)

  # Output results
  echo ""
  echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo -e "${CYAN}🎨 VISUAL REGRESSION RESULT${NC}"
  echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo ""
  echo "  Reference: $reference"
  echo "  Current:   $current"
  echo "  Diff:      $diff_output"
  echo ""
  echo "  Image Size:    ${width}x${height}"
  echo "  Total Pixels:  $total_pixels"
  echo "  Diff Pixels:   $diff_pixels"
  echo -e "  Diff Percent:  ${CYAN}${diff_percent}%${NC} (threshold: ${THRESHOLD}%)"
  echo ""

  # Determine pass/fail
  local pass=$(echo "$diff_percent <= $THRESHOLD" | bc)

  if [[ "$pass" -eq 1 ]]; then
    echo -e "  Status: ${GREEN}✅ PASSED${NC}"
    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    return 0
  else
    echo -e "  Status: ${RED}❌ FAILED${NC}"
    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${YELLOW}Diff image saved: $diff_output${NC}"
    echo "Red pixels indicate differences."
    return 1
  fi
}

# Main
main() {
  check_dependencies

  if [[ "$1" == "--url" ]]; then
    # Capture from URL mode
    local url="$2"
    local reference="$3"
    THRESHOLD="${4:-1}"

    local current="$VISUAL_DIR/current/screenshot-$(date +%Y%m%d-%H%M%S).png"
    capture_screenshot "$url" "$current"
    compare_images "$current" "$reference"
  elif [[ "$1" == "--help" || -z "$1" ]]; then
    echo "Usage:"
    echo "  $0 <current.png> <reference.png> [threshold]"
    echo "  $0 --url <url> <reference.png> [threshold]"
    echo ""
    echo "Options:"
    echo "  threshold  Max allowed pixel diff % (default: 1)"
    echo ""
    echo "Examples:"
    echo "  $0 current.png design.png 1"
    echo "  $0 --url http://localhost:3000 design.png 2"
  else
    # Direct comparison mode
    local current="$1"
    local reference="$2"
    THRESHOLD="${3:-1}"

    compare_images "$current" "$reference"
  fi
}

main "$@"
