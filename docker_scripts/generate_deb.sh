#!/bin/bash

PROJECT_ROOT="$(cd "$(dirname "$0")"; cd ..; pwd)"
source ${PROJECT_ROOT}/config_docker.sh

# Create output directory
OUTPUT_DIR="${PROJECT_ROOT}/output"
mkdir -p "${OUTPUT_DIR}"

echo "🔨 Building Docker image for .deb package generation..."

# Build the Docker image
docker build \
    --network=host -f Dockerfile.Build -t ${DOCKER_IMAGE_NAME}-build ${PROJECT_ROOT}

if [ $? -ne 0 ]; then
    echo "❌ Docker build failed!"
    exit 1
fi

echo "📦 Extracting .deb package from container..."

# Create a temporary container to copy the .deb file
CONTAINER_ID=$(docker create ${DOCKER_IMAGE_NAME}-build)

if [ $? -ne 0 ]; then
    echo "❌ Failed to create container!"
    exit 1
fi

# Copy the .deb file from the container to the output directory
docker cp ${CONTAINER_ID}:/output/qt-hello-world_1.0.0_amd64.deb "${OUTPUT_DIR}/"

if [ $? -eq 0 ]; then
    echo "✅ Successfully generated .deb package!"
    echo "📁 Package location: ${OUTPUT_DIR}/qt-hello-world_1.0.0_amd64.deb"
    
    # Show package info
    echo ""
    echo "📋 Package information:"
    dpkg-deb -I "${OUTPUT_DIR}/qt-hello-world_1.0.0_amd64.deb" 2>/dev/null || echo "  (dpkg-deb not available on this system)"
    
    # Show file size
    ls -lh "${OUTPUT_DIR}/qt-hello-world_1.0.0_amd64.deb"
else
    echo "❌ Failed to copy .deb package from container!"
fi

# Clean up the temporary container
docker rm ${CONTAINER_ID} > /dev/null

echo ""
echo "🧹 Cleaning up..."
echo "🎉 Done! Your .deb package is ready in: ${OUTPUT_DIR}/"

