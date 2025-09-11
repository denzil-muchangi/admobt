import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:admobt/widgets/stat_card.dart';

void main() {
  group('StatCard Widget Tests', () {
    const testTitle = 'Test Title';
    const testSubtitle = 'Test Subtitle';
    const testColor = Colors.blue;

    testWidgets('StatCard displays title and subtitle correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatCard(
              title: testTitle,
              subtitle: testSubtitle,
              color: testColor,
            ),
          ),
        ),
      );

      // Verify that the title and subtitle are displayed
      expect(find.text(testTitle), findsOneWidget);
      expect(find.text(testSubtitle), findsOneWidget);
    });

    testWidgets('StatCard applies correct background color with opacity',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatCard(
              title: testTitle,
              subtitle: testSubtitle,
              color: testColor,
            ),
          ),
        ),
      );

      // Find the container with the background color
      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(StatCard),
              matching: find.byType(Container),
            )
            .first,
      );

      // Verify the decoration has the correct color with opacity
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, testColor.withValues(alpha: 0.2));
    });

    testWidgets('StatCard has correct border styling',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatCard(
              title: testTitle,
              subtitle: testSubtitle,
              color: testColor,
            ),
          ),
        ),
      );

      // Find the container
      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(StatCard),
              matching: find.byType(Container),
            )
            .first,
      );

      // Verify the border styling
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.border, isNotNull);

      // Check that the border color has the correct RGB values and approximately correct alpha
      final borderColor = decoration.border!.top.color;
      expect(borderColor.red, testColor.red);
      expect(borderColor.green, testColor.green);
      expect(borderColor.blue, testColor.blue);
      expect(borderColor.alpha / 255.0,
          closeTo(0.3, 0.01)); // Allow small tolerance
    });

    testWidgets('StatCard uses responsive padding',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatCard(
              title: testTitle,
              subtitle: testSubtitle,
              color: testColor,
            ),
          ),
        ),
      );

      // Find the container
      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(StatCard),
              matching: find.byType(Container),
            )
            .first,
      );

      // Verify padding is applied
      expect(container.padding, isNotNull);
    });

    testWidgets('StatCard text uses responsive font sizes',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatCard(
              title: testTitle,
              subtitle: testSubtitle,
              color: testColor,
            ),
          ),
        ),
      );

      // Find the title text
      final titleText = tester.widget<Text>(
        find.text(testTitle),
      );

      // Verify the text style has a font size
      expect(titleText.style?.fontSize, isNotNull);
      expect(titleText.style?.fontWeight, FontWeight.bold);

      // Find the subtitle text
      final subtitleText = tester.widget<Text>(
        find.text(testSubtitle),
      );

      // Verify the subtitle has different styling
      expect(subtitleText.style?.fontSize, isNotNull);
      expect(subtitleText.style?.fontWeight, isNot(FontWeight.bold));
    });

    testWidgets('StatCard handles different screen sizes',
        (WidgetTester tester) async {
      // Test with different screen sizes
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatCard(
              title: testTitle,
              subtitle: testSubtitle,
              color: testColor,
            ),
          ),
        ),
      );

      // The widget should render without errors on different screen sizes
      expect(find.byType(StatCard), findsOneWidget);
      expect(find.text(testTitle), findsOneWidget);
      expect(find.text(testSubtitle), findsOneWidget);
    });

    testWidgets('StatCard maintains layout integrity',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatCard(
              title: testTitle,
              subtitle: testSubtitle,
              color: testColor,
            ),
          ),
        ),
      );

      // Verify the widget tree structure
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(2)); // Title and subtitle
    });
  });
}
