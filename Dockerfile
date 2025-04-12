# Use a specific version of Alpine for consistency
FROM alpine:3.21.3

# Install Inkscape and ImageMagick in a single layer
RUN apk add --no-cache inkscape imagemagick && \
  mkdir -p /app/input /app/output

# Set the working directory
WORKDIR /app

# Ensure the script directory exists and copy the conversion script
COPY script/convert.sh /app/convert.sh
RUN test -f /app/convert.sh || (echo "convert.sh not found!" && exit 1)

# Make the script executable
RUN chmod +x /app/convert.sh

# Set the default command to execute the conversion script
ENTRYPOINT ["/app/convert.sh"]