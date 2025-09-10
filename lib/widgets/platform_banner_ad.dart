import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// Export AdSize for compatibility
export 'banner_ad_placeholder.dart' show AdSize;

// Import the appropriate widget based on platform
import 'banner_ad_placeholder.dart';

class PlatformBannerAd extends StatelessWidget {
  final AdSize? adSize;
  final String? placement;

  const PlatformBannerAd({
    super.key,
    this.adSize,
    this.placement = 'default',
  });

  @override
  Widget build(BuildContext context) {
    // For now, always show placeholder to avoid platform-specific issues
    // In production, you would conditionally import based on platform
    return BannerAdPlaceholder(
      adSize: adSize,
      placement: placement,
    );
  }
}
