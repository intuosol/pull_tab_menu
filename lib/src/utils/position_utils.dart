import 'package:flutter/material.dart';

import '../models/menu_alignment.dart';

/// Utility class for calculating positions for the pull tab menu.
class PositionUtils {
  PositionUtils._();

  /// Calculates the position of the tab based on the menu alignment enum.
  static Offset calculateTabPosition({
    required MenuAlignment alignment,
    required Size screenSize,
    required double menuLength,
    required double totalWidth,
  }) {
    double left = 0;
    double top = 0;
    switch (alignment) {
      case MenuAlignment.topLeft:
        left = 0;
        top = 0;
      case MenuAlignment.centerLeft:
        left = 0;
        top = (screenSize.height - menuLength) / 2;
      case MenuAlignment.bottomLeft:
        left = 0;
        top = screenSize.height;
      case MenuAlignment.topRight:
        left = screenSize.width - totalWidth;
        top = 0;
      case MenuAlignment.centerRight:
        left = screenSize.width - totalWidth;
        top = (screenSize.height - menuLength) / 2;
      case MenuAlignment.bottomRight:
        left = screenSize.width - totalWidth;
        top = screenSize.height;
    }

    return Offset(left, top);
  }
}
