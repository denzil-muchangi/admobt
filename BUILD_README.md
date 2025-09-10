# Flutter Multi-Platform Build Guide

This Flutter application is configured to build for both **mobile** (Android/iOS) and **web** platforms with separate configurations and build scripts.

## 📁 Project Structure

```
├── lib/
│   ├── main.dart              # Default entry point
│   ├── main_mobile.dart       # Mobile-specific entry point (with AdMob)
│   ├── main_web.dart          # Web-specific entry point (without AdMob)
│   └── widgets/               # Reusable widget components
├── scripts/
│   ├── build_mobile.sh        # Linux/macOS mobile build script
│   ├── build_mobile.bat       # Windows mobile build script
│   ├── build_web.sh          # Linux/macOS web build script
│   └── build_web.bat         # Windows web build script
├── .github/workflows/
│   └── flutter.yml           # GitHub Actions CI/CD pipeline
├── build_config.yaml         # Build configuration settings
└── pubspec.yaml              # Flutter dependencies
```

## 🚀 Quick Start

### Prerequisites

1. **Flutter SDK** (3.2.6 or higher)
2. **Dart SDK** (included with Flutter)
3. **Android Studio** (for Android builds)
4. **Xcode** (for iOS builds, macOS only)

### Platform Setup

#### For Mobile Development:
```bash
# Enable Android/iOS platforms
flutter config --enable-android
flutter config --enable-ios

# Check available devices
flutter devices
```

#### For Web Development:
```bash
# Enable web platform
flutter config --enable-web

# Check available devices
flutter devices
```

## 🏗️ Building the Application

### Option 1: Using Build Scripts (Recommended)

#### Mobile Build (Android & iOS)
```bash
# Linux/macOS
./scripts/build_mobile.sh

# Windows
scripts\build_mobile.bat
```

#### Web Build
```bash
# Linux/macOS
./scripts/build_web.sh

# Windows
scripts\build_web.bat
```

### Option 2: Manual Build Commands

#### Mobile Platforms
```bash
# Clean and prepare
flutter clean
flutter pub get
flutter gen-l10n

# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS (macOS only)
flutter build ios --release --no-codesign
```

#### Web Platform
```bash
# Clean and prepare
flutter clean
flutter pub get
flutter gen-l10n

# Build web app
flutter build web --release

# Serve locally for testing
cd build/web
python3 -m http.server 8080
```

### Option 3: Using Platform-Specific Entry Points

#### Mobile (with AdMob)
```bash
flutter run -t lib/main_mobile.dart
```

#### Web (without AdMob)
```bash
flutter run -d web -t lib/main_web.dart
```

## 🔧 Configuration Files

### build_config.yaml
Contains platform-specific build settings, environment variables, and deployment configurations.

### Platform-Specific Entry Points

#### main_mobile.dart
- Includes AdMob integration
- App lifecycle management for ads
- Optimized for mobile performance

#### main_web.dart
- No AdMob (not supported on web)
- Uses placeholder widgets for ads
- Optimized for web performance

## 📱 Platform Differences

### Mobile (Android/iOS)
- ✅ Full AdMob integration
- ✅ App Open Ads
- ✅ Interstitial Ads
- ✅ Rewarded Ads
- ✅ Native Ads
- ✅ Banner Ads

### Web
- ❌ AdMob not supported (shows placeholders)
- ✅ All UI components work
- ✅ Multi-language support
- ✅ Responsive design
- ✅ PWA capabilities

## 🚀 Deployment

### GitHub Actions (Automatic)
The project includes GitHub Actions workflows that automatically:
- Run tests on every push
- Build for Android, iOS, and Web
- Deploy web version to GitHub Pages

### Manual Deployment

#### Android
```bash
flutter build apk --release
# Upload build/app/outputs/flutter-apk/app-release.apk to Play Store
```

#### iOS
```bash
flutter build ios --release
# Open Xcode and upload to App Store
```

#### Web
```bash
flutter build web --release
# Deploy build/web/ to any static hosting service
```

## 🧪 Testing

### Run Tests
```bash
flutter test
```

### Code Analysis
```bash
flutter analyze
```

### Integration Tests
```bash
flutter drive --target=test_driver/app.dart
```

## 🔧 Troubleshooting

### Common Issues

#### Android Build Fails
```bash
# Clean Gradle cache
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

#### Web Build Fails
```bash
# Enable web support
flutter config --enable-web
flutter clean
flutter pub get
```

#### iOS Build Fails
```bash
# Clean iOS build
flutter clean
cd ios
rm -rf Pods/
rm Podfile.lock
pod install
cd ..
flutter pub get
```

### Platform-Specific Issues

#### AdMob on Web
AdMob doesn't work on web platforms. The app automatically shows placeholder widgets when running on web.

#### iOS Simulator
```bash
# Run on iOS simulator
flutter run -d iphone
```

## 📊 Build Artifacts

After successful builds, artifacts are located in:

- **Android APK**: `build/app/outputs/flutter-apk/app-release.apk`
- **Android Bundle**: `build/app/outputs/bundle/release/app-release.aab`
- **iOS App**: `build/ios/iphoneos/Runner.app`
- **Web App**: `build/web/`

## 🎯 Environment Variables

Configure different environments using build flavors:

```bash
# Development
flutter run --flavor development

# Staging
flutter run --flavor staging

# Production
flutter run --flavor production
```

## 📞 Support

For build issues:
1. Check Flutter doctor: `flutter doctor`
2. Clean and rebuild: `flutter clean && flutter pub get`
3. Check platform setup
4. Review build logs for specific errors

---

**Happy Building! 🚀**