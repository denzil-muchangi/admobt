#!/bin/bash

# Build script for web platform

echo "🌐 Building Flutter app for web platform..."

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

# Enable web support if not already enabled
print_status "Enabling Flutter web support..."
flutter config --enable-web

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

# Build for web
print_status "Building web app..."
if flutter build web --release; then
    print_status "Web app built successfully!"
    echo "Web build location: build/web/"
    echo "You can serve the web app using: flutter run -d web"
    echo "Or serve it with any static web server from the build/web/ directory"
else
    print_error "Web build failed"
    exit 1
fi

# Optional: Create a simple web server script
cat > serve_web.sh << 'EOF'
#!/bin/bash
echo "Starting web server on http://localhost:8080"
cd build/web
python3 -m http.server 8080
EOF

chmod +x serve_web.sh
print_status "Created serve_web.sh script for local testing"

print_status "🎉 Web build completed!"
print_status "You can find the built web app in the build/web/ directory"
print_status "To test locally, run: ./serve_web.sh"