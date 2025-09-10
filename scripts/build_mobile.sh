#!/bin/bash

# Build script for mobile platforms (Android & iOS)

echo "🚀 Building Flutter app for mobile platforms..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    print_error "Flutter is not installed or not in PATH"
    exit 1
fi

# Get Flutter version
FLUTTER_VERSION=$(flutter --version | head -n 1)
print_status "Using $FLUTTER_VERSION"

# Clean previous builds
print_status "Cleaning previous builds..."
flutter clean

# Get dependencies
print_status "Getting dependencies..."
flutter pub get

# Generate localization files
print_status "Generating localization files..."
flutter gen-l10n

# Run tests
print_status "Running tests..."
if flutter test; then
    print_status "All tests passed!"
else
    print_error "Some tests failed"
    exit 1
fi

# Analyze code
print_status "Analyzing code..."
if flutter analyze; then
    print_status "Code analysis passed!"
else
    print_warning "Code analysis found issues"
fi

# Build for Android
print_status "Building Android APK..."
if flutter build apk --release; then
    print_status "Android APK built successfully!"
    echo "APK location: build/app/outputs/flutter-apk/app-release.apk"
else
    print_error "Android build failed"
    exit 1
fi

# Build for iOS (if on macOS)
if [[ "$OSTYPE" == "darwin"* ]]; then
    print_status "Building iOS app..."
    if flutter build ios --release --no-codesign; then
        print_status "iOS app built successfully!"
        echo "iOS app location: build/ios/iphoneos/Runner.app"
    else
        print_warning "iOS build failed (this is normal if you don't have iOS development setup)"
    fi
else
    print_status "Skipping iOS build (not on macOS)"
fi

print_status "🎉 Mobile build completed!"
print_status "You can find the built artifacts in the build/ directory"