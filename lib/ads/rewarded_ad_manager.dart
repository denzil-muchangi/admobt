import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad_helper.dart';

class RewardedAdManager {
  static RewardedAd? _rewardedAd;
  static bool _isAdLoaded = false;
  static int _coins = 0;

  static int get coins => _coins;

  static void loadRewardedAd() {
    if (_isAdLoaded) return;

    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
          _isAdLoaded = true;
          
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _rewardedAd = null;
              _isAdLoaded = false;
              loadRewardedAd(); // Preload next ad
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _rewardedAd = null;
              _isAdLoaded = false;
              loadRewardedAd();
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          _rewardedAd = null;
          _isAdLoaded = false;
        },
      ),
    );
  }

  static void showRewardedAd({
    required BuildContext context,
    required String rewardType,
    required int rewardAmount,
    required VoidCallback onRewardEarned,
  }) {
    if (_isAdLoaded && _rewardedAd != null) {
      _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          _coins += rewardAmount;
          onRewardEarned();
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Congratulations! You earned $rewardAmount $rewardType!',
              ),
              backgroundColor: Colors.green,
            ),
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Rewarded ad not ready yet. Please try again.'),
          backgroundColor: Colors.orange,
        ),
      );
      loadRewardedAd();
    }
  }

  static void dispose() {
    _rewardedAd?.dispose();
    _rewardedAd = null;
    _isAdLoaded = false;
  }
}

// Creative rewarded ad implementations
class CreativeRewardedAds {
  // Unlock premium content
  static Widget premiumContentUnlock({
    required BuildContext context,
    required VoidCallback onContentUnlocked,
  }) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Icon(Icons.star, size: 48, color: Colors.amber),
            const SizedBox(height: 8),
            const Text(
              'Premium Content',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Watch an ad to unlock exclusive content!'),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => RewardedAdManager.showRewardedAd(
                context: context,
                rewardType: 'stars',
                rewardAmount: 50,
                onRewardEarned: onContentUnlocked,
              ),
              icon: const Icon(Icons.play_arrow),
              label: const Text('Watch Ad & Unlock'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Daily reward multiplier
  static Widget dailyRewardMultiplier({
    required BuildContext context,
    required VoidCallback onMultiplierApplied,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.purple, Colors.deepPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              '2X Daily Bonus!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Watch an ad to double your daily rewards!',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => RewardedAdManager.showRewardedAd(
                context: context,
                rewardType: 'bonus multiplier',
                rewardAmount: 2,
                onRewardEarned: onMultiplierApplied,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.purple,
              ),
              child: const Text('Activate 2X Bonus'),
            ),
          ],
        ),
      ),
    );
  }

  // Extra lives in game
  static Widget extraLivesGame({
    required BuildContext context,
    required VoidCallback onLivesAdded,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite, color: Colors.red, size: 30),
                SizedBox(width: 8),
                Text(
                  'Out of Lives!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text('Watch an ad to get 3 extra lives!'),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => RewardedAdManager.showRewardedAd(
                context: context,
                rewardType: 'lives',
                rewardAmount: 3,
                onRewardEarned: onLivesAdded,
              ),
              icon: const Icon(Icons.favorite),
              label: const Text('Get Extra Lives'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Coins display widget
  static Widget coinsDisplay() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.monetization_on, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            '${RewardedAdManager.coins}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}