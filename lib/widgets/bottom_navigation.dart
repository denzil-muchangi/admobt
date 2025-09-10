import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final double? elevation;

  const BottomNavigation({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    this.backgroundColor = Colors.white,
    this.selectedColor = Colors.deepPurple,
    this.unselectedColor = Colors.grey,
    this.elevation = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: elevation!,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(totalPages, (index) {
          return GestureDetector(
            onTap: () => onPageChanged(index),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: currentPage == index
                    ? selectedColor
                    : unselectedColor?.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    color: currentPage == index ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
