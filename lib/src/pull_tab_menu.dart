import 'dart:async';

import 'package:flutter/material.dart';

import 'controllers/pull_tab_controller.dart';
import 'models/menu_configuration.dart';
import 'models/menu_item.dart';
import 'models/tab_position.dart';
import 'utils/position_utils.dart';
import 'widgets/pull_tab.dart';

/// A menu system that is activated by a tab on the edge of the screen.
class PullTabMenu extends StatefulWidget {
  /// Creates a new pull tab menu.
  const PullTabMenu({
    super.key,
    required this.child,
    required this.menuItems,
    this.controller,
    this.configuration = const PullTabMenuConfiguration(),
  });

  /// The child widget to display behind the menu.
  final Widget child;

  /// The controller for the menu.
  final PullTabController? controller;

  /// The list of menu items to display.
  final List<PullTabMenuItem> menuItems;

  /// The configuration for the menu.
  final PullTabMenuConfiguration configuration;

  @override
  State<PullTabMenu> createState() => _PullTabMenuState();
}

class _PullTabMenuState extends State<PullTabMenu>
    with SingleTickerProviderStateMixin {
  late PullTabController _controller;
  late AnimationController _animationController;
  late Animation<double> _animation;
  Offset _tabPosition = Offset.zero;
  Timer? _autoHideTimer;

  late PullTabMenuConfiguration _configuration;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? PullTabController();
    _controller.menuItems = widget.menuItems;

    // Auto-select horizontal axis if few items and axis not explicitly set
    final bool shouldUseHorizontal = widget.menuItems.length < 4;
    final bool isAxisExplicitlySet =
        widget.configuration != const PullTabMenuConfiguration() &&
        widget.configuration.axis != const PullTabMenuConfiguration().axis;

    if (shouldUseHorizontal && !isAxisExplicitlySet) {
      _configuration = widget.configuration.copyWith(axis: Axis.horizontal);
    } else {
      _configuration = widget.configuration;
    }

    _animationController = AnimationController(
      vsync: this,
      duration: _configuration.animationDuration,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: _configuration.animationCurve,
    );

    _controller.addListener(_onControllerUpdate);

    // Load saved tab position if dragging is allowed
    if (_configuration.allowDragging) {
      _loadSavedTabPosition();
    }
  }

  Future<void> _loadSavedTabPosition() async {
    final Map<String, double> savedPosition =
        await _controller.loadTabPosition();
    if (savedPosition['top'] != 0.0 || savedPosition['left'] != 0.0) {
      setState(() {
        _tabPosition = Offset(savedPosition['left']!, savedPosition['top']!);
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _controller.removeListener(_onControllerUpdate);
    }
    _autoHideTimer?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(PullTabMenu oldWidget) {
    super.didUpdateWidget(oldWidget);

    bool configNeedsUpdate = false;

    if (widget.controller != oldWidget.controller) {
      if (oldWidget.controller == null) {
        _controller.dispose();
      } else {
        oldWidget.controller!.removeListener(_onControllerUpdate);
      }

      _controller = widget.controller ?? PullTabController();
      _controller.addListener(_onControllerUpdate);
    }

    if (widget.menuItems != oldWidget.menuItems) {
      _controller.menuItems = widget.menuItems;
      configNeedsUpdate = true;
    }

    // Update axis if needed based on item count
    if (configNeedsUpdate) {
      final bool shouldUseHorizontal = widget.menuItems.length < 4;
      final bool isAxisExplicitlySet =
          widget.configuration != const PullTabMenuConfiguration() &&
          widget.configuration.axis != const PullTabMenuConfiguration().axis;

      if (shouldUseHorizontal && !isAxisExplicitlySet) {
        _configuration = widget.configuration.copyWith(axis: Axis.horizontal);
      } else {
        _configuration = widget.configuration;
      }
    }
  }

  void _onControllerUpdate() {
    if (_controller.isMenuOpen) {
      _animationController.forward();
      _startAutoHideTimer();
    } else {
      _animationController.reverse();
      _autoHideTimer?.cancel();
    }
    setState(() {});
  }

  void _startAutoHideTimer() {
    if (_configuration.autoHide) {
      _autoHideTimer?.cancel();
      _autoHideTimer = Timer(
        _configuration.autoHideDelay,
        () => _controller.closeMenu(),
      );
    }
  }

  void _onHover(PointerEvent event) {
    _startAutoHideTimer();
  }

  void _onTabHover(PointerEvent event) {
    if (_configuration.openOnTabHover) {
      _controller.openMenu();
    }
  }

  void _onTabTap() {
    _controller.toggleMenu();
    _startAutoHideTimer();
  }

  void _onTabDragStart() {
    if (!_configuration.allowDragging) {
      return;
    }
    _controller.setDragging(true);
  }

  void _onTabDragUpdate(DragUpdateDetails details) {
    if (!_configuration.allowDragging) {
      return;
    }

    setState(() {
      final Offset newPosition = Offset(
        _tabPosition.dx + details.delta.dx,
        _tabPosition.dy + details.delta.dy,
      );

      // Make sure the tab doesn't go off-screen
      final Size screenSize = MediaQuery.of(context).size;
      final double tabWidth = _configuration.tabWidth;
      final double tabHeight = _configuration.tabHeight;

      final double constrainedX = newPosition.dx.clamp(
        0.0,
        screenSize.width - tabWidth,
      );

      final double constrainedY = newPosition.dy.clamp(
        0.0,
        screenSize.height - tabHeight,
      );
      // switch edge if the tab exceeds half of the screen width
      _configuration = _configuration.copyWith(
        menuPosition: _configuration.menuPosition,
      );

      _tabPosition = Offset(constrainedX, constrainedY);
      _controller.updateDragPosition(_tabPosition.dy);
    });
  }

  @override
  Widget build(BuildContext context) {
    // If no menu items are provided, return the child widget
    if (_controller.menuItems.isEmpty) {
      return widget.child;
    }

    // Get the available space - use layout builder to ensure we have a valid render box
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size availableSpace = Size(
          constraints.maxWidth,
          constraints.maxHeight,
        );
        final double tabWidth = _configuration.tabWidth;
        final double tabHeight = _configuration.tabHeight;
        final bool isVertical = _configuration.axis == Axis.vertical;

        // Calculate the tab position based on the configuration
        final Offset initialTabPosition =
            _tabPosition == Offset.zero
                ? PositionUtils.calculateTabPosition(
                  _configuration.menuPosition,
                  availableSpace,
                  tabWidth,
                  tabHeight,
                )
                : _tabPosition;

        // Determine edge that the tab is attached to
        final bool isLeftEdge = _configuration.menuPosition.isLeft;

        // Calculate total width needed for menu + tab
        double menuWidth;
        double totalWidth;

        // Dynamically calculate menu height based on number of items
        double calculatedMenuHeight;

        // Apply vertical padding from configuration
        final double topPadding = _configuration.verticalPadding.top;
        final double bottomPadding = _configuration.verticalPadding.bottom;
        final double availableHeight =
            availableSpace.height - topPadding - bottomPadding;

        if (isVertical) {
          // Calculate width based on items
          menuWidth = _configuration.railBreadth;
          totalWidth = menuWidth + tabWidth;

          // Calculate height based on items, accounting for dividers
          double totalHeight = 0;
          for (final PullTabMenuItem item in _controller.menuItems) {
            if (item.isDivider) {
              totalHeight += _configuration.dividerIndent * 2; // Divider height
            } else {
              totalHeight += _configuration.itemSize; // Regular item height
            }
          }
          calculatedMenuHeight = totalHeight + 8; // Add padding

          // Constrain to min/max size
          calculatedMenuHeight = calculatedMenuHeight.clamp(
            _configuration.minMenuSize,
            availableHeight * _configuration.maxMenuHeightFactor,
          );
        } else {
          // Calculate width based on items, accounting for dividers
          double totalItemWidth = 0;
          for (final PullTabMenuItem item in _controller.menuItems) {
            if (item.isDivider) {
              totalItemWidth +=
                  _configuration.dividerIndent * 2; // Divider width
            } else {
              totalItemWidth += _configuration.itemSize; // Regular item width
            }
          }
          menuWidth = totalItemWidth + 8; // Add padding
          totalWidth = menuWidth + tabWidth;

          // Calculate height based on items
          calculatedMenuHeight = _configuration.railBreadth;

          // Constrain to min/max size
          menuWidth = menuWidth.clamp(
            _configuration.minMenuSize,
            availableSpace.width * _configuration.maxMenuHeightFactor,
          );
        }

        // Calculate the position of the menu
        double menuTop;

        // Ensure the menu doesn't go off-screen vertically and respect vertical padding
        if (isVertical) {
          menuTop =
              initialTabPosition.dy - (calculatedMenuHeight - tabHeight) / 2;
          menuTop = menuTop.clamp(
            topPadding,
            availableSpace.height - calculatedMenuHeight - bottomPadding,
          );
        } else {
          menuTop = initialTabPosition.dy - _configuration.railBreadth / 2;
          menuTop = menuTop.clamp(
            topPadding,
            availableSpace.height - _configuration.railBreadth - bottomPadding,
          );
        }

        return Stack(
          children: <Widget>[
            widget.child,
            if (_controller.isMenuOpen && _configuration.useOverlay)
              AnimatedBuilder(
                animation: _animation,
                builder: (BuildContext context, Widget? child) {
                  return Positioned.fill(
                    child: GestureDetector(
                      onTap: _controller.closeMenu,
                      child: Container(
                        color: Colors.black.withValues(
                          alpha:
                              _configuration.overlayOpacity * _animation.value,
                        ),
                      ),
                    ),
                  );
                },
              ),
            // Combined menu and tab that slides together
            Positioned(
              left: isLeftEdge ? 0 : null,
              right: isLeftEdge ? null : 0,
              top: menuTop,
              child: Hero(
                tag: 'pull-tab-menu',
                child: MouseRegion(
                  onHover: _onHover,
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (BuildContext context, Widget? child) {
                      // Calculate how much the menu should slide
                      final double offsetX =
                          isLeftEdge
                              ? menuWidth *
                                  (_animation.value -
                                      1) // Slide right when opening
                              : -menuWidth *
                                  (_animation.value -
                                      1); // Slide left when opening

                      return Transform.translate(
                        offset: Offset(offsetX, 0),
                        child: SizedBox(
                          width: totalWidth,
                          height: calculatedMenuHeight,
                          child: CustomMultiChildLayout(
                            delegate: _TabMenuLayoutDelegate(
                              isLeftEdge: isLeftEdge,
                              menuWidth: menuWidth,
                              tabWidth: tabWidth,
                            ),
                            children: <Widget>[
                              if (_configuration.axis == Axis.horizontal)
                                LayoutId(
                                  id: 'menu',
                                  child: _buildMenu(
                                    menuPositionIsLeft:
                                        _configuration.menuPosition.isLeft,
                                    menuHeight: calculatedMenuHeight,
                                    menuWidth: menuWidth,
                                  ),
                                ),
                              LayoutId(
                                id: 'tab',
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  onHover: _onTabHover,
                                  child: PullTab(
                                    configuration: _configuration,
                                    controller: _controller,
                                    onTap: _onTabTap,
                                    onDragStart: _onTabDragStart,
                                    onDragUpdate: _onTabDragUpdate,
                                  ),
                                ),
                              ),
                              if (_configuration.axis == Axis.vertical)
                                LayoutId(
                                  id: 'menu',
                                  child: _buildMenu(
                                    menuPositionIsLeft:
                                        _configuration.menuPosition.isLeft,
                                    menuHeight: calculatedMenuHeight,
                                    menuWidth: menuWidth,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMenu({
    required bool menuPositionIsLeft,
    required double menuHeight,
    required double menuWidth,
  }) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: _configuration.railBreadth,
        height: menuHeight,
        decoration: BoxDecoration(
          color: _configuration
              .getBaseColor(context)
              .withValues(alpha: _configuration.menuOpacity),
          borderRadius:
              _controller.menuItems.length == 1 ||
                      _configuration.axis == Axis.horizontal
                  ? null
                  : menuPositionIsLeft
                  ? BorderRadius.only(
                    topRight: Radius.circular(_configuration.borderRadius),
                    bottomRight: Radius.circular(_configuration.borderRadius),
                  )
                  : BorderRadius.only(
                    topLeft: Radius.circular(_configuration.borderRadius),
                    bottomLeft: Radius.circular(_configuration.borderRadius),
                  ),
          boxShadow: <BoxShadow>[
            if (menuPositionIsLeft)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(2, 2),
              ),
            if (!menuPositionIsLeft)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(-2, 2),
              ),
          ],
        ),
        child: _buildMenuListView(),
      ),
    );
  }

  Widget _buildMenuListView() {
    // Get the menu items from the controller
    final List<PullTabMenuItem> itemsToDisplay = _controller.menuItems;

    return Center(
      child: ListView.builder(
        scrollDirection: _configuration.axis,
        itemCount: itemsToDisplay.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final PullTabMenuItem item = itemsToDisplay[index];
          return _buildItem(item: item);
        },
      ),
    );
  }

  Widget _buildIconWithIndicator(PullTabMenuItem menuItem) {
    final Color iconColor =
        menuItem.iconColor ?? _configuration.getForegroundColor(context);

    return Container(
      decoration:
          menuItem.isSelected
              ? BoxDecoration(
                color:
                    _configuration.selectedItemBackgroundColor ??
                    _configuration.getBaseColor(context).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _configuration.selectedItemBorderColor ?? iconColor,
                  width: 2,
                ),
              )
              : null,
      padding: const EdgeInsets.all(8),
      child: Icon(menuItem.icon, color: iconColor, size: 24),
    );
  }

  Widget _buildItem({required PullTabMenuItem item}) {
    // Return a divider if this item is a divider
    if (item.isDivider) {
      // Different dividers based on axis orientation
      if (_configuration.axis == Axis.horizontal) {
        return VerticalDivider(
          width: _configuration.dividerIndent,
          thickness: _configuration.dividerThickness,
          color: _configuration
              .getForegroundColor(context)
              .withValues(alpha: 0.3),
          indent: _configuration.dividerIndent,
          endIndent: _configuration.dividerIndent,
        );
      } else {
        return Divider(
          height: _configuration.dividerIndent,
          thickness: _configuration.dividerThickness,
          color: _configuration
              .getForegroundColor(context)
              .withValues(alpha: 0.3),
          indent: _configuration.dividerIndent,
          endIndent: _configuration.dividerIndent,
        );
      }
    }

    // For non-divider menu items
    final PullTabMenuItem menuItem = item;

    // Regular menu item
    return Tooltip(
      message: menuItem.label,
      verticalOffset:
          _configuration.axis == Axis.horizontal
              ? _configuration.itemSize * 0.6
              : -_configuration.itemSize * 0.25,
      exitDuration: Duration.zero,
      margin:
          _configuration.axis == Axis.vertical
              ? EdgeInsets.symmetric(horizontal: _configuration.itemSize)
              : null,
      child: SizedBox(
        height: _configuration.itemSize,
        width: _configuration.itemSize,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: IconButton(
            icon: _buildIconWithIndicator(menuItem),
            onPressed: () async {
              if (_configuration.closeMenuOnTap) {
                _controller.closeMenu();
                await Future<void>.delayed(
                  _configuration.animationDuration * 0.5,
                );
              }
              menuItem.onTap?.call();
            },
          ),
        ),
      ),
    );
  }
}

// Add this class outside the main class
class _TabMenuLayoutDelegate extends MultiChildLayoutDelegate {
  _TabMenuLayoutDelegate({
    required this.isLeftEdge,
    required this.menuWidth,
    required this.tabWidth,
  });
  final bool isLeftEdge;
  final double menuWidth;
  final double tabWidth;

  @override
  void performLayout(Size size) {
    Size tabSize = Size.zero;

    if (hasChild('menu')) {
      layoutChild(
        'menu',
        BoxConstraints.tightFor(width: menuWidth, height: size.height),
      );
    }

    if (hasChild('tab')) {
      tabSize = layoutChild('tab', BoxConstraints.loose(size));
    }

    // Position the menu and tab such that they stay connected to the edge
    if (isLeftEdge) {
      // Left edge: menu at origin, tab to the right of menu
      positionChild('menu', Offset.zero);
      positionChild(
        'tab',
        Offset(menuWidth, size.height / 2 - tabSize.height / 2),
      );
    } else {
      // Right edge: tab at left side of container, menu to the right of tab
      positionChild('tab', Offset(0, size.height / 2 - tabSize.height / 2));
      positionChild('menu', Offset(tabWidth, 0));
    }
  }

  @override
  bool shouldRelayout(_TabMenuLayoutDelegate oldDelegate) {
    return oldDelegate.isLeftEdge != isLeftEdge ||
        oldDelegate.menuWidth != menuWidth ||
        oldDelegate.tabWidth != tabWidth;
  }
}
