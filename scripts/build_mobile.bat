@echo off
REM Build script for mobile platforms (Android & iOS) - Windows version

echo 🚀 Building Flutter app for mobile platforms...

REM Check if Flutter is installed
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Flutter is not installed or not in PATH
    exit /b 1
)

REM Get Flutter version
for /f "tokens=*" %%i in ('flutter --version ^| findstr /r "^Flutter"') do set FLUTTER_VERSION=%%i
echo [INFO] Using %FLUTTER_VERSION%

REM Clean previous builds
echo [INFO] Cleaning previous builds...
flutter clean

REM Get dependencies
echo [INFO] Getting dependencies...
flutter pub get

REM Generate localization files
echo [INFO] Generating localization files...
flutter gen-l10n

REM Run tests
echo [INFO] Running tests...
flutter test
if %errorlevel% neq 0 (
    echo [ERROR] Some tests failed
    exit /b 1
)
echo [INFO] All tests passed!

REM Analyze code
echo [INFO] Analyzing code...
flutter analyze
if %errorlevel% neq 0 (
    echo [WARNING] Code analysis found issues
)

REM Build for Android
echo [INFO] Building Android APK...
flutter build apk --release
if %errorlevel% neq 0 (
    echo [ERROR] Android build failed
    exit /b 1
)
echo [INFO] Android APK built successfully!
echo APK location: build\app\outputs\flutter-apk\app-release.apk

REM Build for iOS (if on macOS - this will likely fail on Windows)
echo [INFO] Attempting iOS build...
flutter build ios --release --no-codesign 2>nul
if %errorlevel% neq 0 (
    echo [WARNING] iOS build failed (expected on Windows)
) else (
    echo [INFO] iOS app built successfully!
    echo iOS app location: build\ios\iphoneos\Runner.app
)

echo [INFO] 🎉 Mobile build completed!
echo [INFO] You can find the built artifacts in the build\ directory
pause