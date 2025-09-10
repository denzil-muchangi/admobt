import 'package:flutter/material.dart';

class BannerTypeCard extends StatelessWidget {
  final String title;
  final Widget adWidget;
  final double? width;
  final EdgeInsetsGeometry? margin;

  const BannerTypeCard({
    super.key,
    required this.title,
    required this.adWidget,
    this.width = 150,
    this.margin = const EdgeInsets.only(right: 12),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
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
}
