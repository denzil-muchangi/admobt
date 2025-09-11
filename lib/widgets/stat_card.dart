import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;

  const StatCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final padding = context.responsivePadding;
    final borderRadius = context.responsiveBorderRadius;
    final titleFontSize = context.responsiveFontSize(12.0);
    final subtitleFontSize = context.responsiveFontSize(10.0);

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: titleFontSize,
            ),
          ),
          SizedBox(height: context.responsiveSpacing * 0.5),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white70,
              fontSize: subtitleFontSize,
            ),
          ),
        ],
      ),
    );
  }
}
