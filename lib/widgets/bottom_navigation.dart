import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';

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
    final buttonSize = context.responsiveValue(32.0, 40.0, 48.0);
    final fontSize = context.responsiveFontSize(14.0);

    return Container(
      padding: context.responsivePadding,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
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
              width: buttonSize,
              height: buttonSize,
              decoration: BoxDecoration(
                color: currentPage == index
                    ? selectedColor
                    : unselectedColor?.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    color: currentPage == index ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
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
