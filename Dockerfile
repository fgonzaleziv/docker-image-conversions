# Use a smaller base image with Inkscape and ImageMagick installed
FROM alpine:latest

# Install Inkscape and ImageMagick
RUN apk add --no-cache inkscape imagemagick

# Set the working directory
WORKDIR /app

# Copy the conversion script from the script directory
COPY script/convert.sh /app/convert.sh

# Make the script executable
RUN chmod +x /app/convert.sh