// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:pull_tab_menu/pull_tab_menu.dart';

// Used for documentation purposes

// #docregion config-options
PullTabMenuConfiguration configuration = const PullTabMenuConfiguration(
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
// #enddocregion config-options
