#!/usr/bin/env bash
# =====================================================
# export-icons.sh
#
# Description:
#   Exports an SVG file into multiple PNG sizes, scaling
#   by height while keeping aspect ratio.
#   Output folder is named {input_file_name}_scaled.
#
# Usage:
#   ./export-icons.sh input.svg
#
# Requirements:
#   - Inkscape must be installed and available in PATH.
#
# Output:
#   For input "my-icon.svg", creates:
#     my-icon_scaled/
#       my-icon-16px.png
#       my-icon-32px.png
#       my-icon-64px.png
#       ...
#       my-icon-1024px.png
# =====================================================

set -e

INPUT_SVG="$1"

if [ -z "$INPUT_SVG" ]; then
  echo "Usage: $0 input.svg"
  exit 1
fi

if [ ! -f "$INPUT_SVG" ]; then
  echo "Error: File not found: $INPUT_SVG"
  exit 1
fi

# Get filename without path and extension
BASENAME="$(basename "$INPUT_SVG" .svg)"

# Output directory based on input filename
OUTPUT_DIR="${BASENAME}_scaled"
mkdir -p "$OUTPUT_DIR"

# Heights to export
HEIGHTS=(16 32 64 128 256 512 1024)

for H in "${HEIGHTS[@]}"; do
  inkscape "$INPUT_SVG" \
    --export-type=png \
    --export-filename="$OUTPUT_DIR/${BASENAME}-${H}px.png" \
    --export-height="$H"
done

echo "Export complete → $OUTPUT_DIR"

