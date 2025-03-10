import 'package:flutter/material.dart';

/// Represents an item in the pull tab menu.
class PullTabMenuItem {
  /// Creates a new menu item.
  const PullTabMenuItem({
    required this.label,
    required this.icon,
    this.onTap,
    this.iconColor,
    this.isSelected = false,
  }) : isDivider = false;

  /// Creates a divider item to separate groups of menu items.
  ///
  /// For horizontal menus, creates a vertical divider.
  /// For vertical menus, creates a horizontal divider.
  const PullTabMenuItem.divider()
    : label = '',
      icon = Icons.minimize,
      onTap = null,
      iconColor = null,
      isSelected = false,
      isDivider = true;

  /// Text to be displayed in the tooltip of the menu item.
  final String label;

  /// Icon to be displayed in the menu item.
  final IconData icon;

  /// Callback function to be executed when the menu item is tapped.
  final VoidCallback? onTap;

  /// The color of the icon.
  final Color? iconColor;

  /// Whether the menu item is currently selected.
  final bool isSelected;

  /// Whether this item is a divider instead of a regular menu item.
  /// Internal use only - use PullTabMenuItem.divider() to create dividers.
  final bool isDivider;
}
