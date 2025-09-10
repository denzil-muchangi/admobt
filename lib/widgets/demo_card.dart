import 'package:flutter/material.dart';

class DemoCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget adWidget;
  final EdgeInsetsGeometry? margin;
  final double? elevation;

  const DemoCard({
    super.key,
    required this.title,
    required this.description,
    required this.adWidget,
    this.margin = const EdgeInsets.only(bottom: 16),
    this.elevation = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      margin: margin,
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
