#!/bin/bash

# Install Flutter
echo "Installing Flutter..."
git clone https://github.com/flutter/flutter.git -b stable --depth 1
export PATH="$PATH:`pwd`/flutter/bin"

# Verify Flutter installation
flutter --version

# Enable web support
flutter config --enable-web

# Get dependencies
flutter pub get

# Build web app
flutter build web --release

echo "Build complete! Output in build/web/"
