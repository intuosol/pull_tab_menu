// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:pull_tab_menu/pull_tab_menu.dart';

// Used for documentation purposes

// #docregion config-options
PullTabMenuConfiguration configuration = PullTabMenuConfiguration(
  // Position
  initialAlignment: MenuAlignment.centerRight,

  // Layout
  axis: Axis.horizontal,

  // Dimensions
  tabWidth: 50.0,
  tabHeight: 100.0,
  itemSize: 48.0,
  menuBreadth: 60.0,

  // Colors
  baseColor: Colors.grey[900],
  tabColor: Colors.orange,
  foregroundColor: Colors.white,

  // Opacity
  tabOpacity: 0.7,
  menuOpacity: 1.0,
  overlayOpacity: 0.5,

  // Behavior
  autoHide: true,
  autoHideDelay: const Duration(seconds: 3),
  closeMenuOnTap: true,
  allowDragging: true,
  openOnTabHover: true,
  useOverlay: true,

  // Animation
  animationDuration: const Duration(milliseconds: 400),
  animationCurve: Curves.easeOutBack,

  // Appearance
  elevation: 8.0,
  borderRadius: 16.0,
  maxMenuHeightFactor: 0.7,

  // Dividers
  dividerThickness: 0.5,
  dividerIndent: 8.0,
);
// #enddocregion config-options
