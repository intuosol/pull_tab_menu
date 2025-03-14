import 'package:flutter/material.dart';

import '../controllers/pull_tab_controller.dart';
import '../models/menu_configuration.dart';

/// The tab widget that appears on the edge of the screen.
class PullTab extends StatelessWidget {
  /// Creates a new pull tab.
  const PullTab({
    super.key,
    required this.configuration,
    required this.controller,
    required this.isLeftEdge,
    required this.onTap,
    required this.onDragStart,
    required this.onDragUpdate,
    required this.onDragEnd,
  });

  /// The configuration for the tab.
  final PullTabMenuConfiguration configuration;

  /// The controller for the tab.
  final PullTabController controller;

  /// Whether the menu is on the left edge of the screen.
  final bool isLeftEdge;

  /// Callback function when the tab is tapped.
  final VoidCallback onTap;

  /// Callback function when dragging starts.
  final VoidCallback onDragStart;

  /// Callback function when dragging updates.
  final void Function(DragUpdateDetails) onDragUpdate;

  /// Callback function when dragging ends.
  final VoidCallback onDragEnd;

  double get tabHeight {
    if (configuration.axis == Axis.horizontal) {
      return configuration.tabHeight < configuration.menuBreadth
          ? configuration.menuBreadth
          : configuration.tabHeight;
    } else {
      return configuration.tabHeight;
    }
  }

  BorderRadius get borderRadius {
    if (isLeftEdge) {
      return BorderRadius.only(
        topRight: Radius.circular(configuration.borderRadius),
        bottomRight: Radius.circular(configuration.borderRadius),
      );
    }
    return BorderRadius.only(
      topLeft: Radius.circular(configuration.borderRadius),
      bottomLeft: Radius.circular(configuration.borderRadius),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor:
          controller.isDragging
              ? SystemMouseCursors.grabbing
              : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        onPanStart: (_) => onDragStart(),
        onPanUpdate: onDragUpdate,
        onPanEnd: (_) => onDragEnd(),
        child: Container(
          width: configuration.tabWidth,
          height: tabHeight,
          decoration: BoxDecoration(
            color: configuration
                .getTabColor(context)
                .withValues(
                  alpha:
                      controller.isMenuOpen
                          ? configuration.menuOpacity
                          : configuration.tabOpacity,
                ),
            borderRadius: borderRadius,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: AnimatedRotation(
              duration: Durations.short2,
              turns: controller.isMenuOpen ? 0.5 : 0,
              child: Icon(
                isLeftEdge ? Icons.chevron_right : Icons.chevron_left,
                color: configuration.getForegroundColor(context),
                size: 28,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
