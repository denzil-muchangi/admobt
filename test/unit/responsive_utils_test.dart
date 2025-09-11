import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:admobt/utils/responsive_utils.dart';

void main() {
  group('ResponsiveUtils', () {
    late MediaQueryData mobileMediaQuery;
    late MediaQueryData tabletMediaQuery;
    late MediaQueryData desktopMediaQuery;

    setUp(() {
      // Mobile: 375x667 (iPhone 6/7/8)
      mobileMediaQuery = const MediaQueryData(size: Size(375, 667));

      // Tablet: 768x1024 (iPad)
      tabletMediaQuery = const MediaQueryData(size: Size(768, 1024));

      // Desktop: 1920x1080
      desktopMediaQuery = const MediaQueryData(size: Size(1920, 1080));
    });

    group('Device Detection', () {
      test('isMobile returns true for mobile screen sizes', () {
        final mobileContext = _MockBuildContext(mediaQuery: mobileMediaQuery);
        expect(ResponsiveUtils.isMobile(mobileContext), true);

        final smallTabletContext = _MockBuildContext(
          mediaQuery: const MediaQueryData(size: Size(599, 800)),
        );
        expect(ResponsiveUtils.isMobile(smallTabletContext), true);
      });

      test('isTablet returns true for tablet screen sizes', () {
        final tabletContext = _MockBuildContext(mediaQuery: tabletMediaQuery);
        expect(ResponsiveUtils.isTablet(tabletContext), true);

        final largeMobileContext = _MockBuildContext(
          mediaQuery: const MediaQueryData(size: Size(600, 800)),
        );
        expect(ResponsiveUtils.isTablet(largeMobileContext), true);
      });

      test('isDesktop returns true for desktop screen sizes', () {
        final desktopContext = _MockBuildContext(mediaQuery: desktopMediaQuery);
        expect(ResponsiveUtils.isDesktop(desktopContext), true);

        final largeTabletContext = _MockBuildContext(
          mediaQuery: const MediaQueryData(size: Size(841, 1200)),
        );
        expect(ResponsiveUtils.isDesktop(largeTabletContext), true);
      });

      test('Device detection is mutually exclusive', () {
        final contexts = [
          _MockBuildContext(mediaQuery: mobileMediaQuery),
          _MockBuildContext(mediaQuery: tabletMediaQuery),
          _MockBuildContext(mediaQuery: desktopMediaQuery),
        ];

        for (final context in contexts) {
          final isMobile = ResponsiveUtils.isMobile(context);
          final isTablet = ResponsiveUtils.isTablet(context);
          final isDesktop = ResponsiveUtils.isDesktop(context);

          // Only one should be true
          expect([isMobile, isTablet, isDesktop].where((x) => x).length, 1);
        }
      });
    });

    group('Responsive Value Selection', () {
      test('getResponsiveValue returns correct value for each screen size', () {
        final mobileContext = _MockBuildContext(mediaQuery: mobileMediaQuery);
        final tabletContext = _MockBuildContext(mediaQuery: tabletMediaQuery);
        final desktopContext = _MockBuildContext(mediaQuery: desktopMediaQuery);

        expect(
          ResponsiveUtils.getResponsiveValue(
              mobileContext, 'mobile', 'tablet', 'desktop'),
          'mobile',
        );
        expect(
          ResponsiveUtils.getResponsiveValue(
              tabletContext, 'mobile', 'tablet', 'desktop'),
          'tablet',
        );
        expect(
          ResponsiveUtils.getResponsiveValue(
              desktopContext, 'mobile', 'tablet', 'desktop'),
          'desktop',
        );
      });

      test('getResponsiveValue works with different data types', () {
        final mobileContext = _MockBuildContext(mediaQuery: mobileMediaQuery);

        // Numbers
        expect(
          ResponsiveUtils.getResponsiveValue(mobileContext, 10, 20, 30),
          10,
        );

        // Booleans
        expect(
          ResponsiveUtils.getResponsiveValue(mobileContext, true, false, true),
          true,
        );

        // Colors
        expect(
          ResponsiveUtils.getResponsiveValue(
            mobileContext,
            Colors.red,
            Colors.blue,
            Colors.green,
          ),
          Colors.red,
        );
      });
    });

    group('Font Size Calculations', () {
      test('getResponsiveFontSize scales correctly', () {
        final mobileContext = _MockBuildContext(mediaQuery: mobileMediaQuery);
        final tabletContext = _MockBuildContext(mediaQuery: tabletMediaQuery);

        const baseSize = 16.0;

        final mobileSize =
            ResponsiveUtils.getResponsiveFontSize(mobileContext, baseSize);
        final tabletSize =
            ResponsiveUtils.getResponsiveFontSize(tabletContext, baseSize);

        // Mobile should be smaller or equal to base
        expect(mobileSize, lessThanOrEqualTo(baseSize));
        // Tablet should be larger than mobile
        expect(tabletSize, greaterThan(mobileSize));
      });

      test('getResponsiveFontSize clamps values correctly', () {
        final verySmallContext = _MockBuildContext(
          mediaQuery: const MediaQueryData(size: Size(200, 300)),
        );
        final veryLargeContext = _MockBuildContext(
          mediaQuery: const MediaQueryData(size: Size(3000, 2000)),
        );

        const baseSize = 16.0;

        final smallSize =
            ResponsiveUtils.getResponsiveFontSize(verySmallContext, baseSize);
        final largeSize =
            ResponsiveUtils.getResponsiveFontSize(veryLargeContext, baseSize);

        // Should be clamped between 80% and 150% of base size
        expect(smallSize, greaterThanOrEqualTo(baseSize * 0.8));
        expect(largeSize, lessThanOrEqualTo(baseSize * 1.5));
      });
    });

    group('Padding and Spacing', () {
      test(
          'getResponsivePadding returns appropriate padding for each screen size',
          () {
        final mobileContext = _MockBuildContext(mediaQuery: mobileMediaQuery);
        final tabletContext = _MockBuildContext(mediaQuery: tabletMediaQuery);
        final desktopContext = _MockBuildContext(mediaQuery: desktopMediaQuery);

        final mobilePadding =
            ResponsiveUtils.getResponsivePadding(mobileContext);
        final tabletPadding =
            ResponsiveUtils.getResponsivePadding(tabletContext);
        final desktopPadding =
            ResponsiveUtils.getResponsivePadding(desktopContext);

        // Mobile should have smallest padding
        expect(mobilePadding.horizontal, lessThan(tabletPadding.horizontal));
        expect(tabletPadding.horizontal, lessThan(desktopPadding.horizontal));
      });

      test('getResponsiveSpacing returns appropriate spacing', () {
        final mobileContext = _MockBuildContext(mediaQuery: mobileMediaQuery);
        final tabletContext = _MockBuildContext(mediaQuery: tabletMediaQuery);

        final mobileSpacing =
            ResponsiveUtils.getResponsiveSpacing(mobileContext);
        final tabletSpacing =
            ResponsiveUtils.getResponsiveSpacing(tabletContext);

        expect(mobileSpacing, lessThan(tabletSpacing));
      });
    });

    group('Grid and Layout Calculations', () {
      test('getResponsiveGridCrossAxisCount returns appropriate counts', () {
        final mobileContext = _MockBuildContext(mediaQuery: mobileMediaQuery);
        final tabletContext = _MockBuildContext(mediaQuery: tabletMediaQuery);
        final desktopContext = _MockBuildContext(mediaQuery: desktopMediaQuery);

        expect(
            ResponsiveUtils.getResponsiveGridCrossAxisCount(mobileContext), 2);
        expect(
            ResponsiveUtils.getResponsiveGridCrossAxisCount(tabletContext), 3);
        expect(
            ResponsiveUtils.getResponsiveGridCrossAxisCount(desktopContext), 4);
      });

      test('getResponsiveListItemHeight returns appropriate heights', () {
        final mobileContext = _MockBuildContext(mediaQuery: mobileMediaQuery);
        final tabletContext = _MockBuildContext(mediaQuery: tabletMediaQuery);

        final mobileHeight =
            ResponsiveUtils.getResponsiveListItemHeight(mobileContext);
        final tabletHeight =
            ResponsiveUtils.getResponsiveListItemHeight(tabletContext);

        expect(mobileHeight, lessThan(tabletHeight));
      });
    });

    group('Aspect Ratio and Dimensions', () {
      test('getResponsiveAspectRatio returns appropriate ratios', () {
        final mobileContext = _MockBuildContext(mediaQuery: mobileMediaQuery);
        final tabletContext = _MockBuildContext(mediaQuery: tabletMediaQuery);

        final mobileRatio =
            ResponsiveUtils.getResponsiveAspectRatio(mobileContext);
        final tabletRatio =
            ResponsiveUtils.getResponsiveAspectRatio(tabletContext);

        expect(mobileRatio, isNot(equals(tabletRatio)));
      });

      test('getResponsiveMaxWidth returns appropriate widths', () {
        final mobileContext = _MockBuildContext(mediaQuery: mobileMediaQuery);
        final tabletContext = _MockBuildContext(mediaQuery: tabletMediaQuery);

        final mobileMaxWidth =
            ResponsiveUtils.getResponsiveMaxWidth(mobileContext);
        final tabletMaxWidth =
            ResponsiveUtils.getResponsiveMaxWidth(tabletContext);

        expect(mobileMaxWidth,
            isNull); // Mobile should not have max width constraint
        expect(tabletMaxWidth, isNotNull);
        expect(tabletMaxWidth, greaterThanOrEqualTo(600.0));
      });
    });

    group('Orientation Detection', () {
      test('isLandscape returns correct orientation based on size', () {
        // Portrait: height > width
        final portraitContext = _MockBuildContext(
          mediaQuery: const MediaQueryData(size: Size(375, 667)),
        );
        // Landscape: width > height
        final landscapeContext = _MockBuildContext(
          mediaQuery: const MediaQueryData(size: Size(667, 375)),
        );

        // Note: The current implementation uses size to determine orientation
        // In a real app, this would use MediaQuery.of(context).orientation
        expect(ResponsiveUtils.isLandscape(portraitContext), false);
        expect(ResponsiveUtils.isLandscape(landscapeContext), true);
      });
    });
  });
}

/// Mock BuildContext for testing
class _MockBuildContext implements BuildContext {
  final MediaQueryData mediaQuery;

  const _MockBuildContext({required this.mediaQuery});

  @override
  T? dependOnInheritedWidgetOfExactType<T extends InheritedWidget>(
      {Object? aspect}) {
    // Return MediaQuery if requested
    if (T == MediaQuery) {
      return _MockMediaQuery(data: mediaQuery) as T?;
    }
    return null;
  }

  @override
  InheritedElement?
      getElementForInheritedWidgetOfExactType<T extends InheritedWidget>() {
    if (T == MediaQuery) {
      return _MockMediaQueryElement(data: mediaQuery);
    }
    return null;
  }

  @override
  BuildOwner? get owner => null;

  @override
  Size? get size => mediaQuery.size;

  @override
  bool get debugDoingBuild => false;

  @override
  bool get mounted => true;

  @override
  bool get debugIsDefunct => false;

  @override
  void visitAncestorElements(bool Function(Element element) visitor) {}

  @override
  void visitChildElements(ElementVisitor visitor) {}

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) =>
      '_MockBuildContext';

  @override
  void dispatchNotification(Notification notification) {}

  @override
  bool get debugDoingBuildDirty => false;

  @override
  void markNeedsBuild() {}

  @override
  T? findAncestorWidgetOfExactType<T extends Widget>() => null;

  @override
  T? findRootAncestorStateOfType<T extends State<StatefulWidget>>() => null;

  @override
  T? findAncestorStateOfType<T extends State<StatefulWidget>>() => null;

  @override
  RenderObject? findRenderObject() => null;

  @override
  T? findAncestorRenderObjectOfType<T extends RenderObject>() => null;

  @override
  T? getInheritedWidgetOfExactType<T extends InheritedWidget>() {
    if (T == MediaQuery) {
      return _MockMediaQuery(data: mediaQuery) as T?;
    }
    return null;
  }

  @override
  Widget get widget => const SizedBox();

  @override
  InheritedWidget dependOnInheritedElement(InheritedElement ancestor,
      {Object? aspect}) {
    throw UnimplementedError();
  }

  @override
  DiagnosticsNode describeElement(String name, {DiagnosticsTreeStyle? style}) =>
      DiagnosticsNode.message(name);

  @override
  List<DiagnosticsNode> describeMissingAncestor(
          {required Type expectedAncestorType}) =>
      [];

  @override
  DiagnosticsNode describeOwnershipChain(String name) =>
      DiagnosticsNode.message(name);

  @override
  DiagnosticsNode describeWidget(String name, {DiagnosticsTreeStyle? style}) =>
      DiagnosticsNode.message(name);

  @override
  Iterable<DiagnosticsNode> describeWidgets(String name) => [];
}

/// Mock MediaQuery widget
class _MockMediaQuery extends MediaQuery {
  const _MockMediaQuery({required MediaQueryData data})
      : super(data: data, child: const SizedBox());
}

/// Mock MediaQuery element
class _MockMediaQueryElement extends InheritedElement {
  final MediaQueryData data;

  _MockMediaQueryElement({required this.data})
      : super(_MockMediaQuery(data: data));

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
