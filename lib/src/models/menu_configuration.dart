import 'package:flutter/material.dart';

import 'menu_alignment.dart';

/// Configuration options for the pull tab menu.
class PullTabMenuConfiguration {
  /// Creates a new menu configuration.
  const PullTabMenuConfiguration({
    this.initialAlignment = MenuAlignment.centerRight,
    this.allowRepositioning = true,
    this.axis,
    this.margin = 8.0,
    this.borderRadius = 8.0,
    this.itemExtent = 48.0,
    this.menuBreadth = 60.0,
    this.tabWidth = 40.0,
    this.tabHeight = 80.0,
    this.baseColor,
    this.tabColor,
    this.foregroundColor,
    this.selectedItemBorderColor,
    this.selectedItemBackgroundColor,
    this.dividerThickness = 0.5,
    this.dividerIndent = 8.0,
    this.tabOpacity = 0.7,
    this.menuOpacity = 1,
    this.useBackgroundOverlay = true,
    this.backgroundOverlayOpacity = 0.5,
    this.showDuration = const Duration(milliseconds: 250),
    this.showCurve = Curves.easeInOut,
    this.hideDuration = const Duration(milliseconds: 250),
    this.hideCurve = Curves.easeInOut,
    this.openOnTabHover = false,
    this.closeMenuOnTap = true,
    this.autoHide = false,
    this.autoHideDelay = const Duration(seconds: 3),
  });

  /// The initial alignment of the menu.
  final MenuAlignment initialAlignment;

  /// The axis in which the items are displayed in the menu.
  /// Defaults to vertical, but will automatically use horizontal for fewer than 4 items
  /// unless explicitly specified.
  final Axis? axis;

  /// The width of the tab.
  final double tabWidth;

  /// The height of the tab.
  /// Defaults to [menuBreadth] if axis is horizontal.
  final double tabHeight;

  /// The base color used for both the menu and the tab if specific colors are not set.
  /// Defaults to theme's inverseSurface color.
  final Color? baseColor;

  /// Gets the base color, defaulting to theme's inverseSurface color if not specified
  Color getBaseColor(BuildContext context) {
    return baseColor ?? Theme.of(context).colorScheme.inverseSurface;
  }

  /// The color of the tab. If null, uses [baseColor].
  /// If both are null, defaults to theme's inverseSurface color.
  final Color? tabColor;

  /// Gets the tab color, using [baseColor] as fallback and then theme color
  Color getTabColor(BuildContext context) {
    if (tabColor != null) {
      return tabColor!;
    }
    return getBaseColor(context);
  }

  /// The opacity of the tab when the menu is closed.
  /// Animates to [menuOpacity] when the menu is opened.
  final double tabOpacity;

  /// The opacity of the menu panel.
  final double menuOpacity;

  /// The color of text and icons, defaults to theme's onInverseSurface
  final Color? foregroundColor;

  /// Gets the foreground color, defaulting to theme's onInverseSurface if not specified
  Color getForegroundColor(BuildContext context) {
    return foregroundColor ?? Theme.of(context).colorScheme.onInverseSurface;
  }

  /// Whether to automatically hide the menu after a delay.
  final bool autoHide;

  /// The delay before automatically hiding the menu.
  final Duration autoHideDelay;

  /// The duration of the show animation.
  final Duration showDuration;

  /// The duration of the hide animation.
  final Duration hideDuration;

  /// The curve used for the show animation.
  final Curve showCurve;

  /// The curve used for the hide animation.
  final Curve hideCurve;

  /// The border radius of the menu panel and tab.
  final double borderRadius;

  /// The opacity of the overlay when the menu is open.
  final double backgroundOverlayOpacity;

  /// Whether to show a background overlay when the menu is open
  final bool useBackgroundOverlay;

  /// The extent of each item in the menu
  final double itemExtent;

  /// The breadth of the menu
  final double menuBreadth;

  /// Close the menu when an item is tapped
  final bool closeMenuOnTap;

  /// Allow repositioning of the menu by dragging the tab
  final bool allowRepositioning;

  /// Open when hovering over the tab
  final bool openOnTabHover;

  /// Background color for selected menu items (null uses [baseColor])
  final Color? selectedItemBackgroundColor;

  /// Border color for selected menu items (null uses [foregroundColor])
  final Color? selectedItemBorderColor;

  /// The margin around the menu
  final double margin;

  /// Thickness of dividers in the menu
  final double dividerThickness;

  /// Indent (spacing) around dividers
  final double dividerIndent;

  /// Creates a copy of this configuration with the given fields replaced.
  PullTabMenuConfiguration copyWith({
    MenuAlignment? initialAlignment,
    Axis? axis,
    double? tabWidth,
    double? tabHeight,
    Color? baseColor,
    Color? tabColor,
    double? tabOpacity,
    double? menuOpacity,
    Color? foregroundColor,
    bool? autoHide,
    Duration? autoHideDelay,
    Duration? showDuration,
    Duration? hideDuration,
    Curve? showCurve,
    Curve? hideCurve,
    double? borderRadius,
    double? backgroundOverlayOpacity,
    bool? useBackgroundOverlay,
    double? itemExtent,
    double? menuBreadth,
    bool? closeMenuOnTap,
    bool? allowRepositioning,
    bool? openOnTabHover,
    Color? selectedItemBackgroundColor,
    Color? selectedItemBorderColor,
    double? margin,
    double? dividerThickness,
    double? dividerIndent,
  }) {
    return PullTabMenuConfiguration(
      initialAlignment: initialAlignment ?? this.initialAlignment,
      axis: axis ?? this.axis,
      tabWidth: tabWidth ?? this.tabWidth,
      tabHeight: tabHeight ?? this.tabHeight,
      baseColor: baseColor ?? this.baseColor,
      tabColor: tabColor ?? this.tabColor,
      tabOpacity: tabOpacity ?? this.tabOpacity,
      menuOpacity: menuOpacity ?? this.menuOpacity,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      autoHide: autoHide ?? this.autoHide,
      autoHideDelay: autoHideDelay ?? this.autoHideDelay,
      showDuration: showDuration ?? this.showDuration,
      hideDuration: hideDuration ?? this.hideDuration,
      showCurve: showCurve ?? this.showCurve,
      hideCurve: hideCurve ?? this.hideCurve,
      borderRadius: borderRadius ?? this.borderRadius,
      backgroundOverlayOpacity:
          backgroundOverlayOpacity ?? this.backgroundOverlayOpacity,
      useBackgroundOverlay: useBackgroundOverlay ?? this.useBackgroundOverlay,
      itemExtent: itemExtent ?? this.itemExtent,
      menuBreadth: menuBreadth ?? this.menuBreadth,
      closeMenuOnTap: closeMenuOnTap ?? this.closeMenuOnTap,
      allowRepositioning: allowRepositioning ?? this.allowRepositioning,
      openOnTabHover: openOnTabHover ?? this.openOnTabHover,
      selectedItemBackgroundColor:
          selectedItemBackgroundColor ?? this.selectedItemBackgroundColor,
      selectedItemBorderColor:
          selectedItemBorderColor ?? this.selectedItemBorderColor,
      margin: margin ?? this.margin,
      dividerThickness: dividerThickness ?? this.dividerThickness,
      dividerIndent: dividerIndent ?? this.dividerIndent,
    );
  }
}
