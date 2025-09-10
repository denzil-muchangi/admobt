import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad_helper.dart';

class InterstitialAdManager {
  static InterstitialAd? _interstitialAd;
  static bool _isAdLoaded = false;
  static int _failedLoadAttempts = 0;
  static const int maxFailedLoadAttempts = 3;

  static void loadInterstitialAd() {
    if (_isAdLoaded) return;

    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _isAdLoaded = true;
          _failedLoadAttempts = 0;
          
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _interstitialAd = null;
              _isAdLoaded = false;
              loadInterstitialAd(); // Preload next ad
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _interstitialAd = null;
              _isAdLoaded = false;
              loadInterstitialAd();
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          _failedLoadAttempts++;
          _interstitialAd = null;
          _isAdLoaded = false;
          
          if (_failedLoadAttempts < maxFailedLoadAttempts) {
            loadInterstitialAd();
          }
        },
      ),
    );
  }

  static void showInterstitialAd({
    required BuildContext context,
    VoidCallback? onAdDismissed,
  }) {
    if (_isAdLoaded && _interstitialAd != null) {
      _interstitialAd!.show();
      onAdDismissed?.call();
    } else {
      // If ad not loaded, show a message and try to load
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ad not ready yet. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
      loadInterstitialAd();
    }
  }

  static void dispose() {
    _interstitialAd?.dispose();
    _interstitialAd = null;
    _isAdLoaded = false;
  }
}

// Creative interstitial triggers
class CreativeInterstitialTriggers {
  // Trigger after specific actions
  static void onButtonClick(BuildContext context, VoidCallback onAction) {
    final random = DateTime.now().millisecond;
    if (random % 3 == 0) { // 33% chance to show ad
      InterstitialAdManager.showInterstitialAd(
        context: context,
        onAdDismissed: onAction,
      );
    } else {
      onAction();
    }
  }

  // Trigger on app exit attempt
  static Future<bool> onWillPop(BuildContext context) async {
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App?'),
        content: const Text('Watch a quick ad before you go?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Stay'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
              InterstitialAdManager.showInterstitialAd(
                context: context,
                onAdDismissed: () => Navigator.pop(context, true),
              );
            },
            child: const Text('Exit with Ad'),
          ),
        ],
      ),
    );
    return shouldPop ?? false;
  }

  // Trigger after time spent
  static void triggerAfterTime(BuildContext context, Duration duration) {
    Future.delayed(duration, () {
      if (context.mounted) {
        InterstitialAdManager.showInterstitialAd(context: context);
      }
    });
  }

  // Trigger on scroll threshold
  static void triggerOnScroll(
    BuildContext context,
    ScrollController controller,
    double threshold,
  ) {
    controller.addListener(() {
      if (controller.offset >= threshold &&
          !controller.position.outOfRange) {
        InterstitialAdManager.showInterstitialAd(context: context);
        controller.removeListener(() {}); // Remove listener after trigger
      }
    });
  }
}