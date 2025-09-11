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
      padding: context.responsivePadding,
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
          SizedBox(height: context.responsiveSpacing),
          CreativeRewardedAds.dailyRewardMultiplier(
            context: context,
            onMultiplierApplied: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('2X multiplier activated!')),
              );
            },
          ),
          SizedBox(height: context.responsiveSpacing),
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
      padding: context.responsivePadding,
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
          SizedBox(height: context.responsiveSpacing),
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
          SizedBox(height: context.responsiveSpacing),
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
    final iconSize = context.responsiveIconSize(24.0);
    final titleFontSize = context.responsiveFontSize(16.0);
    final subtitleFontSize = context.responsiveFontSize(14.0);
    final buttonFontSize = context.responsiveFontSize(14.0);

    return Card(
      elevation: context.responsiveElevation,
      margin: context.responsiveMargin,
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple, size: iconSize),
        title: Text(
          title,
          style: TextStyle(fontSize: titleFontSize),
        ),
        subtitle: Text(
          description,
          style: TextStyle(fontSize: subtitleFontSize),
        ),
        trailing: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            padding: context.responsiveButtonPadding,
          ),
          child: Text(
            'Trigger',
            style: TextStyle(fontSize: buttonFontSize),
          ),
        ),
      ),
    );
  }

  Widget _buildAllFormatsDemoSection() {
    final iconSize = context.responsiveIconSize(48.0);
    final titleFontSize = context.responsiveFontSize(20.0);
    final subtitleFontSize = context.responsiveFontSize(16.0);
    final buttonFontSize = context.responsiveFontSize(16.0);

    return Padding(
      padding: context.responsivePadding,
      child: Card(
        elevation: context.responsiveElevation,
        child: Padding(
          padding: context.responsivePadding * 2,
          child: Column(
            children: [
              Icon(Icons.apps, size: iconSize, color: Colors.deepPurple),
              SizedBox(height: context.responsiveSpacing),
              Text(
                'Interactive Ad Demo',
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: context.responsiveSpacing * 0.5),
              Text(
                'Experience all ad formats in a controlled environment',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: subtitleFontSize,
                ),
              ),
              SizedBox(height: context.responsiveSpacing * 2),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdFormatDemoScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.play_arrow,
                    size: context.responsiveIconSize(24.0)),
                label: Text(
                  'Start Demo',
                  style: TextStyle(fontSize: buttonFontSize),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: context.responsiveButtonPadding,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
