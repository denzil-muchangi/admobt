import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:admobt/ads/app_open_ad_manager.dart';
import 'package:admobt/screens/home_screen.dart';
import 'package:admobt/l10n/app_localizations.dart';

// Guard to prevent multiple AdMob initializations
bool _adMobInitialized = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize AdMob with error handling and logging
  if (!_adMobInitialized) {
    try {
      debugPrint('AdMob: Starting initialization...');
      final InitializationStatus status = await MobileAds.instance.initialize();
      debugPrint(
          'AdMob: Initialization completed successfully. Adapter statuses: ${status.adapterStatuses}');
      _adMobInitialized = true;
    } catch (e, stackTrace) {
      debugPrint('AdMob: Initialization failed with error: $e');
      debugPrint('AdMob: Stack trace: $stackTrace');
      // Continue with app startup even if AdMob fails
    }
  } else {
    debugPrint('AdMob: Already initialized, skipping...');
  }

  // Load app open ad for cold start (after AdMob is initialized)
  try {
    AppOpenAdManager.loadAppOpenAd();
    ColdStartAppOpenAd.handleColdStartAd();
  } catch (e) {
    debugPrint('AdMob: Failed to load app open ad: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final AppLifecycleReactor _appLifecycleReactor = AppLifecycleReactor(
    onAppOpenAdShow: () {
      AppOpenAdManager.showAppOpenAdIfAvailable();
    },
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(_appLifecycleReactor);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_appLifecycleReactor);
    AppOpenAdManager.dispose();
    ColdStartAppOpenAd.cancelColdStartAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppLocalizations.of(context)?.appTitle ?? 'AdMob Demo Showcase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('es'), // Spanish
        Locale('fr'), // French
        Locale('de'), // German
      ],
    );
  }
}
