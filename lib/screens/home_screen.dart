import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:admobt/ads/banner_ad_widget.dart';
import 'package:admobt/ads/interstitial_ad_manager.dart';
import 'package:admobt/ads/rewarded_ad_manager.dart';
import 'package:admobt/ads/native_ad_widget.dart';
import 'package:admobt/screens/ad_format_demo_screen.dart';
import 'package:admobt/l10n/app_localizations.dart';
import 'package:admobt/widgets/language_selector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Load all ad types
    InterstitialAdManager.loadInterstitialAd();
    RewardedAdManager.loadRewardedAd();

    // Set up scroll trigger for interstitial
    _scrollController.addListener(() {
      if (_scrollController.offset > 1000 &&
          !_scrollController.position.outOfRange) {
        InterstitialAdManager.showInterstitialAd(context: context);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context)?.appTitle ?? 'AdMob Demo Showcase'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          CreativeRewardedAds.coinsDisplay(),
          const LanguageSelector(),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            _buildWelcomeSection(),

            // Banner Ads Section
            _buildSectionHeader(
                AppLocalizations.of(context)?.bannerAds ?? 'Banner Ads',
                Icons.view_array),
            _buildBannerAdsSection(),

            // Native Ads Section
            _buildSectionHeader(
                AppLocalizations.of(context)?.nativeAds ?? 'Native Ads',
                Icons.style),
            _buildNativeAdsSection(),

            // Rewarded Ads Section
            _buildSectionHeader(
                AppLocalizations.of(context)?.rewardedAds ?? 'Rewarded Ads',
                Icons.card_giftcard),
            _buildRewardedAdsSection(),

            // Interstitial Ads Section
            _buildSectionHeader(
                AppLocalizations.of(context)?.interstitialAds ??
                    'Interstitial Ads',
                Icons.fullscreen),
            _buildInterstitialAdsSection(),

            // All Formats Demo
            _buildSectionHeader(
                AppLocalizations.of(context)?.allFormatsDemo ??
                    'All Ad Formats Demo',
                Icons.apps),
            _buildAllFormatsDemoSection(),

            const SizedBox(height: 100), // Space for bottom banner
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AdFormatDemoScreen(),
            ),
          );
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.play_arrow),
      ),
      bottomNavigationBar: BannerAdWidget(
        adSize: AdSize.banner,
        placement: 'bottom_nav',
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)?.welcomeTitle ??
                'Welcome to AdMob Demo',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)?.welcomeSubtitle ??
                'Explore all AdMob ad formats in creative ways',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatCard('Banners', '5 Types', Colors.blue),
              const SizedBox(width: 12),
              _buildStatCard('Interstitial', 'Smart Triggers', Colors.orange),
              const SizedBox(width: 12),
              _buildStatCard('Rewarded', 'Gamified', Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String subtitle, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerAdsSection() {
    return Column(
      children: [
        CreativeBannerAds.inlineContentBanner(),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildBannerTypeCard('Standard', const BannerAdWidget()),
              const SizedBox(width: 12),
              _buildBannerTypeCard(
                  'Large',
                  BannerAdWidget(
                    adSize: AdSize.largeBanner,
                  )),
              const SizedBox(width: 12),
              _buildBannerTypeCard(
                  'Medium',
                  BannerAdWidget(
                    adSize: AdSize.mediumRectangle,
                  )),
              const SizedBox(width: 12),
              _buildBannerTypeCard(
                  'Leaderboard',
                  BannerAdWidget(
                    adSize: AdSize.leaderboard,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBannerTypeCard(String title, Widget adWidget) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Center(child: adWidget)),
        ],
      ),
    );
  }

  Widget _buildNativeAdsSection() {
    return Column(
      children: [
        CreativeNativeAds.feedNativeAd(),
        const SizedBox(height: 16),
        CreativeNativeAds.cardNativeAd(),
        const SizedBox(height: 16),
        CreativeNativeAds.customNativeAd(),
      ],
    );
  }

  Widget _buildRewardedAdsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          CreativeRewardedAds.premiumContentUnlock(
            context: context,
            onContentUnlocked: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Premium content unlocked!')),
              );
            },
          ),
          const SizedBox(height: 16),
          CreativeRewardedAds.dailyRewardMultiplier(
            context: context,
            onMultiplierApplied: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('2X multiplier activated!')),
              );
            },
          ),
          const SizedBox(height: 16),
          CreativeRewardedAds.extraLivesGame(
            context: context,
            onLivesAdded: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('3 extra lives added!')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInterstitialAdsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildTriggerCard(
            'Button Click',
            '33% chance to show ad on button press',
            Icons.touch_app,
            () => CreativeInterstitialTriggers.onButtonClick(
              context,
              () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Action completed!')),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _buildTriggerCard(
            'Scroll Threshold',
            'Shows after scrolling 1000px',
            Icons.swap_vert,
            () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Keep scrolling to trigger interstitial!'),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _buildTriggerCard(
            'Manual Trigger',
            'Force show interstitial ad',
            Icons.play_arrow,
            () => InterstitialAdManager.showInterstitialAd(
              context: context,
              onAdDismissed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTriggerCard(
    String title,
    String description,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple),
        title: Text(title),
        subtitle: Text(description),
        trailing: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
          child: const Text('Trigger'),
        ),
      ),
    );
  }

  Widget _buildAllFormatsDemoSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Icon(Icons.apps, size: 48, color: Colors.deepPurple),
              const SizedBox(height: 16),
              const Text(
                'Interactive Ad Demo',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Experience all ad formats in a controlled environment',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdFormatDemoScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start Demo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
