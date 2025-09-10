@echo off
REM Build script for web platform - Windows version

echo 🌐 Building Flutter app for web platform...

REM Check if Flutter is installed
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Flutter is not installed or not in PATH
    exit /b 1
)

REM Get Flutter version
for /f "tokens=*" %%i in ('flutter --version ^| findstr /r "^Flutter"') do set FLUTTER_VERSION=%%i
echo [INFO] Using %FLUTTER_VERSION%

REM Enable web support if not already enabled
echo [INFO] Enabling Flutter web support...
flutter config --enable-web

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

REM Build for web
echo [INFO] Building web app...
flutter build web --release
if %errorlevel% neq 0 (
    echo [ERROR] Web build failed
    exit /b 1
)
echo [INFO] Web app built successfully!
echo Web build location: build\web\
echo You can serve the web app using: flutter run -d web
echo Or serve it with any static web server from the build\web\ directory

REM Create a simple web server batch file
echo @echo off > serve_web.bat
echo echo Starting web server on http://localhost:8080 >> serve_web.bat
echo cd build\web >> serve_web.bat
echo REM You can use Python if installed: python -m http.server 8080 >> serve_web.bat
echo REM Or use any other static web server >> serve_web.bat
echo echo Open http://localhost:8080 in your browser >> serve_web.bat
echo pause >> serve_web.bat

echo [INFO] Created serve_web.bat script for local testing

echo [INFO] 🎉 Web build completed!
echo [INFO] You can find the built web app in the build\web\ directory
echo [INFO] To test locally, run: serve_web.bat
pause