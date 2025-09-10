import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad_helper.dart';

class AppOpenAdManager {
  static AppOpenAd? _appOpenAd;
  static bool _isShowingAd = false;
  static DateTime? _lastAdShowTime;
  static const Duration _minIntervalBetweenAds = Duration(hours: 1);

  static void loadAppOpenAd() {
    if (_appOpenAd != null) return;

    AppOpenAd.load(
      adUnitId: AdHelper.appOpenAdUnitId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
        },
        onAdFailedToLoad: (error) {
          _appOpenAd = null;
        },
      ),
      orientation: AppOpenAd.orientationPortrait,
    );
  }

  static void showAppOpenAdIfAvailable() {
    if (_appOpenAd == null) {
      loadAppOpenAd();
      return;
    }

    if (_isShowingAd) return;

    // Check if enough time has passed since last ad
    if (_lastAdShowTime != null) {
      final timeSinceLastAd = DateTime.now().difference(_lastAdShowTime!);
      if (timeSinceLastAd < _minIntervalBetweenAds) {
        return;
      }
    }

    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        _lastAdShowTime = DateTime.now();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _isShowingAd = false;
        _appOpenAd = null;
        loadAppOpenAd();
      },
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _isShowingAd = false;
        _appOpenAd = null;
        loadAppOpenAd();
      },
    );

    _appOpenAd!.show();
    _appOpenAd = null;
  }

  static void dispose() {
    _appOpenAd?.dispose();
    _appOpenAd = null;
  }
}

// App lifecycle handler for app open ads
class AppLifecycleReactor extends WidgetsBindingObserver {
  final VoidCallback onAppOpenAdShow;

  AppLifecycleReactor({required this.onAppOpenAdShow});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      onAppOpenAdShow();
    }
  }
}

// Cold start app open ad handler
class ColdStartAppOpenAd {
  static Timer? _coldStartTimer;

  static void handleColdStartAd() {
    // Show ad after 2 seconds of app launch
    _coldStartTimer = Timer(const Duration(seconds: 2), () {
      AppOpenAdManager.showAppOpenAdIfAvailable();
    });
  }

  static void cancelColdStartAd() {
    _coldStartTimer?.cancel();
    _coldStartTimer = null;
  }
}