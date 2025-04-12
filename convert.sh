#!/bin/bash

# Input SVG file
INPUT_FILE="/app/input.svg"

# Output directory
OUTPUT_DIR="/app/output"
mkdir -p "$OUTPUT_DIR"

# Convert SVG to PNG (multiple sizes)
convert "$INPUT_FILE" -resize 16x16 "$OUTPUT_DIR/favicon-16x16.png"
convert "$INPUT_FILE" -resize 32x32 "$OUTPUT_DIR/favicon-32x32.png"
convert "$INPUT_FILE" -resize 48x48 "$OUTPUT_DIR/favicon-48x48.png"

# Convert PNGs to ICO
convert "$OUTPUT_DIR/favicon-16x16.png" \
        "$OUTPUT_DIR/favicon-32x32.png" \
        "$OUTPUT_DIR/favicon-48x48.png" \
        "$OUTPUT_DIR/favicon.ico"

# Print success message
echo "Conversion complete. Files are in the output directory."