// Comprehensive test suite for Flutter AdMob Demo App
// This file serves as the main test entry point

import 'package:flutter_test/flutter_test.dart';

// Import existing test files
import 'unit/responsive_utils_test.dart' as responsive_utils_test;
import 'widgets/stat_card_test.dart' as stat_card_test;
import 'mocks/admob_mocks_test.dart' as admob_mocks_test;

// TODO: Create these test files when ready
// import 'unit/extension_methods_test.dart' as extension_methods_test;
// import 'widgets/banner_ad_widget_test.dart' as banner_ad_widget_test;
// import 'widgets/bottom_navigation_test.dart' as bottom_navigation_test;
// import 'integration/home_screen_test.dart' as home_screen_test;
// import 'integration/ad_format_demo_screen_test.dart' as ad_format_demo_screen_test;

void main() {
  // Unit Tests
  responsive_utils_test.main();
  // extension_methods_test.main(); // TODO: Uncomment when file is created

  // Widget Tests
  // banner_ad_widget_test.main(); // TODO: Uncomment when file is created
  // bottom_navigation_test.main(); // TODO: Uncomment when file is created
  stat_card_test.main();

  // Integration Tests
  // home_screen_test.main(); // TODO: Uncomment when file is created
  // ad_format_demo_screen_test.main(); // TODO: Uncomment when file is created

  // Mock Tests
  admob_mocks_test.main();
}
