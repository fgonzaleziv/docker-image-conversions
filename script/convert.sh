#!/bin/sh

# Debugging: Print current directory and list files
echo "Current directory: $(pwd)"
echo "Listing files in /app:"
ls -la /app

# Process all SVG files in the input directory
for INPUT_FILE in /app/input/*.svg; do
  # Extract the base name of the input file (without extension)
  BASE_NAME=$(basename "$INPUT_FILE" .svg)

  # Debugging: Check if input file exists
  if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file $INPUT_FILE does not exist."
    continue
  fi

  # Output directory for this file
  OUTPUT_DIR="/app/output/$BASE_NAME"
  mkdir -p "$OUTPUT_DIR"

  # Copy the original SVG to the output directory
  cp "$INPUT_FILE" "$OUTPUT_DIR/${BASE_NAME}.svg"

  # Convert SVG to PNG (multiple sizes) using Inkscape
  inkscape "$INPUT_FILE" --export-type=png --export-filename="$OUTPUT_DIR/${BASE_NAME}-16x16.png" --export-width=16 --export-height=16
  inkscape "$INPUT_FILE" --export-type=png --export-filename="$OUTPUT_DIR/${BASE_NAME}-32x32.png" --export-width=32 --export-height=32
  inkscape "$INPUT_FILE" --export-type=png --export-filename="$OUTPUT_DIR/${BASE_NAME}-48x48.png" --export-width=48 --export-height=48

  # Combine PNGs into ICO using ImageMagick
  magick "$OUTPUT_DIR/${BASE_NAME}-16x16.png" \
         "$OUTPUT_DIR/${BASE_NAME}-32x32.png" \
         "$OUTPUT_DIR/${BASE_NAME}-48x48.png" \
         "$OUTPUT_DIR/${BASE_NAME}.ico"

  # Print success message for this file
  echo "Conversion complete for $INPUT_FILE. Files are in $OUTPUT_DIR."
done