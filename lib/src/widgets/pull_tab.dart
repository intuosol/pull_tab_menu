import 'package:flutter/material.dart';

import '../controllers/pull_tab_controller.dart';
import '../models/menu_configuration.dart';
import '../models/tab_position.dart';

/// The tab widget that appears on the edge of the screen.
class PullTab extends StatelessWidget {
  /// Creates a new pull tab.
  const PullTab({
    super.key,
    required this.configuration,
    required this.controller,
    required this.onTap,
    required this.onDragStart,
    required this.onDragUpdate,
  });

  /// The configuration for the tab.
  final PullTabMenuConfiguration configuration;

  /// The controller for the tab.
  final PullTabController controller;

  /// Callback function when the tab is tapped.
  final VoidCallback onTap;

  /// Callback function when dragging starts.
  final VoidCallback onDragStart;

  /// Callback function when dragging updates.
  final void Function(DragUpdateDetails) onDragUpdate;

  @override
  Widget build(BuildContext context) {
    // When the tab is connected to the menu, we need to round only the outer corners
    // The side touching the menu should never have a border radius
    final BorderRadius borderRadius =
        configuration.menuPosition.isRight
            ? BorderRadius.only(
              topLeft: Radius.circular(configuration.borderRadius),
              bottomLeft: Radius.circular(configuration.borderRadius),
            )
            : BorderRadius.only(
              topRight: Radius.circular(configuration.borderRadius),
              bottomRight: Radius.circular(configuration.borderRadius),
            );

    return GestureDetector(
      onTap: onTap,
      onPanStart: (_) => onDragStart(),
      onPanUpdate: onDragUpdate,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: configuration.tabWidth,
        height: configuration.tabHeight,
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
        child: Center(
          child: AnimatedRotation(
            duration: Durations.short2,
            turns: controller.isMenuOpen ? 0.5 : 0,
            child: Icon(
              configuration.menuPosition.isLeft
                  ? Icons.chevron_right
                  : Icons.chevron_left,
              color: configuration.getForegroundColor(context),
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
