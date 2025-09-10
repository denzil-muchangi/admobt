import 'package:flutter/material.dart';
import 'package:admobt/ads/banner_ad_widget.dart';
import 'package:admobt/ads/interstitial_ad_manager.dart';
import 'package:admobt/ads/rewarded_ad_manager.dart';
import 'package:admobt/ads/native_ad_widget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:admobt/widgets/game_stats.dart';
import 'package:admobt/widgets/bottom_navigation.dart';

class AdFormatDemoScreen extends StatefulWidget {
  const AdFormatDemoScreen({super.key});

  @override
  State<AdFormatDemoScreen> createState() => _AdFormatDemoScreenState();
}

class _AdFormatDemoScreenState extends State<AdFormatDemoScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isPremiumUnlocked = false;
  int _lives = 5;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    // Ensure all ads are loaded
    InterstitialAdManager.loadInterstitialAd();
    RewardedAdManager.loadRewardedAd();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ad Format Interactive Demo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (page) {
          setState(() {
            _currentPage = page;
          });
          // Show interstitial every 3 page changes
          if (page % 3 == 2) {
            InterstitialAdManager.showInterstitialAd(context: context);
          }
        },
        children: [
          _buildBannerAdDemo(),
          _buildNativeAdDemo(),
          _buildRewardedAdDemo(),
          _buildInterstitialAdDemo(),
          _buildCombinedDemo(),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        currentPage: _currentPage,
        totalPages: 5,
        onPageChanged: (page) {
          setState(() {
            _currentPage = page;
          });
          // Show interstitial every 3 page changes
          if (page % 3 == 2) {
            InterstitialAdManager.showInterstitialAd(context: context);
          }
        },
      ),
    );
  }

  Widget _buildBannerAdDemo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Banner Ad Showcase',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildDemoCard(
            'Standard Banner',
            '320x50 pixels - Most common format',
            const BannerAdWidget(),
          ),
          _buildDemoCard(
            'Large Banner',
            '320x100 pixels - Better visibility',
            const BannerAdWidget(adSize: AdSize.largeBanner),
          ),
          _buildDemoCard(
            'Medium Rectangle',
            '300x250 pixels - High engagement',
            const BannerAdWidget(adSize: AdSize.mediumRectangle),
          ),
          _buildDemoCard(
            'Leaderboard',
            '728x90 pixels - Tablet optimized',
            const BannerAdWidget(adSize: AdSize.leaderboard),
          ),
          _buildDemoCard(
            'Adaptive Banner',
            'Responsive - Adapts to screen width',
            const BannerAdWidget(),
          ),
        ],
      ),
    );
  }

  Widget _buildNativeAdDemo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Native Ad Integration',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildDemoCard(
            'Feed Native Ad',
            'Seamlessly integrated in content feed',
            CreativeNativeAds.feedNativeAd(),
          ),
          _buildDemoCard(
            'Article Native Ad',
            'Looks like part of the article',
            CreativeNativeAds.articleNativeAd(),
          ),
          _buildDemoCard(
            'Card Native Ad',
            'Styled as a featured card',
            CreativeNativeAds.cardNativeAd(),
          ),
          _buildDemoCard(
            'Custom Native Ad',
            'Fully customized styling',
            CreativeNativeAds.customNativeAd(),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardedAdDemo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rewarded Ad Experience',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          GameStats(
            lives: _lives,
            score: _score,
            isPremiumUnlocked: _isPremiumUnlocked,
          ),
          const SizedBox(height: 20),
          _buildDemoCard(
            'Extra Lives',
            'Watch ad to get 3 extra lives',
            CreativeRewardedAds.extraLivesGame(
              context: context,
              onLivesAdded: () {
                setState(() {
                  _lives += 3;
                });
              },
            ),
          ),
          _buildDemoCard(
            'Premium Unlock',
            'Watch ad to unlock premium features',
            CreativeRewardedAds.premiumContentUnlock(
              context: context,
              onContentUnlocked: () {
                setState(() {
                  _isPremiumUnlocked = true;
                });
              },
            ),
          ),
          _buildDemoCard(
            'Score Multiplier',
            'Watch ad to get 2X score multiplier',
            CreativeRewardedAds.dailyRewardMultiplier(
              context: context,
              onMultiplierApplied: () {
                setState(() {
                  _score *= 2;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterstitialAdDemo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Interstitial Ad Triggers',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildTriggerDemo(
            'Button Click Trigger',
            '33% chance to show ad when button is clicked',
            Icons.touch_app,
            () => CreativeInterstitialTriggers.onButtonClick(
              context,
              () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Action completed successfully!')),
              ),
            ),
          ),
          _buildTriggerDemo(
            'Time-Based Trigger',
            'Shows ad after 5 seconds',
            Icons.timer,
            () {
              CreativeInterstitialTriggers.triggerAfterTime(
                context,
                const Duration(seconds: 5),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ad will show in 5 seconds...')),
              );
            },
          ),
          _buildTriggerDemo(
            'Manual Trigger',
            'Force show interstitial ad',
            Icons.play_arrow,
            () => InterstitialAdManager.showInterstitialAd(
              context: context,
              onAdDismissed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ad dismissed')),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(Icons.info, color: Colors.blue, size: 48),
                  SizedBox(height: 8),
                  Text(
                    'Smart Triggers',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Interstitial ads are intelligently triggered based on user behavior, ensuring optimal user experience while maximizing revenue.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTriggerDemo(
      String title, String description, IconData icon, VoidCallback onPressed) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.deepPurple),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onPressed,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Trigger Ad'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCombinedDemo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Complete Ad Experience',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          const Text(
            'This section demonstrates how all ad formats work together in a real app scenario:',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),

          // Banner at top
          const Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: BannerAdWidget(),
            ),
          ),

          const SizedBox(height: 16),

          // Native ad in content
          CreativeNativeAds.feedNativeAd(),

          const SizedBox(height: 16),

          // Interactive content
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'Interactive Content',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => InterstitialAdManager.showInterstitialAd(
                      context: context,
                      onAdDismissed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Content unlocked!')),
                        );
                      },
                    ),
                    child: const Text('Unlock Content with Ad'),
                  ),
                  const SizedBox(height: 16),
                  CreativeRewardedAds.premiumContentUnlock(
                    context: context,
                    onContentUnlocked: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Premium features activated!')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Banner at bottom
          const Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: BannerAdWidget(adSize: AdSize.largeBanner),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemoCard(String title, String description, Widget adWidget) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: adWidget,
            ),
          ],
        ),
      ),
    );
  }
}
