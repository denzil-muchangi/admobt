import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:admobt/ads/app_open_ad_manager.dart';
import 'package:admobt/screens/home_screen.dart';
import 'package:admobt/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize AdMob for mobile platforms
  await MobileAds.instance.initialize();

  // Load app open ad for cold start
  AppOpenAdManager.loadAppOpenAd();
  ColdStartAppOpenAd.handleColdStartAd();

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
      title: 'AdMob Demo Showcase',
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
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
