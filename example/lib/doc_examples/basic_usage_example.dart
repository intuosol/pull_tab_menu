import 'package:flutter/material.dart';
import 'package:pull_tab_menu/pull_tab_menu.dart';

// #docregion basic-usage
// Basic example of using a pull tab menu
Scaffold buildBasicExample(BuildContext context) {
  // Create menu items
  final List<PullTabMenuItem> menuItems = <PullTabMenuItem>[
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
    appBar: AppBar(title: const Text('Pull Tab Menu Demo')),
    body: PullTabMenu(
      menuItems: menuItems,
      child: const Center(
        child: Text('Pull from the right edge to open the menu'),
      ),
    ),
  );
}

// #enddocregion basic-usage
