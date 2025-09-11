import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad_helper.dart';
import '../utils/responsive_utils.dart';

class BannerAdWidget extends StatefulWidget {
  final AdSize? adSize;
  final String placement;

  const BannerAdWidget({
    super.key,
    this.adSize,
    this.placement = 'default',
  });

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;
  bool _isLoading = false;
  String? _errorMessage;
  int _retryCount = 0;
  static const int maxRetries = 2;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final view = WidgetsBinding.instance.platformDispatcher.views.first;
      final screenWidth = MediaQueryData.fromView(view).size.width.truncate();
      final orientation = MediaQueryData.fromView(view).orientation;
      final adSize = widget.adSize ??
          await AdSize.getAnchoredAdaptiveBannerAdSize(
              orientation, screenWidth);

      if (adSize != null) {
        _bannerAd = BannerAd(
          adUnitId: AdHelper.bannerAdUnitId,
          request: const AdRequest(),
          size: adSize,
          listener: BannerAdListener(
            onAdLoaded: (ad) {
              setState(() {
                _isAdLoaded = true;
                _isLoading = false;
              });
              debugPrint('Banner ad loaded: ${widget.placement}');
            },
            onAdFailedToLoad: (ad, error) {
              debugPrint(
                  'Banner ad failed to load: ${widget.placement} - $error');
              ad.dispose();

              if (_retryCount < maxRetries) {
                _retryCount++;
                debugPrint('Retrying ad load (attempt ${_retryCount + 1})');
                Future.delayed(const Duration(seconds: 1), () {
                  if (mounted) _loadAd();
                });
              } else {
                setState(() {
                  _isLoading = false;
                  _errorMessage =
                      'Failed to load ad after ${maxRetries + 1} attempts';
                });
              }
            },
          ),
        )..load();
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Unable to determine ad size';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error loading ad: $e';
      });
      debugPrint('Error in _loadAd: $e');
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isAdLoaded && _bannerAd != null) {
      return Container(
        alignment: Alignment.center,
        width: _bannerAd!.size.width.toDouble(),
        height: _bannerAd!.size.height.toDouble(),
        margin: context.responsiveMargin,
        child: AdWidget(ad: _bannerAd!),
      );
    }

    if (_isLoading) {
      return Container(
        alignment: Alignment.center,
        height: context.responsiveValue(40.0, 50.0, 60.0),
        child: SizedBox(
          width: context.responsiveIconSize(24.0),
          height: context.responsiveIconSize(24.0),
          child: const CircularProgressIndicator(),
        ),
      );
    }

    if (_errorMessage != null) {
      return Container(
        alignment: Alignment.center,
        height: context.responsiveValue(40.0, 50.0, 60.0),
        padding: context.responsivePadding,
        child: Text(
          'Ad unavailable',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: context.responsiveFontSize(12.0),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

// Creative banner ad placements
class CreativeBannerAds {
  // Collapsible banner with animation
  static Widget collapsibleBanner({
    required String adUnitId,
    bool initiallyExpanded = true,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () =>
                  setState(() => initiallyExpanded = !initiallyExpanded),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.grey[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Sponsored Content'),
                    Icon(
                      initiallyExpanded ? Icons.expand_less : Icons.expand_more,
                    ),
                  ],
                ),
              ),
            ),
            if (initiallyExpanded)
              const BannerAdWidget(
                adSize: AdSize.mediumRectangle,
                placement: 'collapsible',
              ),
          ],
        );
      },
    );
  }

  // Sticky bottom banner
  static Widget stickyBottomBanner({
    required String adUnitId,
    Color backgroundColor = Colors.white,
    double elevation = 4.0,
  }) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: elevation,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: const BannerAdWidget(
          placement: 'sticky_bottom',
        ),
      ),
    );
  }

  // Inline banner within content
  static Widget inlineContentBanner() {
    return Builder(
      builder: (context) => Card(
        elevation: context.responsiveElevation,
        margin: context.responsiveMargin,
        child: Padding(
          padding: context.responsivePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sponsored Content',
                style: TextStyle(
                  fontSize: context.responsiveFontSize(12.0),
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: context.responsiveSpacing),
              BannerAdWidget(
                adSize:
                    context.isMobile ? AdSize.banner : AdSize.mediumRectangle,
                placement: 'inline_content',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Floating banner
  static Widget floatingBanner({
    required String adUnitId,
    double bottom = 100.0,
    double right = 20.0,
  }) {
    return Positioned(
      bottom: bottom,
      right: right,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        child: const BannerAdWidget(
          placement: 'floating',
        ),
      ),
    );
  }

  // Adaptive banner helper method
  static Widget adaptiveBanner({
    required String adUnitId,
    String placement = 'adaptive',
  }) {
    return BannerAdWidget(
      placement: placement,
    );
  }
}
