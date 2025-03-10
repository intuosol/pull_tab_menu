# Pull Tab Menu

A customizable pull tab menu system for Flutter apps with edge tab activation and animations.

## Features

- Customizable tab that sits on the side edges of the screen (left or right)
- Tab can be dragged to any position along the edge
- Reveals a menu panel when tapped or pulled open
- Support for both vertical and horizontal menus
- Populate the menu with custom buttons (Icon and Label)
- Customizable animations for revealing/hiding the menu
- Visual indicator (arrow) on the tab showing the direction it can be pulled
- Auto-hide functionality
- Gesture-based interactions (swipe to open/close)
- Scroll through menu items with pagination
- Menu page indicators
- Can persist across the entire app or be used on individual pages
- Highly customizable appearance and behavior

## Installation

Add `pull_tab_menu` to your `pubspec.yaml`:

```yaml
dependencies:
  pull_tab_menu: ^0.0.1
```

## Usage

### Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:pull_tab_menu/pull_tab_menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Create menu items
    final menuItems = [
      PullTabMenuItem(
        id: '1',
        label: 'Home',
        icon: Icons.home,
        onTap: () {
          print('Home tapped');
        },
      ),
      PullTabMenuItem(
        id: '2',
        label: 'Settings',
        icon: Icons.settings,
        onTap: () {
          print('Settings tapped');
        },
      ),
      PullTabMenuItem(
        id: '3',
        label: 'Profile',
        icon: Icons.person,
        onTap: () {
          print('Profile tapped');
        },
      ),
    ];

    return PullTabMenu(
      menuItems: menuItems,
      configuration: const PullTabMenuConfiguration(
        tabPosition: TabPosition.centerRight,
        tabColor: Colors.blue,
        showArrowIndicator: true,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pull Tab Menu Demo'),
        ),
        body: const Center(
          child: Text('Pull from the right edge to open the menu'),
        ),
      ),
    );
  }
}
```

### Advanced Usage - Grouped Menu Items

```dart
// Create menu groups
final menuGroups = [
  PullTabMenuGroup(
    id: 'main',
    title: 'Main Menu',
    items: [
      PullTabMenuItem(
        id: '1',
        label: 'Home',
        icon: Icons.home,
        onTap: () {
          print('Home tapped');
        },
      ),
      PullTabMenuItem(
        id: '2',
        label: 'Settings',
        icon: Icons.settings,
        onTap: () {
          print('Settings tapped');
        },
      ),
    ],
  ),
  PullTabMenuGroup(
    id: 'account',
    title: 'Account',
    items: [
      PullTabMenuItem(
        id: '3',
        label: 'Profile',
        icon: Icons.person,
        onTap: () {
          print('Profile tapped');
        },
      ),
      PullTabMenuItem(
        id: '4',
        label: 'Logout',
        icon: Icons.logout,
        onTap: () {
          print('Logout tapped');
        },
      ),
    ],
  ),
];

// Use the menu with groups
PullTabMenu(
  menuGroups: menuGroups,
  configuration: const PullTabMenuConfiguration(
    tabPosition: TabPosition.centerRight,
    tabColor: Colors.blue,
    showPageIndicator: true,
  ),
  child: Scaffold(
    // ...
  ),
)
```

### Using a Controller for Programmatic Control

```dart
class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final PullTabController _controller = PullTabController();
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Controlled Menu Demo'),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _controller.toggleMenu();
            },
          ),
        ],
      ),
      body: PullTabMenu(
        controller: _controller,
        menuItems: [
          // menu items...
        ],
        child: Center(
          child: Text('Use the app bar button to open/close the menu'),
        ),
      ),
    );
  }
}
```

### Creating a Persistent Menu Across All Screens

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          // Create the persistent menu once the context is available
          WidgetsBinding.instance.addPostFrameCallback((_) {
            PullTabMenu.createPersistentMenu(
              context: context,
              menuItems: [
                PullTabMenuItem(
                  id: '1',
                  label: 'Home',
                  icon: Icons.home,
                  onTap: () {
                    Navigator.pushNamed(context, '/');
                  },
                ),
                PullTabMenuItem(
                  id: '2',
                  label: 'Settings',
                  icon: Icons.settings,
                  onTap: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
              ],
              configuration: const PullTabMenuConfiguration(
                tabPosition: TabPosition.bottomRight,
                tabColor: Colors.indigo,
              ),
            );
          });
          
          return HomeScreen();
        },
      ),
      routes: {
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
```

## Customization

The `PullTabMenuConfiguration` class provides extensive customization options:

```dart
PullTabMenuConfiguration(
  // Tab positioning
  tabPosition: TabPosition.centerRight,
  tabEdge: TabEdge.right,
  
  // Menu orientation
  menuOrientation: MenuOrientation.vertical,
  
  // Dimensions
  tabWidth: 40.0,
  tabHeight: 80.0,
  menuWidth: 250.0,
  menuHeight: 300.0,
  
  // Colors
  tabColor: Colors.blue,
  menuColor: Colors.white,
  arrowColor: Colors.white,
  
  // Behavior
  showArrowIndicator: true,
  autoHide: false,
  autoHideDelay: Duration(seconds: 3),
  
  // Animation
  animationDuration: Duration(milliseconds: 250),
  animationCurve: Curves.easeInOut,
  
  // Appearance
  elevation: 4.0,
  borderRadius: 8.0,
  
  // Drag handle
  dragHandleWidth: 20.0,
  dragHandleHeight: 40.0,
  shouldUseDragHandle: true,
  
  // Overlay
  overlayOpacity: 0.5,
  useOverlay: true,
  
  // Page indicator
  showPageIndicator: true,
  pageIndicatorActiveColor: Colors.blue,
  pageIndicatorInactiveColor: Colors.grey,
);
```

## Available Tab Positions

- `TabPosition.topLeft`
- `TabPosition.centerLeft`
- `TabPosition.bottomLeft`
- `TabPosition.topRight`
- `TabPosition.centerRight`
- `TabPosition.bottomRight`

## Menu Orientation

- `MenuOrientation.vertical`
- `MenuOrientation.horizontal`

## Tab Edge

- `TabEdge.left`
- `TabEdge.right`

## License

This project is licensed under the MIT License - see the LICENSE file for details.
