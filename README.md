# 🎯 AdMob Demo Showcase

A comprehensive Flutter application demonstrating all AdMob ad formats with multi-language support, modular architecture, and cross-platform compatibility (Android, iOS, Web).

[![Flutter](https://img.shields.io/badge/Flutter-3.24.0-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.2.6-blue.svg)](https://dart.dev/)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-green.svg)](https://flutter.dev/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## 📋 Table of Contents

- [🎯 Overview](#-overview)
- [✨ Features](#-features)
- [🏗️ Architecture](#️-architecture)
- [🚀 Quick Start](#-quick-start)
- [📱 Platform Support](#-platform-support)
- [🛠️ Development Setup](#️-development-setup)
- [📂 Project Structure](#-project-structure)
- [🎨 UI Components](#-ui-components)
- [🌍 Internationalization](#-internationalization)
- [📢 AdMob Integration](#-admob-integration)
- [🔧 Build & Deployment](#-build--deployment)
- [🧪 Testing](#-testing)
- [📚 API Reference](#-api-reference)
- [🚀 Adding New Features](#-adding-new-features)
- [🔍 Troubleshooting](#-troubleshooting)
- [🤝 Contributing](#-contributing)
- [📄 License](#-license)

## 🎯 Overview

This Flutter application serves as a comprehensive showcase for Google AdMob integration, featuring:

- **All AdMob Ad Formats**: Banner, Interstitial, Rewarded, Native, and App Open ads
- **Multi-Language Support**: English, Spanish, French, German
- **Cross-Platform**: Android, iOS, and Web with platform-specific optimizations
- **Modular Architecture**: Reusable widget components and clean separation of concerns
- **CI/CD Ready**: GitHub Actions for automated testing and deployment

Perfect for developers learning AdMob integration or building ad-supported Flutter apps.

## ✨ Features

### 🎯 Core Features
- ✅ **Complete AdMob Integration** - All ad formats supported
- ✅ **Multi-Language Support** - 4 languages with easy expansion
- ✅ **Cross-Platform** - Android, iOS, Web compatibility
- ✅ **Modular Widgets** - Reusable, customizable components
- ✅ **Responsive Design** - Works on all screen sizes
- ✅ **Dark/Light Theme** - System theme support

### 📢 Ad Formats Demonstrated
- **Banner Ads**: Standard, Large, Medium Rectangle, Leaderboard
- **Interstitial Ads**: Smart triggers and manual placement
- **Rewarded Ads**: Gamified experiences with rewards
- **Native Ads**: Custom styling and integration
- **App Open Ads**: Cold start monetization

### 🎨 UI/UX Features
- **Material Design 3** - Modern, consistent design
- **Custom Animations** - Smooth transitions and interactions
- **Accessibility** - Screen reader support and keyboard navigation
- **Performance Optimized** - Lazy loading and efficient rendering

## 🏗️ Architecture

### 📊 Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    Presentation Layer                       │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │                 Screens (UI Logic)                      │  │
│  │  • HomeScreen - Main app interface                     │  │
│  │  • AdFormatDemoScreen - Interactive demos              │  │
│  └─────────────────────────────────────────────────────────┘  │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │              Widgets (Reusable Components)             │  │
│  │  • WelcomeSection - Hero section with stats            │  │
│  │  • SectionHeader - Consistent section styling          │  │
│  │  • DemoCard - Demo content containers                  │  │
│  │  • PlatformBannerAd - Cross-platform ad handling      │  │
│  └─────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────┐
│                   Business Logic Layer                      │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │              Ad Management Services                     │  │
│  │  • BannerAdManager - Banner ad lifecycle               │  │
│  │  • InterstitialAdManager - Interstitial ad handling    │  │
│  │  • RewardedAdManager - Rewarded ad management          │  │
│  │  • AppOpenAdManager - App open ad logic                │  │
│  └─────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────┐
│                     Data Layer                              │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │              Configuration & Assets                     │  │
│  │  • AdHelper - Ad unit IDs and constants                │  │
│  │  • AppLocalizations - Multi-language strings           │  │
│  │  • BuildConfig - Platform-specific settings            │  │
│  └─────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

### 🏛️ Design Patterns Used

- **Widget Composition**: Building complex UIs from simple, reusable widgets
- **Provider Pattern**: State management for language and theme switching
- **Factory Pattern**: Platform-specific widget creation
- **Observer Pattern**: Ad lifecycle event handling
- **Strategy Pattern**: Different ad loading strategies

### 📦 State Management

- **InheritedWidget**: For localization and theme access
- **StatefulWidget**: For component-specific state
- **Static Variables**: For simple service state (ad managers)
- **Platform Channels**: For native platform communication

## 🚀 Quick Start

### Prerequisites

- **Flutter SDK** (3.2.6 or higher)
- **Dart SDK** (included with Flutter)
- **Android Studio** (for Android development)
- **Xcode** (for iOS development, macOS only)
- **VS Code** or **Android Studio** (recommended IDEs)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/admob-demo.git
   cd admob-demo
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate localization files**
   ```bash
   flutter gen-l10n
   ```

4. **Run the app**
   ```bash
   # For mobile (with AdMob)
   flutter run -t lib/main_mobile.dart

   # For web (without AdMob)
   flutter run -d web -t lib/main_web.dart
   ```

## 📱 Platform Support

### Android
- ✅ **Minimum SDK**: API 21 (Android 5.0)
- ✅ **Target SDK**: API 34 (Android 14)
- ✅ **Full AdMob Support**: All ad formats
- ✅ **Google Play Services**: Required for AdMob

### iOS
- ✅ **Minimum iOS Version**: 12.0
- ✅ **Full AdMob Support**: All ad formats
- ✅ **App Store Ready**: Production deployment ready

### Web
- ✅ **Modern Browsers**: Chrome, Firefox, Safari, Edge
- ✅ **PWA Support**: Installable web app
- ✅ **Responsive Design**: Mobile and desktop optimized
- ⚠️ **AdMob Limitations**: Shows placeholders (AdMob doesn't support web)

## 🛠️ Development Setup

### 1. Environment Setup

```bash
# Check Flutter installation
flutter doctor

# Enable platforms
flutter config --enable-web
flutter config --enable-android
flutter config --enable-ios
```

### 2. IDE Configuration

#### VS Code (Recommended)
- Install Flutter extension
- Install Dart extension
- Configure launch.json for debugging

#### Android Studio
- Install Flutter plugin
- Install Dart plugin
- Configure AVD for testing

### 3. AdMob Setup

1. **Create AdMob Account**: https://admob.google.com
2. **Create App**: Add Android/iOS apps
3. **Create Ad Units**: Banner, Interstitial, Rewarded, Native
4. **Update Ad Unit IDs**: Edit `lib/ads/ad_helper.dart`
5. **Test Mode**: Use test IDs for development

### 4. Localization Setup

```bash
# Generate localization files
flutter gen-l10n

# Add new language
# 1. Create app_xx.arb file in lib/l10n/
# 2. Add translations
# 3. Update supportedLocales in main files
# 4. Run flutter gen-l10n
```

## 📂 Project Structure

```
admob-demo/
├── android/                    # Android platform code
├── ios/                       # iOS platform code
├── lib/                       # Flutter source code
│   ├── ads/                   # AdMob integration
│   │   ├── ad_helper.dart     # Ad unit IDs and constants
│   │   ├── app_open_ad_manager.dart
│   │   ├── banner_ad_widget.dart
│   │   ├── interstitial_ad_manager.dart
│   │   ├── native_ad_widget.dart
│   │   └── rewarded_ad_manager.dart
│   ├── l10n/                  # Localization files
│   │   ├── app_en.arb         # English translations
│   │   ├── app_es.arb         # Spanish translations
│   │   ├── app_fr.arb         # French translations
│   │   ├── app_de.arb         # German translations
│   │   └── app_localizations.dart # Generated localization class
│   ├── screens/               # Screen widgets
│   │   ├── home_screen.dart   # Main home screen
│   │   └── ad_format_demo_screen.dart
│   ├── widgets/               # Reusable UI components
│   │   ├── banner_ad_placeholder.dart
│   │   ├── banner_type_card.dart
│   │   ├── bottom_navigation.dart
│   │   ├── demo_card.dart
│   │   ├── game_stats.dart
│   │   ├── language_selector.dart
│   │   ├── platform_banner_ad.dart
│   │   ├── section_header.dart
│   │   ├── stat_card.dart
│   │   ├── stat_item.dart
│   │   ├── trigger_card.dart
│   │   └── welcome_section.dart
│   ├── main.dart              # Default entry point
│   ├── main_mobile.dart       # Mobile entry point
│   └── main_web.dart          # Web entry point
├── scripts/                   # Build scripts
│   ├── build_mobile.sh        # Linux/macOS mobile build
│   ├── build_mobile.bat       # Windows mobile build
│   ├── build_web.sh          # Linux/macOS web build
│   └── build_web.bat         # Windows web build
├── test/                     # Unit and widget tests
├── web/                      # Web platform files
├── .github/                  # GitHub Actions CI/CD
│   └── workflows/
│       └── flutter.yml       # CI/CD pipeline
├── analysis_options.yaml     # Code analysis config
├── build_config.yaml         # Build configuration
├── BUILD_README.md           # Build documentation
├── pubspec.yaml              # Flutter dependencies
└── README.md                 # This file
```

## 🎨 UI Components

### Core Widgets

#### WelcomeSection
```dart
const WelcomeSection()
// Displays app title, subtitle, and feature stats
// Automatically localized
```

#### SectionHeader
```dart
SectionHeader(
  title: "Banner Ads",
  icon: Icons.view_array,
  iconColor: Colors.deepPurple,
)
// Consistent section headers with icon and title
```

#### DemoCard
```dart
DemoCard(
  title: "Banner Ad Demo",
  description: "320x50 pixels - Most common format",
  adWidget: const BannerAdWidget(),
)
// Standardized demo content containers
```

#### PlatformBannerAd
```dart
const PlatformBannerAd(
  adSize: AdSize.banner,
  placement: 'bottom_nav',
)
// Automatically chooses real AdMob or placeholder based on platform
```

### Ad Management Widgets

#### BannerAdWidget
```dart
BannerAdWidget(
  adSize: AdSize.largeBanner,
  placement: 'hero_section',
)
// Handles banner ad lifecycle and display
```

#### CreativeBannerAds
```dart
// Static methods for different banner implementations
CreativeBannerAds.inlineContentBanner()
CreativeBannerAds.stickyBottomBanner(...)
CreativeBannerAds.collapsibleBanner(...)
```

#### InterstitialAdManager
```dart
// Static methods for interstitial ads
InterstitialAdManager.loadInterstitialAd()
InterstitialAdManager.showInterstitialAd(context: context)
```

#### RewardedAdManager
```dart
RewardedAdManager.showRewardedAd(
  context: context,
  rewardType: 'coins',
  rewardAmount: 50,
  onRewardEarned: () => print('Reward earned!'),
)
```

### Utility Widgets

#### LanguageSelector
```dart
const LanguageSelector()
// Dropdown for language switching
```

#### BottomNavigation
```dart
BottomNavigation(
  currentPage: _currentPage,
  totalPages: 5,
  onPageChanged: (page) => setState(() => _currentPage = page),
)
// Custom page navigation for demos
```

## 🌍 Internationalization

### Supported Languages
- 🇺🇸 **English** (`en`) - Base language
- 🇪🇸 **Spanish** (`es`) - Complete translations
- 🇫🇷 **French** (`fr`) - Complete translations
- 🇩🇪 **German** (`de`) - Complete translations

### Adding New Languages

1. **Create ARB file**: `lib/l10n/app_xx.arb`
2. **Add translations**:
   ```json
   {
     "appTitle": "AdMob Demo",
     "welcomeTitle": "Welcome to AdMob Demo",
     "@appTitle": {
       "description": "Application title"
     }
   }
   ```
3. **Update main files**: Add to `supportedLocales`
4. **Generate files**: `flutter gen-l10n`

### Using Localized Strings

```dart
// In widget build method
Text(AppLocalizations.of(context)?.appTitle ?? 'AdMob Demo')

// With parameters
Text(AppLocalizations.of(context)?.rewardMessage('50') ?? 'Earned 50 coins')
```

## 📢 AdMob Integration

### Ad Unit IDs Configuration

Edit `lib/ads/ad_helper.dart`:
```dart
class AdHelper {
  static String get bannerAdUnitId {
    // Use test IDs for development
    return 'ca-app-pub-3940256099942544/6300978111';
    // Use your production IDs for release
    // return 'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY';
  }
}
```

### Test vs Production IDs

**Test IDs** (use during development):
- Banner: `ca-app-pub-3940256099942544/6300978111`
- Interstitial: `ca-app-pub-3940256099942544/1033173712`
- Rewarded: `ca-app-pub-3940256099942544/5224354917`

**Production IDs**: Get from AdMob console after app verification.

### Platform-Specific Handling

The app automatically handles platform differences:

- **Mobile**: Full AdMob integration
- **Web**: Placeholder widgets (AdMob doesn't support web)

### Ad Lifecycle Management

```dart
// Load ads
InterstitialAdManager.loadInterstitialAd();
RewardedAdManager.loadRewardedAd();

// Show ads with callbacks
InterstitialAdManager.showInterstitialAd(
  context: context,
  onAdDismissed: () => print('Ad dismissed'),
);

// Handle rewards
RewardedAdManager.showRewardedAd(
  context: context,
  rewardType: 'coins',
  rewardAmount: 100,
  onRewardEarned: () => addCoins(100),
);
```

## 🔧 Build & Deployment

### Development Builds

```bash
# Run with hot reload
flutter run

# Run specific platform
flutter run -d android
flutter run -d ios
flutter run -d web

# Run with specific entry point
flutter run -t lib/main_mobile.dart  # Mobile with AdMob
flutter run -t lib/main_web.dart     # Web without AdMob
```

### Production Builds

#### Android
```bash
flutter build apk --release          # APK
flutter build appbundle --release    # App Bundle
```

#### iOS
```bash
flutter build ios --release
```

#### Web
```bash
flutter build web --release
```

### Automated Builds

Use the provided build scripts:

```bash
# Mobile build
./scripts/build_mobile.sh    # Linux/macOS
scripts\build_mobile.bat     # Windows

# Web build
./scripts/build_web.sh       # Linux/macOS
scripts\build_web.bat        # Windows
```

### CI/CD with GitHub Actions

The project includes GitHub Actions that:
- ✅ Run tests on every push
- ✅ Build for Android, iOS, and Web
- ✅ Upload build artifacts
- ✅ Deploy web version to GitHub Pages

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Widget Tests
```dart
void main() {
  testWidgets('WelcomeSection displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: WelcomeSection()));
    expect(find.text('Welcome to AdMob Demo'), findsOneWidget);
  });
}
```

### Integration Tests
```bash
flutter drive --target=test_driver/app.dart
```

### Code Analysis
```bash
flutter analyze
```

## 📚 API Reference

### Key Classes

#### AdHelper
```dart
class AdHelper {
  static String get bannerAdUnitId;
  static String get interstitialAdUnitId;
  static String get rewardedAdUnitId;
  static String get nativeAdUnitId;
  static String get appOpenAdUnitId;
}
```

#### AppLocalizations
```dart
class AppLocalizations {
  static AppLocalizations? of(BuildContext context);
  String get appTitle;
  String get welcomeTitle;
  String welcomeSubtitle;
  String rewardMessage(String amount);
}
```

#### PlatformBannerAd
```dart
class PlatformBannerAd extends StatelessWidget {
  const PlatformBannerAd({
    super.key,
    this.adSize,
    this.placement = 'default',
  });
}
```

## 🚀 Adding New Features

### 1. Adding New Ad Formats

1. **Create Ad Manager**:
   ```dart
   class NewAdManager {
     static void loadNewAd() {
       // Implementation
     }

     static void showNewAd({
       required BuildContext context,
       VoidCallback? onAdCompleted,
     }) {
       // Implementation
     }
   }
   ```

2. **Create Widget**:
   ```dart
   class NewAdWidget extends StatefulWidget {
     const NewAdWidget({super.key});

     @override
     State<NewAdWidget> createState() => _NewAdWidgetState();
   }
   ```

3. **Add to Screens**: Update home_screen.dart and ad_format_demo_screen.dart

### 2. Adding New Languages

1. **Create ARB file**: `lib/l10n/app_xx.arb`
2. **Add translations** for all existing keys
3. **Update main files**:
   ```dart
   supportedLocales: const [
     Locale('en'),
     Locale('es'),
     Locale('fr'),
     Locale('de'),
     Locale('xx'), // New language
   ],
   ```
4. **Run**: `flutter gen-l10n`

### 3. Adding New Widgets

1. **Create Widget File**: `lib/widgets/new_widget.dart`
2. **Follow Patterns**:
   - Use proper state management
   - Support localization
   - Handle platform differences
   - Include proper documentation

3. **Update Exports**: Add to relevant screen imports

### 4. Adding New Screens

1. **Create Screen**: `lib/screens/new_screen.dart`
2. **Navigation**: Add to existing navigation logic
3. **Localization**: Add screen-specific strings to ARB files

## 🔍 Troubleshooting

### Common Issues

#### Build Fails
```bash
flutter clean
flutter pub get
flutter pub cache repair
```

#### AdMob Not Loading
- Check internet connection
- Verify ad unit IDs
- Check AdMob console for errors
- Use test IDs for development

#### Localization Not Working
```bash
flutter gen-l10n
flutter clean
flutter run
```

#### Web Build Issues
```bash
flutter config --enable-web
flutter clean
flutter pub get
```

#### iOS Build Issues
```bash
cd ios
rm -rf Pods/
pod install
cd ..
flutter clean
flutter pub get
```

### Platform-Specific Issues

#### Android
- Ensure Google Play Services is installed
- Check AndroidManifest.xml permissions
- Verify minSdkVersion compatibility

#### iOS
- Ensure iOS deployment target is correct
- Check Info.plist for required permissions
- Verify code signing setup

#### Web
- AdMob doesn't work on web (shows placeholders)
- Ensure modern browser support
- Check CORS settings for assets

### Debug Mode

```bash
# Enable debug logging
flutter run --debug

# Check platform information
flutter doctor -v

# Analyze app size
flutter build apk --analyze-size
```

## 🤝 Contributing

### Development Workflow

1. **Fork** the repository
2. **Create** a feature branch: `git checkout -b feature/new-feature`
3. **Make** your changes
4. **Test** thoroughly:
   ```bash
   flutter test
   flutter analyze
   ```
5. **Commit** with clear messages:
   ```bash
   git commit -m "feat: add new ad format support"
   ```
6. **Push** to your branch: `git push origin feature/new-feature`
7. **Create** a Pull Request

### Code Standards

- **Flutter Analyze**: Must pass with no errors
- **Test Coverage**: Add tests for new features
- **Documentation**: Update README for significant changes
- **Localization**: Add strings to all language files

### Commit Message Format

```
type(scope): description

Types:
- feat: New feature
- fix: Bug fix
- docs: Documentation
- style: Code style
- refactor: Code refactoring
- test: Testing
- chore: Maintenance
```

### Pull Request Guidelines

- **Title**: Clear, descriptive title
- **Description**: What changes and why
- **Screenshots**: For UI changes
- **Testing**: How to test the changes
- **Breaking Changes**: Clearly marked

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Google AdMob** for comprehensive documentation
- **Flutter Team** for excellent framework
- **Material Design** for design system
- **Open Source Community** for inspiration and tools

---

**Happy Coding! 🚀**

Built with ❤️ using Flutter and AdMob
