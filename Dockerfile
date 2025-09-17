# Use Ubuntu 22.04 as base image
FROM ubuntu:22.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Set timezone
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    pkg-config \
    qt6-base-dev \
    qt6-base-dev-tools \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libxkbcommon-x11-0 \
    libxcb-xinerama0 \
    libxcb-cursor0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-randr0 \
    libxcb-render-util0 \
    libxcb-shape0 \
    libxcb-xfixes0 \
    && rm -rf /var/lib/apt/lists/*

# Copy the source code
# COPY --chown=dockeruser:dockeruser code/ ./code/
COPY code/ ./code/

# Switch to non-root user
# USER dockeruser

# Set environment variables for Qt
ENV QT_QPA_PLATFORM=xcb
ENV DISPLAY=:0

# Set working directory to code folder and build the application
WORKDIR /code
RUN mkdir -p build && \
    cd build && \
    cmake .. && \
    make

# Set the default command
CMD ["./build/QtHelloWorld"]
