#!/bin/bash

PROJECT_ROOT="$(cd "$(dirname "$0")"; cd ..; pwd)"
source ${PROJECT_ROOT}/config_docker.sh

# macOS X11 forwarding setup for Docker Desktop
echo "Setting up X11 forwarding for macOS..."

# Check if XQuartz is running
if ! pgrep -f "XQuartz" > /dev/null; then
    echo "XQuartz is not running. Please start XQuartz first."
    echo "You can install it with: brew install --cask xquartz"
    exit 1
fi

# Allow localhost connections to X11
echo "Configuring X11 permissions..."
xhost +localhost > /dev/null 2>&1

# Run the Qt application container with proper macOS X11 forwarding
echo "Starting Qt application container..."
docker run -it \
    -e DISPLAY=host.docker.internal:0 \
    -e QT_X11_NO_MITSHM=1 \
    -e LIBGL_ALWAYS_INDIRECT=1 \
    --name ${DOCKER_CONTAINER_NAME} \
    --rm \
    ${DOCKER_IMAGE_NAME}
