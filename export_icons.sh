#!/usr/bin/env bash


# Exports a given SVG icon into mutiple PNG icons scaled to match: 16x 32x 64x 128x 256x 512x 1024x
# Usage: ./export_icons.sh {filename.svg} 

set -e

INPUT_SVG="$1"
OUTPUT_DIR="${2:-icons}"

if [ -z "$INPUT_SVG" ]; then
  echo "Usage: $0 input.svg [output_dir]"
  exit 1
fi

if [ ! -f "$INPUT_SVG" ]; then
  echo "Error: File not found: $INPUT_SVG"
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

# Get filename without path and extension
BASENAME="$(basename "$INPUT_SVG" .svg)"

SIZES=(16 32 64 128 256 512 1024)

for SIZE in "${SIZES[@]}"; do
  inkscape "$INPUT_SVG" \
    --export-type=png \
    --export-filename="$OUTPUT_DIR/${BASENAME}-${SIZE}x${SIZE}.png" \
    --export-width="$SIZE" \
    --export-height="$SIZE"
done

echo "Export complete → $OUTPUT_DIR"

