#!/bin/bash

echo "=== XQuartz Setup for Docker X11 Forwarding ==="
echo

# Check if XQuartz is installed
if ! command -v xhost &> /dev/null; then
    echo "❌ XQuartz is not installed."
    echo "Please install XQuartz with:"
    echo "  brew install --cask xquartz"
    echo
    echo "Or download from: https://www.xquartz.org/"
    exit 1
fi

echo "✅ XQuartz is installed"

# Configure XQuartz settings
echo "🔧 Configuring XQuartz settings..."

# Allow network clients (this is the key setting)
defaults write org.macosforge.xquartz.X11 nolisten_tcp -bool false
echo "✅ Enabled network client connections"

# Set up X11 permissions
echo "🔧 Setting up X11 permissions..."
xhost +localhost > /dev/null 2>&1
echo "✅ Added localhost to X11 access control"

echo
echo "=== Setup Complete! ==="
echo
echo "📋 Next steps:"
echo "1. Restart XQuartz if it's currently running"
echo "2. In XQuartz preferences, go to Security tab and ensure:"
echo "   - 'Allow connections from network clients' is checked"
echo "3. Run your Docker container with: ./scripts/run.sh"
echo
echo "🔍 Troubleshooting:"
echo "- If you get connection errors, try restarting XQuartz"
echo "- Make sure XQuartz is running before starting the container"
echo "- Check that port 6000 is open: sudo lsof -i -P | grep LISTEN | grep :6000"
