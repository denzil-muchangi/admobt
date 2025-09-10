import 'package:flutter/material.dart';

class BannerAdPlaceholder extends StatelessWidget {
  final AdSize? adSize;
  final String? placement;

  const BannerAdPlaceholder({
    super.key,
    this.adSize,
    this.placement,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate height based on ad size or use default
    double height = 50.0; // Default banner height
    if (adSize != null) {
      // For web, we'll use approximate heights
      if (adSize.toString().contains('largeBanner')) {
        height = 100.0;
      } else if (adSize.toString().contains('mediumRectangle')) {
        height = 250.0;
      } else if (adSize.toString().contains('leaderboard')) {
        height = 90.0;
      }
    }

    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.ad_units,
            color: Colors.grey[600],
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            'Ad Placeholder',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (placement != null)
            Text(
              '($placement)',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 10,
              ),
            ),
        ],
      ),
    );
  }
}

// Mock AdSize class for web compatibility
class AdSize {
  final int width;
  final int height;

  const AdSize(this.width, this.height);

  static const AdSize banner = AdSize(320, 50);
  static const AdSize largeBanner = AdSize(320, 100);
  static const AdSize mediumRectangle = AdSize(300, 250);
  static const AdSize leaderboard = AdSize(728, 90);

  @override
  String toString() => 'AdSize($width, $height)';
}
