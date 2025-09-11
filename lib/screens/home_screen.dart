import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:admobt/ads/banner_ad_widget.dart';
import 'package:admobt/ads/interstitial_ad_manager.dart';
import 'package:admobt/ads/rewarded_ad_manager.dart';
import 'package:admobt/ads/native_ad_widget.dart';
import 'package:admobt/screens/ad_format_demo_screen.dart';
import 'package:admobt/l10n/app_localizations.dart';
import 'package:admobt/widgets/language_selector.dart';
import 'package:admobt/widgets/welcome_section.dart';
import 'package:admobt/widgets/section_header.dart';
import 'package:admobt/utils/responsive_utils.dart';

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
    final appBarTitleSize = context.responsiveFontSize(20.0);
    final fabSize = context.responsiveValue(56.0, 64.0, 72.0);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.appTitle ?? 'AdMob Demo Showcase',
          style: TextStyle(fontSize: appBarTitleSize),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          CreativeRewardedAds.coinsDisplay(),
          const LanguageSelector(),
          SizedBox(width: context.responsiveSpacing),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: context.responsivePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            const WelcomeSection(),

            // Banner Ads Section
            SectionHeader(
                title: AppLocalizations.of(context)?.bannerAds ?? 'Banner Ads',
                icon: Icons.view_array),
            _buildBannerAdsSection(),

            // Native Ads Section
            SectionHeader(
                title: AppLocalizations.of(context)?.nativeAds ?? 'Native Ads',
                icon: Icons.style),
            _buildNativeAdsSection(),

            // Rewarded Ads Section
            SectionHeader(
                title:
                    AppLocalizations.of(context)?.rewardedAds ?? 'Rewarded Ads',
                icon: Icons.card_giftcard),
            _buildRewardedAdsSection(),

            // Interstitial Ads Section
            SectionHeader(
                title: AppLocalizations.of(context)?.interstitialAds ??
                    'Interstitial Ads',
                icon: Icons.fullscreen),
            _buildInterstitialAdsSection(),

            // All Formats Demo
            SectionHeader(
                title: AppLocalizations.of(context)?.allFormatsDemo ??
                    'All Ad Formats Demo',
                icon: Icons.apps),
            _buildAllFormatsDemoSection(),

            SizedBox(
                height: context.responsiveValue(
                    80.0, 100.0, 120.0)), // Space for bottom banner
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
        child: Icon(Icons.play_arrow, size: context.responsiveIconSize(24.0)),
      ),
      bottomNavigationBar: const BannerAdWidget(
        adSize: AdSize.banner,
        placement: 'bottom_nav',
      ),
    );
  }

  Widget _buildBannerAdsSection() {
    return Column(
      children: [
        CreativeBannerAds.inlineContentBanner(),
        SizedBox(height: context.responsiveSpacing),
        SizedBox(
          height: context.responsiveValue(80.0, 100.0, 120.0),
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: context.responsivePadding,
            children: [
              _buildBannerTypeCard('Standard', const BannerAdWidget()),
              SizedBox(width: context.responsiveSpacing),
              _buildBannerTypeCard(
                  'Large',
                  const BannerAdWidget(
                    adSize: AdSize.largeBanner,
                  )),
              SizedBox(width: context.responsiveSpacing),
              _buildBannerTypeCard(
                  'Medium',
                  const BannerAdWidget(
                    adSize: AdSize.mediumRectangle,
                  )),
              SizedBox(width: context.responsiveSpacing),
              _buildBannerTypeCard(
                  'Leaderboard',
                  const BannerAdWidget(
                    adSize: AdSize.leaderboard,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBannerTypeCard(String title, Widget adWidget) {
    final cardWidth = context.responsiveValue(120.0, 150.0, 180.0);
    final titleFontSize = context.responsiveFontSize(12.0);
    final borderRadius = context.responsiveBorderRadius;

    return Container(
      width: cardWidth,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Column(
        children: [
          Container(
            padding: context.responsivePadding * 0.5,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(borderRadius)),
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
              ),
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
