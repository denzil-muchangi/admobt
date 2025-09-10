import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'AdMob Demo Showcase'**
  String get appTitle;

  /// Welcome message title
  ///
  /// In en, this message translates to:
  /// **'Welcome to AdMob Demo'**
  String get welcomeTitle;

  /// Welcome message subtitle
  ///
  /// In en, this message translates to:
  /// **'Explore all AdMob ad formats in creative ways'**
  String get welcomeSubtitle;

  /// Banner ads section title
  ///
  /// In en, this message translates to:
  /// **'Banner Ads'**
  String get bannerAds;

  /// Native ads section title
  ///
  /// In en, this message translates to:
  /// **'Native Ads'**
  String get nativeAds;

  /// Rewarded ads section title
  ///
  /// In en, this message translates to:
  /// **'Rewarded Ads'**
  String get rewardedAds;

  /// Interstitial ads section title
  ///
  /// In en, this message translates to:
  /// **'Interstitial Ads'**
  String get interstitialAds;

  /// All formats demo section title
  ///
  /// In en, this message translates to:
  /// **'All Ad Formats Demo'**
  String get allFormatsDemo;

  /// Button text to start the demo
  ///
  /// In en, this message translates to:
  /// **'Start Demo'**
  String get startDemo;

  /// Banner ad showcase page title
  ///
  /// In en, this message translates to:
  /// **'Banner Ad Showcase'**
  String get bannerShowcase;

  /// Standard banner description
  ///
  /// In en, this message translates to:
  /// **'Standard Banner'**
  String get standardBanner;

  /// Standard banner description text
  ///
  /// In en, this message translates to:
  /// **'320x50 pixels - Most common format'**
  String get standardBannerDesc;

  /// Large banner title
  ///
  /// In en, this message translates to:
  /// **'Large Banner'**
  String get largeBanner;

  /// Large banner description text
  ///
  /// In en, this message translates to:
  /// **'320x100 pixels - Better visibility'**
  String get largeBannerDesc;

  /// Medium rectangle title
  ///
  /// In en, this message translates to:
  /// **'Medium Rectangle'**
  String get mediumRectangle;

  /// Medium rectangle description text
  ///
  /// In en, this message translates to:
  /// **'300x250 pixels - High engagement'**
  String get mediumRectangleDesc;

  /// Leaderboard title
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get leaderboard;

  /// Leaderboard description text
  ///
  /// In en, this message translates to:
  /// **'728x90 pixels - Tablet optimized'**
  String get leaderboardDesc;

  /// Adaptive banner title
  ///
  /// In en, this message translates to:
  /// **'Adaptive Banner'**
  String get adaptiveBanner;

  /// Adaptive banner description text
  ///
  /// In en, this message translates to:
  /// **'Responsive - Adapts to screen width'**
  String get adaptiveBannerDesc;

  /// Native ad integration page title
  ///
  /// In en, this message translates to:
  /// **'Native Ad Integration'**
  String get nativeIntegration;

  /// Feed native ad title
  ///
  /// In en, this message translates to:
  /// **'Feed Native Ad'**
  String get feedNativeAd;

  /// Feed native ad description
  ///
  /// In en, this message translates to:
  /// **'Seamlessly integrated in content feed'**
  String get feedNativeAdDesc;

  /// Article native ad title
  ///
  /// In en, this message translates to:
  /// **'Article Native Ad'**
  String get articleNativeAd;

  /// Article native ad description
  ///
  /// In en, this message translates to:
  /// **'Looks like part of the article'**
  String get articleNativeAdDesc;

  /// Card native ad title
  ///
  /// In en, this message translates to:
  /// **'Card Native Ad'**
  String get cardNativeAd;

  /// Card native ad description
  ///
  /// In en, this message translates to:
  /// **'Styled as a featured card'**
  String get cardNativeAdDesc;

  /// Custom native ad title
  ///
  /// In en, this message translates to:
  /// **'Custom Native Ad'**
  String get customNativeAd;

  /// Custom native ad description
  ///
  /// In en, this message translates to:
  /// **'Fully customized styling'**
  String get customNativeAdDesc;

  /// Rewarded ad experience page title
  ///
  /// In en, this message translates to:
  /// **'Rewarded Ad Experience'**
  String get rewardedExperience;

  /// Extra lives reward title
  ///
  /// In en, this message translates to:
  /// **'Extra Lives'**
  String get extraLives;

  /// Extra lives reward description
  ///
  /// In en, this message translates to:
  /// **'Watch ad to get 3 extra lives'**
  String get extraLivesDesc;

  /// Premium unlock title
  ///
  /// In en, this message translates to:
  /// **'Premium Unlock'**
  String get premiumUnlock;

  /// Premium unlock description
  ///
  /// In en, this message translates to:
  /// **'Watch ad to unlock premium features'**
  String get premiumUnlockDesc;

  /// Score multiplier title
  ///
  /// In en, this message translates to:
  /// **'Score Multiplier'**
  String get scoreMultiplier;

  /// Score multiplier description
  ///
  /// In en, this message translates to:
  /// **'Watch ad to get 2X score multiplier'**
  String get scoreMultiplierDesc;

  /// Interstitial ad triggers page title
  ///
  /// In en, this message translates to:
  /// **'Interstitial Ad Triggers'**
  String get interstitialTriggers;

  /// Button click trigger title
  ///
  /// In en, this message translates to:
  /// **'Button Click Trigger'**
  String get buttonClickTrigger;

  /// Button click trigger description
  ///
  /// In en, this message translates to:
  /// **'33% chance to show ad when button is clicked'**
  String get buttonClickTriggerDesc;

  /// Time-based trigger title
  ///
  /// In en, this message translates to:
  /// **'Time-Based Trigger'**
  String get timeBasedTrigger;

  /// Time-based trigger description
  ///
  /// In en, this message translates to:
  /// **'Shows ad after 5 seconds'**
  String get timeBasedTriggerDesc;

  /// Manual trigger title
  ///
  /// In en, this message translates to:
  /// **'Manual Trigger'**
  String get manualTrigger;

  /// Manual trigger description
  ///
  /// In en, this message translates to:
  /// **'Force show interstitial ad'**
  String get manualTriggerDesc;

  /// Smart triggers title
  ///
  /// In en, this message translates to:
  /// **'Smart Triggers'**
  String get smartTriggers;

  /// Smart triggers description
  ///
  /// In en, this message translates to:
  /// **'Interstitial ads are intelligently triggered based on user behavior, ensuring optimal user experience while maximizing revenue.'**
  String get smartTriggersDesc;

  /// Complete ad experience page title
  ///
  /// In en, this message translates to:
  /// **'Complete Ad Experience'**
  String get completeExperience;

  /// Experience description text
  ///
  /// In en, this message translates to:
  /// **'This section demonstrates how all ad formats work together in a real app scenario:'**
  String get experienceDesc;

  /// Interactive content title
  ///
  /// In en, this message translates to:
  /// **'Interactive Content'**
  String get interactiveContent;

  /// Unlock content button text
  ///
  /// In en, this message translates to:
  /// **'Unlock Content with Ad'**
  String get unlockContent;

  /// Trigger ad button text
  ///
  /// In en, this message translates to:
  /// **'Trigger Ad'**
  String get triggerAd;

  /// Message shown when ad is not available
  ///
  /// In en, this message translates to:
  /// **'Ad unavailable'**
  String get adUnavailable;

  /// Message when ad is not ready
  ///
  /// In en, this message translates to:
  /// **'Ad not ready yet. Please try again.'**
  String get adNotReady;

  /// Message when rewarded ad is not ready
  ///
  /// In en, this message translates to:
  /// **'Rewarded ad not ready yet. Please try again.'**
  String get rewardedAdNotReady;

  /// Reward earned message
  ///
  /// In en, this message translates to:
  /// **'Congratulations! You earned {amount} {type}!'**
  String congratulations(String amount, String type);

  /// Premium content unlocked message
  ///
  /// In en, this message translates to:
  /// **'Premium content unlocked!'**
  String get premiumContentUnlocked;

  /// Multiplier activated message
  ///
  /// In en, this message translates to:
  /// **'2X multiplier activated!'**
  String get multiplierActivated;

  /// Extra lives added message
  ///
  /// In en, this message translates to:
  /// **'3 extra lives added!'**
  String get extraLivesAdded;

  /// Action completed message
  ///
  /// In en, this message translates to:
  /// **'Action completed!'**
  String get actionCompleted;

  /// Keep scrolling message
  ///
  /// In en, this message translates to:
  /// **'Keep scrolling to trigger interstitial!'**
  String get keepScrolling;

  /// Ad dismissed message
  ///
  /// In en, this message translates to:
  /// **'Ad dismissed'**
  String get adDismissed;

  /// Content unlocked message
  ///
  /// In en, this message translates to:
  /// **'Content unlocked!'**
  String get contentUnlocked;

  /// Premium features activated message
  ///
  /// In en, this message translates to:
  /// **'Premium features activated!'**
  String get premiumFeaturesActivated;

  /// Ad will show message
  ///
  /// In en, this message translates to:
  /// **'Ad will show in 5 seconds...'**
  String get adWillShow;

  /// Exit app dialog title
  ///
  /// In en, this message translates to:
  /// **'Exit App?'**
  String get exitApp;

  /// Exit app dialog message
  ///
  /// In en, this message translates to:
  /// **'Watch a quick ad before you go?'**
  String get watchAdBeforeExit;

  /// Stay button text
  ///
  /// In en, this message translates to:
  /// **'Stay'**
  String get stay;

  /// Exit with ad button text
  ///
  /// In en, this message translates to:
  /// **'Exit with Ad'**
  String get exitWithAd;

  /// Advertisement label
  ///
  /// In en, this message translates to:
  /// **'Advertisement'**
  String get advertisement;

  /// Sponsored label
  ///
  /// In en, this message translates to:
  /// **'Sponsored'**
  String get sponsored;

  /// Featured label
  ///
  /// In en, this message translates to:
  /// **'Featured'**
  String get featured;

  /// Out of lives title
  ///
  /// In en, this message translates to:
  /// **'Out of Lives!'**
  String get outOfLives;

  /// Watch ad for lives message
  ///
  /// In en, this message translates to:
  /// **'Watch an ad to get 3 extra lives!'**
  String get watchAdForLives;

  /// Get extra lives button text
  ///
  /// In en, this message translates to:
  /// **'Get Extra Lives'**
  String get getExtraLives;

  /// Premium content title
  ///
  /// In en, this message translates to:
  /// **'Premium Content'**
  String get premiumContent;

  /// Watch ad for premium message
  ///
  /// In en, this message translates to:
  /// **'Watch an ad to unlock exclusive content!'**
  String get watchAdForPremium;

  /// Watch ad and unlock button text
  ///
  /// In en, this message translates to:
  /// **'Watch Ad & Unlock'**
  String get watchAdUnlock;

  /// Bonus multiplier title
  ///
  /// In en, this message translates to:
  /// **'2X Daily Bonus!'**
  String get bonusMultiplier;

  /// Watch ad for multiplier message
  ///
  /// In en, this message translates to:
  /// **'Watch an ad to double your daily rewards!'**
  String get watchAdForMultiplier;

  /// Activate multiplier button text
  ///
  /// In en, this message translates to:
  /// **'Activate 2X Bonus'**
  String get activateMultiplier;

  /// Lives label
  ///
  /// In en, this message translates to:
  /// **'Lives'**
  String get lives;

  /// Score label
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// Premium label
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premium;

  /// Yes text
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No text
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// Scroll threshold title
  ///
  /// In en, this message translates to:
  /// **'Scroll Threshold'**
  String get scrollThreshold;

  /// Scroll threshold description
  ///
  /// In en, this message translates to:
  /// **'Shows after scrolling 1000px'**
  String get scrollThresholdDesc;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
