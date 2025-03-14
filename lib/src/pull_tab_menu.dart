import 'dart:async';

import 'package:flutter/material.dart';

import '../pull_tab_menu.dart';
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
  late PullTabMenuConfiguration _configuration;

  Timer? _autoHideTimer;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _overlayAnimation;

  late bool _isLeftEdge;
  late double _menuWidth;
  late double _tabWidth;
  late double _menuTop;
  late double _totalWidth;
  late double _calculatedMenuLength;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? PullTabController();
    _controller.menuItems = widget.menuItems;
    _configuration = widget.configuration;

    _assignAxis();

    _animationController = AnimationController(
      vsync: this,
      duration: _configuration.showDuration,
      reverseDuration: _configuration.hideDuration,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: _configuration.showCurve,
      reverseCurve: _configuration.hideCurve,
    );

    _overlayAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease,
    );

    _controller.addListener(_onControllerUpdate);
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
      _assignAxis();

      // Update animation controller with new duration and curve
      _animationController.duration = _configuration.showDuration;
      _animationController.reverseDuration = _configuration.hideDuration;
      _animation = CurvedAnimation(
        parent: _animationController,
        curve: _configuration.showCurve,
        reverseCurve: _configuration.hideCurve,
      );
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
    if (!_configuration.allowRepositioning) {
      return;
    }
    _controller.isDragging = true;
  }

  void _onTabDragUpdate(DragUpdateDetails details) {
    if (!_configuration.allowRepositioning) {
      return;
    }

    setState(() {
      _controller.position = Offset(
        _controller.position.dx + details.delta.dx,
        _controller.position.dy + details.delta.dy,
      );
    });
  }

  void _onTabDragEnd() {
    if (!_configuration.allowRepositioning) {
      return;
    }
    _controller.isDragging = false;
  }

  void _assignAxis() {
    final bool forceHorizontal = widget.menuItems.length == 1;
    final bool shouldUseHorizontal = widget.menuItems.length < 4;
    final bool isAxisExplicitlySet = widget.configuration.axis != null;

    if (forceHorizontal || (shouldUseHorizontal && !isAxisExplicitlySet)) {
      _configuration = widget.configuration.copyWith(axis: Axis.horizontal);
    } else {
      _configuration = widget.configuration;
    }
  }

  void _positionMenu(Size availableSpace) {
    _tabWidth = _configuration.tabWidth;
    final bool isVertical = _configuration.axis == Axis.vertical;

    // Determine edge that the tab is attached to
    // Use controller position if it's been set, otherwise use the initial alignment
    _isLeftEdge =
        _controller.position != Offset.zero
            ? _controller.isMenuOnLeftEdge(availableSpace.width)
            : (<MenuAlignment>[
              MenuAlignment.topLeft,
              MenuAlignment.centerLeft,
              MenuAlignment.bottomLeft,
            ].contains(_configuration.initialAlignment));

    // Apply vertical padding from configuration
    final double availableHeight =
        availableSpace.height - _configuration.margin * 2;

    if (isVertical) {
      // Calculate width based on items
      _menuWidth = _configuration.menuBreadth;
      _totalWidth = _menuWidth + _tabWidth;

      // Calculate height based on items, accounting for dividers
      double totalHeight = 0;
      for (final PullTabMenuItem item in _controller.menuItems) {
        if (item.isDivider) {
          totalHeight += _configuration.dividerIndent; // Divider height
        } else {
          totalHeight += _configuration.itemExtent; // Regular item height
        }
      }
      _calculatedMenuLength = totalHeight + 8; // Add padding

      // Constrain to min/max size
      _calculatedMenuLength = _calculatedMenuLength.clamp(
        _configuration.itemExtent,
        availableHeight,
      );
    } else {
      // Calculate height based on items
      _calculatedMenuLength = _configuration.menuBreadth;

      // Calculate width based on items
      double totalItemWidth = 0;
      for (final PullTabMenuItem item in _controller.menuItems) {
        if (item.isDivider) {
          totalItemWidth += _configuration.dividerIndent; // Divider width
        } else {
          totalItemWidth += _configuration.itemExtent; // Regular item width
        }
      }
      _menuWidth = totalItemWidth + 8; // Add padding
      _totalWidth = _menuWidth + _tabWidth;

      // Constrain the total to min/max size
      _totalWidth = _totalWidth.clamp(
        _configuration.itemExtent,
        availableSpace.width - _configuration.margin,
      );

      // Recalculate the menu width
      _menuWidth = _totalWidth - _tabWidth;
    }

    // Calculate the position of the menu
    final Offset initialPosition =
        _controller.position == Offset.zero
            ? PositionUtils.calculateTabPosition(
              alignment: _configuration.initialAlignment,
              screenSize: availableSpace,
              menuLength: _calculatedMenuLength,
              totalWidth: _totalWidth,
            )
            : _controller.position;

    _controller.position = initialPosition;

    _menuTop = initialPosition.dy - _calculatedMenuLength / 2;
    // Ensure the menu doesn't go off-screen vertically and respect vertical padding
    if (isVertical) {
      _menuTop = _menuTop.clamp(
        _configuration.margin,
        availableSpace.height - _calculatedMenuLength - _configuration.margin,
      );
    } else {
      _menuTop = _menuTop.clamp(
        _configuration.margin,
        availableSpace.height -
            _configuration.menuBreadth -
            _configuration.margin,
      );
    }
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

        _positionMenu(availableSpace);

        return Stack(
          children: <Widget>[
            widget.child,
            if (_controller.isMenuOpen && _configuration.useBackgroundOverlay)
              AnimatedBuilder(
                animation: _overlayAnimation,
                builder: (BuildContext context, Widget? child) {
                  return Positioned.fill(
                    child: GestureDetector(
                      onTap: _controller.closeMenu,
                      child: Container(
                        color: Colors.black.withValues(
                          alpha:
                              _configuration.backgroundOverlayOpacity *
                              _overlayAnimation.value,
                        ),
                      ),
                    ),
                  );
                },
              ),

            // Combined menu and tab that slides together
            Positioned(
              left: _isLeftEdge ? 0 : null,
              right: _isLeftEdge ? null : 0,
              top: _menuTop,
              child: Hero(
                tag: 'pull-tab-menu',
                child: MouseRegion(
                  onHover: _onHover,
                  hitTestBehavior: HitTestBehavior.translucent,
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (BuildContext context, Widget? child) {
                      // Calculate how much the menu should slide
                      final double offsetX =
                          _isLeftEdge
                              ? _menuWidth *
                                  (_animation.value -
                                      1) // Slide right when opening
                              : -_menuWidth *
                                  (_animation.value -
                                      1); // Slide left when opening

                      return Transform.translate(
                        offset: Offset(offsetX, 0),
                        child: SizedBox(
                          width: _totalWidth,
                          height: _calculatedMenuLength,
                          child: CustomMultiChildLayout(
                            delegate: _TabMenuLayoutDelegate(
                              isLeftEdge: _isLeftEdge,
                              menuWidth: _menuWidth,
                              tabWidth: _tabWidth,
                            ),
                            children: <Widget>[
                              if (_configuration.axis == Axis.horizontal)
                                LayoutId(
                                  id: 'menu',
                                  child: _buildMenu(
                                    menuPositionIsLeft: _isLeftEdge,
                                    menuHeight: _calculatedMenuLength,
                                    menuWidth: _menuWidth,
                                  ),
                                ),
                              LayoutId(
                                id: 'tab',
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  onHover: _onTabHover,
                                  child: PullTab(
                                    isLeftEdge: _isLeftEdge,
                                    configuration: _configuration,
                                    controller: _controller,
                                    onTap: _onTabTap,
                                    onDragStart: _onTabDragStart,
                                    onDragUpdate: _onTabDragUpdate,
                                    onDragEnd: _onTabDragEnd,
                                  ),
                                ),
                              ),
                              if (_configuration.axis == Axis.vertical)
                                LayoutId(
                                  id: 'menu',
                                  child: _buildMenu(
                                    menuPositionIsLeft: _isLeftEdge,
                                    menuHeight: _calculatedMenuLength,
                                    menuWidth: _menuWidth,
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

  /// Builds the menu widget
  Widget _buildMenu({
    required bool menuPositionIsLeft,
    required double menuHeight,
    required double menuWidth,
  }) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: _configuration.menuBreadth,
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
        child: _buildMenuItemListView(),
      ),
    );
  }

  /// Builds the list storing the menu items
  Widget _buildMenuItemListView() {
    // Get the menu items from the controller
    final List<PullTabMenuItem> itemsToDisplay = _controller.menuItems;

    return Center(
      child: ListView.builder(
        scrollDirection: _configuration.axis ?? Axis.vertical,
        itemCount: itemsToDisplay.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final PullTabMenuItem item = itemsToDisplay[index];
          return _buildMenuItem(item: item);
        },
      ),
    );
  }

  /// Builds the divider or regular menu item
  Widget _buildMenuItem({required PullTabMenuItem item}) {
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
              ? _configuration.itemExtent * 0.6
              : _configuration.itemExtent * 0.25,
      margin:
          _configuration.axis == Axis.vertical
              ? EdgeInsets.symmetric(horizontal: _configuration.itemExtent)
              : null,
      exitDuration: Duration.zero,
      child: SizedBox(
        height: _configuration.itemExtent,
        width: _configuration.itemExtent,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: IconButton(
            icon: _buildIconWithIndicator(menuItem),
            onPressed: () async {
              if (_configuration.closeMenuOnTap) {
                _controller.closeMenu();
                await Future<void>.delayed(_configuration.hideDuration * 0.5);
              }
              menuItem.onTap?.call();
            },
          ),
        ),
      ),
    );
  }

  /// Builds the icon with the selection indicator
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
