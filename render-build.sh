#!/bin/bash
set -e  # Exit on any error

echo "🚀 Starting Render build process..."

# Install Flutter
echo "📦 Installing Flutter..."
git clone https://github.com/flutter/flutter.git -b stable --depth 1
export PATH="$PATH:`pwd`/flutter/bin"

# Verify Flutter installation
echo "✅ Flutter version:"
flutter --version

# Enable web support
echo "🌐 Enabling web support..."
flutter config --enable-web

# Get dependencies
echo "📚 Getting dependencies..."
flutter pub get

# Build web app with release mode
echo "🔨 Building web app (release mode)..."
flutter build web --release

echo "✅ Build complete! Output in build/web/"
