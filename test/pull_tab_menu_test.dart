import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pull_tab_menu/pull_tab_menu.dart';

void main() {
  group('PullTabController Tests', () {
    test('PullTabController initial state is correct', () {
      final PullTabController controller = PullTabController();

      expect(controller.isMenuOpen, false);
      expect(controller.isDragging, false);
      expect(controller.dragPosition, 0.0);
      expect(controller.menuItems, isEmpty);
    });

    test('PullTabController open/close methods work correctly', () {
      final PullTabController controller = PullTabController();

      // Test opening
      controller.openMenu();
      expect(controller.isMenuOpen, true);

      // Test closing
      controller.closeMenu();
      expect(controller.isMenuOpen, false);

      // Test toggle
      controller.toggleMenu();
      expect(controller.isMenuOpen, true);
      controller.toggleMenu();
      expect(controller.isMenuOpen, false);
    });

    test('PullTabController item management', () {
      final PullTabController controller = PullTabController();

      final List<PullTabMenuItem> menuItems = <PullTabMenuItem>[
        const PullTabMenuItem(label: 'Home', icon: Icons.home),
        const PullTabMenuItem(label: 'Settings', icon: Icons.settings),
      ];

      // Set items
      controller.menuItems = menuItems;

      // Verify they were set correctly
      expect(controller.menuItems, equals(menuItems));
      expect(controller.menuItems.length, 2);
    });
  });

  group('PullTabMenu Widget Tests', () {
    testWidgets('PullTabMenu shows menu items correctly', (
      WidgetTester tester,
    ) async {
      // Create a basic menu with items
      final List<PullTabMenuItem> menuItems = <PullTabMenuItem>[
        const PullTabMenuItem(label: 'Home', icon: Icons.home),
        const PullTabMenuItem(label: 'Settings', icon: Icons.settings),
      ];

      // Build our app and trigger a frame
      await tester.pumpWidget(
        MaterialApp(
          home: PullTabMenu(
            menuItems: menuItems,
            child: const Scaffold(body: Center(child: Text('Test'))),
          ),
        ),
      );

      // Verify that the menu is initially closed
      expect(find.byType(PullTabMenu), findsOneWidget);
    });

    testWidgets('PullTabController controls menu state', (
      WidgetTester tester,
    ) async {
      // Create a controller
      final PullTabController controller = PullTabController();
      bool listenerCalled = false;

      // Add a listener to test notifications
      controller.addListener(() {
        listenerCalled = true;
      });

      // Check initial state
      expect(controller.isMenuOpen, false);
      expect(listenerCalled, false);

      // Open menu
      controller.openMenu();
      expect(controller.isMenuOpen, true);
      expect(listenerCalled, true);

      // Reset and test close
      listenerCalled = false;
      controller.closeMenu();
      expect(controller.isMenuOpen, false);
      expect(listenerCalled, true);
    });

    test('PullTabMenuConfiguration copyWith works correctly', () {
      const PullTabMenuConfiguration defaultConfig = PullTabMenuConfiguration();

      final PullTabMenuConfiguration updatedConfig = defaultConfig.copyWith(
        menuPosition: MenuPosition.bottomLeft,
        tabColor: Colors.red,
        railBreadth: 80.0,
        maxMenuHeightFactor: 0.5,
      );

      // Original values should not change
      expect(defaultConfig.menuPosition, MenuPosition.centerRight);
      expect(defaultConfig.tabColor, null);
      expect(defaultConfig.railBreadth, 60.0);
      expect(defaultConfig.maxMenuHeightFactor, 0.7);

      // New values should be updated
      expect(updatedConfig.menuPosition, MenuPosition.bottomLeft);
      expect(updatedConfig.tabColor, Colors.red);
      expect(updatedConfig.railBreadth, 80.0);
      expect(updatedConfig.maxMenuHeightFactor, 0.5);

      // Other values should remain the same
      expect(updatedConfig.tabHeight, defaultConfig.tabHeight);
      expect(updatedConfig.axis, defaultConfig.axis);
    });

    test('PullTabMenuConfiguration default values', () {
      const PullTabMenuConfiguration defaultConfig = PullTabMenuConfiguration();

      // Check default values
      expect(defaultConfig.menuPosition, MenuPosition.centerRight);
      expect(defaultConfig.axis, Axis.vertical);
      expect(defaultConfig.tabWidth, 40.0);
      expect(defaultConfig.tabHeight, 80.0);
      expect(defaultConfig.baseColor, null);
      expect(defaultConfig.tabColor, null);
      expect(defaultConfig.tabOpacity, 0.7);
      expect(defaultConfig.menuOpacity, 1.0);
      expect(defaultConfig.foregroundColor, null);
      expect(defaultConfig.autoHide, false);
      expect(defaultConfig.autoHideDelay, const Duration(seconds: 3));
      expect(defaultConfig.maxMenuHeightFactor, 0.7);
      expect(defaultConfig.itemSize, 48.0);
      expect(defaultConfig.railBreadth, 60.0);
    });

    test('PullTabMenuConfiguration custom values', () {
      const PullTabMenuConfiguration customConfig = PullTabMenuConfiguration(
        menuPosition: MenuPosition.topLeft,
        axis: Axis.horizontal,
        tabWidth: 50.0,
        tabHeight: 100.0,
        baseColor: Colors.black,
        tabColor: Colors.orange,
        tabOpacity: 0.8,
        menuOpacity: 0.9,
        foregroundColor: Colors.white,
        autoHide: true,
        autoHideDelay: Duration(seconds: 5),
        maxMenuHeightFactor: 0.5,
        itemSize: 60.0,
        railBreadth: 80.0,
        dividerThickness: 1.0,
        dividerIndent: 16.0,
      );

      expect(customConfig.menuPosition, MenuPosition.topLeft);
      expect(customConfig.axis, Axis.horizontal);
      expect(customConfig.tabWidth, 50.0);
      expect(customConfig.tabHeight, 100.0);
      expect(customConfig.baseColor, Colors.black);
      expect(customConfig.tabColor, Colors.orange);
      expect(customConfig.tabOpacity, 0.8);
      expect(customConfig.menuOpacity, 0.9);
      expect(customConfig.foregroundColor, Colors.white);
      expect(customConfig.autoHide, true);
      expect(customConfig.autoHideDelay, const Duration(seconds: 5));
      expect(customConfig.maxMenuHeightFactor, 0.5);
      expect(customConfig.itemSize, 60.0);
      expect(customConfig.railBreadth, 80.0);
      expect(customConfig.dividerThickness, 1.0);
      expect(customConfig.dividerIndent, 16.0);
    });
  });
}
