import 'package:flutter/material.dart';
import '../models/tab_position.dart';

/// Utility class for calculating positions for the pull tab menu.
class PositionUtils {
  /// Calculates the position of the tab based on the tab position enum.
  static Offset calculateTabPosition(
    MenuPosition position,
    Size screenSize,
    double tabWidth,
    double tabHeight,
  ) {
    double left = 0;
    double top = 0;

    switch (position) {
      case MenuPosition.topLeft:
        left = 0;
        top = screenSize.height * 0.1;
      case MenuPosition.centerLeft:
        left = 0;
        top = (screenSize.height - tabHeight) / 2;
      case MenuPosition.bottomLeft:
        left = 0;
        top = screenSize.height - tabHeight - screenSize.height * 0.1;
      case MenuPosition.topRight:
        left = screenSize.width - tabWidth;
        top = screenSize.height * 0.1;
      case MenuPosition.centerRight:
        left = screenSize.width - tabWidth;
        top = (screenSize.height - tabHeight) / 2;
      case MenuPosition.bottomRight:
        left = screenSize.width - tabWidth;
        top = screenSize.height - tabHeight - screenSize.height * 0.1;
    }

    return Offset(left, top);
  }
}
