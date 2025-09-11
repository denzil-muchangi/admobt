import 'package:flutter/material.dart';

/// Utility class for responsive design across the app
class ResponsiveUtils {
  // Breakpoints for different screen sizes
  static const double mobileMaxWidth = 600;
  static const double tabletMaxWidth = 840;

  /// Check if the device is a mobile phone
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileMaxWidth;
  }

  /// Check if the device is a tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileMaxWidth && width < tabletMaxWidth;
  }

  /// Check if the device is desktop/large screen
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= tabletMaxWidth;
  }

  /// Get responsive value based on screen size
  static T getResponsiveValue<T>(
    BuildContext context,
    T mobile,
    T tablet,
    T desktop,
  ) {
    if (isDesktop(context)) return desktop;
    if (isTablet(context)) return tablet;
    return mobile;
  }

  /// Get responsive font size
  static double getResponsiveFontSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor =
        screenWidth / 375.0; // Base width for scaling (iPhone 6/7/8 width)
    return baseSize * scaleFactor.clamp(0.8, 1.5); // Clamp between 80% and 150%
  }

  /// Get responsive padding
  static EdgeInsets getResponsivePadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: getResponsiveValue(context, 16.0, 24.0, 32.0),
      vertical: getResponsiveValue(context, 8.0, 12.0, 16.0),
    );
  }

  /// Get responsive margin
  static EdgeInsets getResponsiveMargin(BuildContext context) {
    return EdgeInsets.all(
      getResponsiveValue(context, 8.0, 16.0, 24.0),
    );
  }

  /// Get responsive spacing between widgets
  static double getResponsiveSpacing(BuildContext context) {
    return getResponsiveValue(context, 8.0, 16.0, 24.0);
  }

  /// Get responsive card elevation
  static double getResponsiveElevation(BuildContext context) {
    return getResponsiveValue(context, 2.0, 4.0, 6.0);
  }

  /// Get responsive border radius
  static double getResponsiveBorderRadius(BuildContext context) {
    return getResponsiveValue(context, 8.0, 12.0, 16.0);
  }

  /// Get responsive icon size
  static double getResponsiveIconSize(BuildContext context, double baseSize) {
    return getResponsiveValue(
      context,
      baseSize * 0.8,
      baseSize,
      baseSize * 1.2,
    );
  }

  /// Get responsive button padding
  static EdgeInsets getResponsiveButtonPadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: getResponsiveValue(context, 16.0, 24.0, 32.0),
      vertical: getResponsiveValue(context, 12.0, 16.0, 20.0),
    );
  }

  /// Get responsive grid cross axis count
  static int getResponsiveGridCrossAxisCount(BuildContext context) {
    return getResponsiveValue(context, 2, 3, 4);
  }

  /// Get responsive list item height
  static double getResponsiveListItemHeight(BuildContext context) {
    return getResponsiveValue(context, 60.0, 70.0, 80.0);
  }

  /// Check if device is in landscape orientation
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Get responsive aspect ratio for cards/images
  static double getResponsiveAspectRatio(BuildContext context) {
    return getResponsiveValue(context, 16 / 9, 4 / 3, 16 / 10);
  }

  /// Get responsive max width for content containers
  static double? getResponsiveMaxWidth(BuildContext context) {
    return getResponsiveValue(context, null, 600.0, 800.0);
  }

  /// Get responsive text scale factor
  static double getTextScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor.clamp(0.8, 1.2);
  }
}

/// Extension methods for responsive design
extension ResponsiveExtension on BuildContext {
  bool get isMobile => ResponsiveUtils.isMobile(this);
  bool get isTablet => ResponsiveUtils.isTablet(this);
  bool get isDesktop => ResponsiveUtils.isDesktop(this);
  bool get isLandscape => ResponsiveUtils.isLandscape(this);

  T responsiveValue<T>(T mobile, T tablet, T desktop) {
    return ResponsiveUtils.getResponsiveValue(this, mobile, tablet, desktop);
  }

  double responsiveFontSize(double baseSize) {
    return ResponsiveUtils.getResponsiveFontSize(this, baseSize);
  }

  EdgeInsets get responsivePadding =>
      ResponsiveUtils.getResponsivePadding(this);
  EdgeInsets get responsiveMargin => ResponsiveUtils.getResponsiveMargin(this);
  double get responsiveSpacing => ResponsiveUtils.getResponsiveSpacing(this);
  double get responsiveElevation =>
      ResponsiveUtils.getResponsiveElevation(this);
  double get responsiveBorderRadius =>
      ResponsiveUtils.getResponsiveBorderRadius(this);

  double responsiveIconSize(double baseSize) {
    return ResponsiveUtils.getResponsiveIconSize(this, baseSize);
  }

  EdgeInsets get responsiveButtonPadding =>
      ResponsiveUtils.getResponsiveButtonPadding(this);
  int get responsiveGridCrossAxisCount =>
      ResponsiveUtils.getResponsiveGridCrossAxisCount(this);
  double get responsiveListItemHeight =>
      ResponsiveUtils.getResponsiveListItemHeight(this);
  double get responsiveAspectRatio =>
      ResponsiveUtils.getResponsiveAspectRatio(this);
  double? get responsiveMaxWidth => ResponsiveUtils.getResponsiveMaxWidth(this);
  double get textScaleFactor => ResponsiveUtils.getTextScaleFactor(this);
}
