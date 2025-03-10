import 'package:flutter/material.dart';
import 'package:pull_tab_menu/pull_tab_menu.dart';

// These examples are used solely for documentation purposes

// #docregion divider-example
final List<PullTabMenuItem> menuItems = <PullTabMenuItem>[
  const PullTabMenuItem(label: 'Logout', icon: Icons.logout),
  const PullTabMenuItem.divider(), // Add a divider
  const PullTabMenuItem(label: 'Home', icon: Icons.home),
  const PullTabMenuItem(label: 'Profile', icon: Icons.person),
  const PullTabMenuItem(label: 'Settings', icon: Icons.settings),
];
// #enddocregion divider-example
