# Use a smaller base image with ImageMagick installed
FROM alpine:latest

# Install ImageMagick
RUN apk add --no-cache imagemagick

# Set the working directory
WORKDIR /app

# Copy the conversion script into the container
COPY convert.sh /app/convert.sh

# Make the script executable
RUN chmod +x /app/convert.sh

# Define the entrypoint
ENTRYPOINT ["/app/convert.sh"]