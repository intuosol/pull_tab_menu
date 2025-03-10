import 'package:flutter/material.dart';
import 'tab_position.dart';

/// Configuration options for the pull tab menu.
class PullTabMenuConfiguration {
  /// Creates a new menu configuration.
  const PullTabMenuConfiguration({
    this.menuPosition = MenuPosition.centerRight,
    this.axis = Axis.vertical,
    this.tabWidth = 40.0,
    this.tabHeight = 80.0,
    this.baseColor,
    this.tabColor,
    this.tabOpacity = 0.7,
    this.menuOpacity = 1,
    this.foregroundColor,
    this.autoHide = false,
    this.autoHideDelay = const Duration(seconds: 3),
    this.animationDuration = const Duration(milliseconds: 250),
    this.animationCurve = Curves.easeInOut,
    this.elevation = 4.0,
    this.borderRadius = 8.0,
    this.overlayOpacity = 0.5,
    this.useOverlay = true,
    this.maxMenuHeightFactor = 0.7,
    double? minMenuSize,
    this.itemSize = 48.0,
    this.railBreadth = 60.0,
    this.closeMenuOnTap = true,
    this.allowDragging = true,
    this.openOnTabHover = false,
    this.selectedItemBackgroundColor,
    this.selectedItemBorderColor,
    this.verticalPadding = EdgeInsets.zero,
    this.dividerThickness = 0.5,
    this.dividerIndent = 8.0,
  }) : _minMenuSize = minMenuSize;

  /// The position of the menu on the screen.
  final MenuPosition menuPosition;

  /// The axis in which the items are displayed in the menu.
  /// Defaults to vertical, but will automatically use horizontal for fewer than 4 items
  /// unless explicitly specified.
  final Axis axis;

  /// The width of the tab.
  final double tabWidth;

  /// The height of the tab.
  final double tabHeight;

  /// The base color used for both the menu and the tab if specific colors are not set.
  /// Defaults to theme's inverseSurface color.
  final Color? baseColor;

  /// The color of the tab. If null, uses [baseColor].
  /// If both are null, defaults to theme's inverseSurface color.
  final Color? tabColor;

  /// The opacity of the tab when the menu is closed.
  /// Animates to [menuOpacity] when the menu is opened.
  final double tabOpacity;

  /// Gets the tab color, using [baseColor] as fallback and then theme color
  Color getTabColor(BuildContext context) {
    if (tabColor != null) {
      return tabColor!;
    }
    return getBaseColor(context);
  }

  /// Gets the base color, defaulting to theme's inverseSurface color if not specified
  Color getBaseColor(BuildContext context) {
    return baseColor ?? Theme.of(context).colorScheme.inverseSurface;
  }

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

  /// The duration of the show/hide animations.
  final Duration animationDuration;

  /// The curve used for the show/hide animations.
  final Curve animationCurve;

  /// The elevation of the menu panel.
  final double elevation;

  /// The border radius of the menu panel and tab.
  final double borderRadius;

  /// The opacity of the overlay when the menu is open.
  final double overlayOpacity;

  /// Whether to show an overlay when the menu is open.
  final bool useOverlay;

  /// Maximum menu height as a factor of screen height (0.0 to 1.0)
  final double maxMenuHeightFactor;

  /// Minimum menu size in pixels for both width and height
  final double? _minMenuSize;
  double get minMenuSize => _minMenuSize ?? tabHeight;

  /// The size of each item in the menu
  final double itemSize;

  /// The breadth of the rail
  final double railBreadth;

  /// Close the menu when an item is tapped
  final bool closeMenuOnTap;

  /// Allow dragging of the tab
  final bool allowDragging;

  /// Open when hovering over the tab
  final bool openOnTabHover;

  /// Background color for selected menu items (null uses [baseColor])
  final Color? selectedItemBackgroundColor;

  /// Border color for selected menu items (null uses [foregroundColor])
  final Color? selectedItemBorderColor;

  /// Vertical padding for the menu
  final EdgeInsets verticalPadding;

  /// Thickness of dividers in the menu
  final double dividerThickness;

  /// Indent (spacing) around dividers
  final double dividerIndent;

  /// Creates a copy of this configuration with the given fields replaced.
  PullTabMenuConfiguration copyWith({
    MenuPosition? menuPosition,
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
    Duration? animationDuration,
    Curve? animationCurve,
    double? elevation,
    Duration? sizeDuration,
    double? borderRadius,
    double? overlayOpacity,
    bool? useOverlay,
    double? maxMenuWidthFactor,
    double? maxMenuHeightFactor,
    double? minMenuSize,
    double? itemSize,
    double? railBreadth,
    bool? closeMenuOnTap,
    bool? allowDragging,
    bool? openOnTabHover,
    bool? closeOnHoverExit,
    Color? selectedItemBackgroundColor,
    Color? selectedItemBorderColor,
    EdgeInsets? verticalPadding,
    double? dividerThickness,
    double? dividerIndent,
  }) {
    return PullTabMenuConfiguration(
      menuPosition: menuPosition ?? this.menuPosition,
      axis: axis ?? this.axis,
      tabWidth: tabWidth ?? this.tabWidth,
      tabHeight: tabHeight ?? this.tabHeight,
      baseColor: baseColor ?? this.baseColor,
      tabColor: tabColor ?? this.tabColor,
      tabOpacity: tabOpacity ?? this.tabOpacity,
      menuOpacity: menuOpacity ?? this.menuOpacity,
      foregroundColor: foregroundColor ?? foregroundColor,
      autoHide: autoHide ?? this.autoHide,
      autoHideDelay: autoHideDelay ?? this.autoHideDelay,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      elevation: elevation ?? this.elevation,
      borderRadius: borderRadius ?? this.borderRadius,
      overlayOpacity: overlayOpacity ?? this.overlayOpacity,
      useOverlay: useOverlay ?? this.useOverlay,
      maxMenuHeightFactor: maxMenuHeightFactor ?? this.maxMenuHeightFactor,
      minMenuSize: minMenuSize ?? _minMenuSize,
      itemSize: itemSize ?? this.itemSize,
      railBreadth: railBreadth ?? this.railBreadth,
      closeMenuOnTap: closeMenuOnTap ?? this.closeMenuOnTap,
      allowDragging: allowDragging ?? this.allowDragging,
      openOnTabHover: openOnTabHover ?? this.openOnTabHover,
      selectedItemBackgroundColor:
          selectedItemBackgroundColor ?? this.selectedItemBackgroundColor,
      selectedItemBorderColor:
          selectedItemBorderColor ?? this.selectedItemBorderColor,
      verticalPadding: verticalPadding ?? this.verticalPadding,
      dividerThickness: dividerThickness ?? this.dividerThickness,
      dividerIndent: dividerIndent ?? this.dividerIndent,
    );
  }
}
