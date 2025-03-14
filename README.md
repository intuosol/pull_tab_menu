# Pull Tab Menu <img src="https://raw.githubusercontent.com/intuosol/intuosol_design_system/main/assets/logos/by_intuosol.png" alt="Icon" width="250" style="margin-left: 10px;">

[![platform](https://img.shields.io/badge/platform-flutter-blue.svg)](https://flutter.dev)
[![pub package](https://img.shields.io/pub/v/pull_tab_menu.svg)](https://pub.dev/packages/pull_tab_menu)
[![pub points](https://img.shields.io/pub/points/pull_tab_menu)](https://pub.dev/packages/pull_tab_menu/score)
[![documentation](https://img.shields.io/badge/api-documentation-blue.svg)](https://pub.dev/documentation/pull_tab_menu)
[![interactive demo](https://img.shields.io/badge/interactive-demo-white.svg)](https://intuosol.github.io/pull_tab_menu/)
[![last updated](https://img.shields.io/github/last-commit/intuosol/pull_tab_menu.svg)](https://github.com/intuosol/pull_tab_menu/commits/main)
[![by](https://img.shields.io/badge/by-IntuoSol-success.svg)](https://intuosol.com)

PullTabMenu brings elegant context menus to Flutter apps through a discreet, pull-out tab interface. Preserve your interface's clean aesthetic while providing immediate access to actions when users need them. Perfect for creative applications where screen space and functionality must be balanced.

Try it out in the [example app](https://intuosol.github.io/pull_tab_menu/).

## Features

- Edge-anchored pull tab with customizable appearance
- Multiple menu positions (centerLeft, centerRight, topLeft, topRight, bottomLeft, bottomRight)
- Slide-out menu with smooth animations
- Support for both vertical and horizontal menu layouts
- Menu items with icons, tooltips, and tap actions
- Built-in divider support
- Material Design 3 theme integration
- Auto-hide functionality with configurable delay
- Configurable animations (duration and curves)
- Gesture-based interactions (tap, swipe, drag)
- Hover interactions for desktop/web platforms
- Optional background overlay
- Smart automatic layout selection based on item count
- Programmatic control via controller
- Customizable colors, opacity, and dimensions

## Usage

<?code-excerpt path-base="example/lib"?>

### Basic Usage

<?code-excerpt "doc_examples/basic_usage_example.dart (basic-usage)"?>

```dart
import 'package:flutter/material.dart';
import 'package:pull_tab_menu/pull_tab_menu.dart';

// Basic example of using a pull tab menu
Scaffold buildBasicExample(BuildContext context) {
  // Create menu items
  final menuItems = [
    PullTabMenuItem(
      label: 'Home',
      icon: Icons.home,
      onTap: () {
        // Handle tap action
      },
    ),
    PullTabMenuItem(
      label: 'Settings',
      icon: Icons.settings,
      onTap: () {
        // Handle tap action
      },
    ),
    PullTabMenuItem(
      label: 'Profile',
      icon: Icons.person,
      onTap: () {
        // Handle tap action
      },
    ),
  ];

  return Scaffold(
    appBar: AppBar(
      title: const Text('Pull Tab Menu Demo'),
    ),
    body: PullTabMenu(
      menuItems: menuItems,
      child: const Center(
        child: Text('Pull from the right edge to open the menu'),
      ),
    ),
  );
}
```

### Using a Controller for Programmatic Control

<?code-excerpt "doc_examples/controller_example.dart (controller-example)"?>

```dart
class _MyHomePageState extends State<MyHomePage> {
  final PullTabController _controller = PullTabController();

  @override
  void initState() {
    super.initState();
    // Demonstrate opening/closing the menu programmatically
    // Give the user a quick peek of the menu to show they can open/close it
    Future.delayed(Durations.short2, () => _controller.openMenu()).then(
      (value) => Future.delayed(Durations.long2, () => _controller.closeMenu()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pull Tab Menu Examples')),
      body: PullTabMenu(
        controller: _controller,
        menuItems: [
          PullTabMenuItem(
            label: 'Example 1',
            icon: Icons.draw,
            onTap: () {
              // Handle navigation
              Navigator.pushNamed(context, '/example1');
            },
          ),
          PullTabMenuItem(
            label: 'Example 2',
            icon: Icons.style_outlined,
            onTap: () {
              // Handle navigation
              Navigator.pushNamed(context, '/example2');
            },
          ),
        ],
        child: Center(
          child: MaterialButton(
            child: Text('Open Menu'),
            onPressed: () {
              // Open the menu
              _controller.openMenu();
            },
          ),
        ),
      ),
    );
  }
}
```

## Customization Options

The `PullTabMenuConfiguration` class provides extensive customization options:

<?code-excerpt "doc_examples/configuration_example.dart (config-options)"?>

```dart
PullTabMenuConfiguration(
  // Menu Alignment
  initialAlignment: MenuAlignment.centerRight,
  allowRepositioning: true,

  // Layout
  axis: Axis.vertical,
  margin: 8.0,
  borderRadius: 8.0,
  itemExtent: 48.0,
  menuBreadth: 60.0,

  // Tab Size
  tabWidth: 40.0,
  tabHeight: 80.0,

  // Colors
  baseColor: null, // Defaults to theme's inverseSurface
  tabColor: null, // Defaults to the base color
  foregroundColor: null, // Defaults to theme's onInverseSurface
  selectedItemBorderColor: null, // Defaults to the foreground color
  selectedItemBackgroundColor: null, // Defaults to the base color

  // Divider Appearance
  dividerThickness: 0.5,
  dividerIndent: 8.0,

  // Opacity
  tabOpacity: 0.7,
  menuOpacity: 1.0,
  useBackgroundOverlay: true,
  backgroundOverlayOpacity: 0.5,

  // Animation
  showDuration: Duration(milliseconds: 250),
  showCurve: Curves.easeInOut,
  hideDuration: Duration(milliseconds: 250),
  hideCurve: Curves.easeInOut,

  // Behavior
  openOnTabHover: false,
  closeMenuOnTap: true,
  autoHide: false,
  autoHideDelay: Duration(seconds: 3),
);
```

## Menu Alignments

The menu can be positioned at various points along the screen edges:

- `MenuAlignment.topLeft`
- `MenuAlignment.centerLeft`
- `MenuAlignment.bottomLeft`
- `MenuAlignment.topRight`
- `MenuAlignment.centerRight`
- `MenuAlignment.bottomRight`

## Auto Layout

The menu will automatically choose between vertical and horizontal layouts based on the number of items, unless overridden:

- For 3 or fewer items: Horizontal layout
- For 4 or more items: Vertical layout

You can explicitly set the `axis` parameter to override this behavior.

## Theme Integration

The menu automatically integrates with Material Design 3 theme colors:

- Base color defaults to `colorScheme.inverseSurface`
- Foreground color defaults to `colorScheme.onInverseSurface`

This provides a nice contrast with your app's primary colors while maintaining theme consistency.

## Dividers

You can add dividers to your menu to visually separate groups of items:

<?code-excerpt "doc_examples/divider_example.dart (divider-example)"?>

```dart
final menuItems = [
  PullTabMenuItem(label: 'Logout', icon: Icons.logout),
  PullTabMenuItem.divider(), // Add a divider
  PullTabMenuItem(label: 'Home', icon: Icons.home),
  PullTabMenuItem(label: 'Profile', icon: Icons.person),
  PullTabMenuItem(label: 'Settings', icon: Icons.settings),
];
```

Dividers automatically adapt to the menu orientation (horizontal or vertical).
