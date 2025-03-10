import 'package:flutter/material.dart';
import 'package:pull_tab_menu/pull_tab_menu.dart';
import '../widgets/custom_snackbar.dart';

// Example with customization
class CustomizedExample extends StatefulWidget {
  const CustomizedExample({super.key});

  @override
  State<CustomizedExample> createState() => _CustomizedExampleState();
}

class _CustomizedExampleState extends State<CustomizedExample> {
  final PullTabController _controller = PullTabController();

  // Default configuration values
  static const MenuPosition kDefaultMenuPosition = MenuPosition.bottomLeft;
  static const Axis kDefaultAxis = Axis.vertical;
  static const double kDefaultTabWidth = 50.0;
  static const double kDefaultTabHeight = 100.0;
  static const double kDefaultTabOpacity = 0.7;
  static const double kDefaultMenuOpacity = 1.0;
  static const bool kDefaultAutoHide = true;
  static const Duration kDefaultAutoHideDelay = Duration(seconds: 3);
  static const Duration kDefaultAnimationDuration = Duration(milliseconds: 400);
  static const Curve kDefaultAnimationCurve = Curves.easeOutBack;
  static const double kDefaultElevation = 8.0;
  static const double kDefaultBorderRadius = 16.0;
  static const double kDefaultOverlayOpacity = 0.5;
  static const bool kDefaultUseOverlay = true;
  static const double kDefaultMaxMenuHeightFactor = 0.7;
  static const double kDefaultItemSize = 48.0;
  static const double kDefaultRailBreadth = 60.0;
  static const bool kDefaultCloseMenuOnTap = true;
  static const bool kDefaultAllowDragging = true;
  static const bool kDefaultOpenOnTabHover = true;
  static const double kDefaultDividerThickness = 0.5;
  static const double kDefaultDividerIndent = 8.0;

  // Configuration options
  MenuPosition _menuPosition = kDefaultMenuPosition;
  Axis _axis = kDefaultAxis;
  double _tabWidth = kDefaultTabWidth;
  double _tabHeight = kDefaultTabHeight;
  late Color _baseColor;
  late Color _tabColor;
  double _tabOpacity = kDefaultTabOpacity;
  double _menuOpacity = kDefaultMenuOpacity;
  late Color _foregroundColor;
  bool _autoHide = kDefaultAutoHide;
  Duration _autoHideDelay = kDefaultAutoHideDelay;
  Duration _animationDuration = kDefaultAnimationDuration;
  Curve _animationCurve = kDefaultAnimationCurve;
  double _elevation = kDefaultElevation;
  double _borderRadius = kDefaultBorderRadius;
  double _overlayOpacity = kDefaultOverlayOpacity;
  bool _useOverlay = kDefaultUseOverlay;
  double _maxMenuHeightFactor = kDefaultMaxMenuHeightFactor;
  double _itemSize = kDefaultItemSize;
  double _railBreadth = kDefaultRailBreadth;
  bool _closeMenuOnTap = kDefaultCloseMenuOnTap;
  bool _allowDragging = kDefaultAllowDragging;
  bool _openOnTabHover = kDefaultOpenOnTabHover;
  double _dividerThickness = kDefaultDividerThickness;
  double _dividerIndent = kDefaultDividerIndent;

  @override
  void initState() {
    super.initState();
    // Initialize colors that can't be const
    _baseColor = Colors.grey[900]!;
    _tabColor = Colors.orange;
    _foregroundColor = Colors.white;

    Future<void>.delayed(
      Durations.short2,
      () => setState(() {
        _controller.openMenu();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<PullTabMenuItem> menuItems = <PullTabMenuItem>[
      PullTabMenuItem(
        label: 'Reset All Settings',
        icon: Icons.restart_alt,
        onTap: _resetAllSettings,
      ),
      const PullTabMenuItem.divider(),
      PullTabMenuItem(
        label: 'Home',
        icon: Icons.home,
        onTap: () {
          CustomSnackBar.of(context).showMessage('Home tapped');
        },
      ),
      PullTabMenuItem(
        label: 'Favorites',
        icon: Icons.favorite,
        onTap: () {
          CustomSnackBar.of(context).showMessage('Favorites tapped');
        },
      ),
      PullTabMenuItem(
        label: 'Search',
        icon: Icons.search,
        onTap: () {
          CustomSnackBar.of(context).showMessage('Search tapped');
        },
      ),
      PullTabMenuItem(
        label: 'Profile',
        icon: Icons.person,
        onTap: () {
          CustomSnackBar.of(context).showMessage('Profile tapped');
        },
      ),
      PullTabMenuItem(
        label: 'Settings',
        icon: Icons.settings,
        onTap: () {
          CustomSnackBar.of(context).showMessage('Settings tapped');
        },
      ),
    ];

    return PullTabMenu(
      menuItems: menuItems,
      controller: _controller,
      configuration: PullTabMenuConfiguration(
        menuPosition: _menuPosition,
        axis: _axis,
        tabWidth: _tabWidth,
        tabHeight: _tabHeight,
        baseColor: _baseColor,
        tabColor: _tabColor,
        tabOpacity: _tabOpacity,
        menuOpacity: _menuOpacity,
        foregroundColor: _foregroundColor,
        autoHide: _autoHide,
        autoHideDelay: _autoHideDelay,
        animationDuration: _animationDuration,
        animationCurve: _animationCurve,
        elevation: _elevation,
        borderRadius: _borderRadius,
        overlayOpacity: _overlayOpacity,
        useOverlay: _useOverlay,
        maxMenuHeightFactor: _maxMenuHeightFactor,
        itemSize: _itemSize,
        railBreadth: _railBreadth,
        closeMenuOnTap: _closeMenuOnTap,
        allowDragging: _allowDragging,
        openOnTabHover: _openOnTabHover,
        dividerThickness: _dividerThickness,
        dividerIndent: _dividerIndent,
      ),
      child: Theme(
        data: ThemeData.light(useMaterial3: true),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Customizable Menu'),
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Colors.orange[100]!, Colors.orange[300]!],
              ),
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: <Widget>[
                    const Text(
                      'Use the controls below to customize the menu.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildConfigSection(
                      'Menu Position',
                      _buildPositionSelector(),
                      onReset:
                          () => setState(() {
                            _menuPosition = kDefaultMenuPosition;
                          }),
                    ),
                    _buildConfigSection(
                      'Menu Layout',
                      _buildAxisSelector(),
                      onReset:
                          () => setState(() {
                            _axis = kDefaultAxis;
                          }),
                    ),
                    _buildConfigSection(
                      'Tab Size',
                      _buildTabSizeControls(),
                      onReset:
                          () => setState(() {
                            _tabWidth = kDefaultTabWidth;
                            _tabHeight = kDefaultTabHeight;
                            _itemSize = kDefaultItemSize;
                            _railBreadth = kDefaultRailBreadth;
                          }),
                    ),
                    _buildConfigSection(
                      'Colors',
                      _buildColorControls(),
                      onReset:
                          () => setState(() {
                            _baseColor = Colors.grey[900]!;
                            _tabColor = Colors.orange;
                            _foregroundColor = Colors.white;
                          }),
                    ),
                    _buildConfigSection(
                      'Opacity',
                      _buildOpacityControls(),
                      onReset:
                          () => setState(() {
                            _tabOpacity = kDefaultTabOpacity;
                            _menuOpacity = kDefaultMenuOpacity;
                            _overlayOpacity = kDefaultOverlayOpacity;
                            _useOverlay = kDefaultUseOverlay;
                          }),
                    ),
                    _buildConfigSection(
                      'Animation',
                      _buildAnimationControls(),
                      onReset:
                          () => setState(() {
                            _animationDuration = kDefaultAnimationDuration;
                            _animationCurve = kDefaultAnimationCurve;
                          }),
                    ),
                    _buildConfigSection(
                      'Appearance',
                      _buildAppearanceControls(),
                      onReset:
                          () => setState(() {
                            _elevation = kDefaultElevation;
                            _borderRadius = kDefaultBorderRadius;
                            _maxMenuHeightFactor = kDefaultMaxMenuHeightFactor;
                          }),
                    ),
                    _buildConfigSection(
                      'Behavior',
                      _buildBehaviorControls(),
                      onReset:
                          () => setState(() {
                            _autoHide = kDefaultAutoHide;
                            _autoHideDelay = kDefaultAutoHideDelay;
                            _closeMenuOnTap = kDefaultCloseMenuOnTap;
                            _allowDragging = kDefaultAllowDragging;
                            _openOnTabHover = kDefaultOpenOnTabHover;
                          }),
                    ),
                    _buildConfigSection(
                      'Divider',
                      _buildDividerControls(),
                      onReset:
                          () => setState(() {
                            _dividerThickness = kDefaultDividerThickness;
                            _dividerIndent = kDefaultDividerIndent;
                          }),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConfigSection(
    String title,
    Widget content, {
    VoidCallback? onReset,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.white.withValues(alpha: 0.9),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                if (onReset != null)
                  IconButton(
                    icon: const Icon(Icons.restart_alt, size: 20),
                    tooltip: 'Reset to default',
                    onPressed: onReset,
                  ),
              ],
            ),
            const Divider(),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildPositionSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: <Widget>[
        _buildPositionChip(MenuPosition.topLeft, 'Top Left'),
        _buildPositionChip(MenuPosition.centerLeft, 'Center Left'),
        _buildPositionChip(MenuPosition.bottomLeft, 'Bottom Left'),
        _buildPositionChip(MenuPosition.topRight, 'Top Right'),
        _buildPositionChip(MenuPosition.centerRight, 'Center Right'),
        _buildPositionChip(MenuPosition.bottomRight, 'Bottom Right'),
      ],
    );
  }

  Widget _buildPositionChip(MenuPosition position, String label) {
    return FilterChip(
      selected: _menuPosition == position,
      label: Text(label),
      onSelected: (bool selected) {
        if (selected) {
          setState(() {
            _menuPosition = position;
          });
        }
      },
      selectedColor: Colors.orange[200],
    );
  }

  Widget _buildAxisSelector() {
    return Row(
      children: <Widget>[
        Expanded(
          child: RadioListTile<Axis>(
            title: const Text('Vertical'),
            value: Axis.vertical,
            groupValue: _axis,
            onChanged: (Axis? value) {
              setState(() {
                _axis = value!;
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile<Axis>(
            title: const Text('Horizontal'),
            value: Axis.horizontal,
            groupValue: _axis,
            onChanged: (Axis? value) {
              setState(() {
                _axis = value!;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTabSizeControls() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            const SizedBox(width: 100, child: Text('Tab Width:')),
            Expanded(
              child: Slider(
                value: _tabWidth,
                min: 30,
                max: 100,
                divisions: 14,
                label: _tabWidth.toStringAsFixed(1),
                onChanged: (double value) {
                  setState(() {
                    _tabWidth = value;
                  });
                },
              ),
            ),
            SizedBox(width: 50, child: Text('${_tabWidth.toInt()}px')),
          ],
        ),
        Row(
          children: <Widget>[
            const SizedBox(width: 100, child: Text('Tab Height:')),
            Expanded(
              child: Slider(
                value: _tabHeight,
                min: 40,
                max: 200,
                divisions: 16,
                label: _tabHeight.toStringAsFixed(1),
                onChanged: (double value) {
                  setState(() {
                    _tabHeight = value;
                  });
                },
              ),
            ),
            SizedBox(width: 50, child: Text('${_tabHeight.toInt()}px')),
          ],
        ),
        Row(
          children: <Widget>[
            const SizedBox(width: 100, child: Text('Item Size:')),
            Expanded(
              child: Slider(
                value: _itemSize,
                min: 32,
                max: 80,
                divisions: 12,
                label: _itemSize.toStringAsFixed(1),
                onChanged: (double value) {
                  setState(() {
                    _itemSize = value;
                  });
                },
              ),
            ),
            SizedBox(width: 50, child: Text('${_itemSize.toInt()}px')),
          ],
        ),
        Row(
          children: <Widget>[
            const SizedBox(width: 100, child: Text('Rail Breadth:')),
            Expanded(
              child: Slider(
                value: _railBreadth,
                min: 40,
                max: 120,
                divisions: 16,
                label: _railBreadth.toStringAsFixed(1),
                onChanged: (double value) {
                  setState(() {
                    _railBreadth = value;
                  });
                },
              ),
            ),
            SizedBox(width: 50, child: Text('${_railBreadth.toInt()}px')),
          ],
        ),
      ],
    );
  }

  Widget _buildColorControls() {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Base Color'),
          subtitle: const Text('Menu background color'),
          trailing: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: _baseColor,
              border: Border.all(),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onTap: () async {
            // Simple color picker
            final List<Color> colors = <Color>[
              Colors.grey[900]!,
              Colors.black,
              Colors.blue[900]!,
              Colors.indigo[900]!,
              Colors.purple[900]!,
              Colors.red[900]!,
              Colors.green[900]!,
            ];

            await showDialog(
              context: context,
              builder:
                  (BuildContext context) => AlertDialog(
                    title: const Text('Select Base Color'),
                    content: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children:
                          colors.map((Color color) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _baseColor = color;
                                });
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: color,
                                  border: Border.all(
                                    color:
                                        _baseColor == color
                                            ? Colors.white
                                            : Colors.black,
                                    width: _baseColor == color ? 2 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
            );
          },
        ),
        ListTile(
          title: const Text('Tab Color'),
          subtitle: const Text('Pull tab color'),
          trailing: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: _tabColor,
              border: Border.all(),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onTap: () async {
            // Simple color picker
            final List<MaterialColor> colors = <MaterialColor>[
              Colors.orange,
              Colors.blue,
              Colors.green,
              Colors.red,
              Colors.purple,
              Colors.teal,
              Colors.amber,
            ];

            await showDialog(
              context: context,
              builder:
                  (BuildContext context) => AlertDialog(
                    title: const Text('Select Tab Color'),
                    content: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children:
                          colors.map((MaterialColor color) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _tabColor = color;
                                });
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: color,
                                  border: Border.all(
                                    color:
                                        _tabColor == color
                                            ? Colors.black
                                            : Colors.grey,
                                    width: _tabColor == color ? 2 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
            );
          },
        ),
        ListTile(
          title: const Text('Foreground Color'),
          subtitle: const Text('Text and icon color'),
          trailing: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: _foregroundColor,
              border: Border.all(),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onTap: () async {
            // Simple color picker
            final List<Color> colors = <Color>[
              Colors.white,
              Colors.black,
              Colors.grey[300]!,
              Colors.yellow[100]!,
              Colors.blue[100]!,
              Colors.orange[100]!,
            ];

            await showDialog(
              context: context,
              builder:
                  (BuildContext context) => AlertDialog(
                    title: const Text('Select Foreground Color'),
                    content: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children:
                          colors.map((Color color) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _foregroundColor = color;
                                });
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: color,
                                  border: Border.all(
                                    color:
                                        _foregroundColor == color
                                            ? Colors.blue
                                            : Colors.grey,
                                    width: _foregroundColor == color ? 2 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildOpacityControls() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            const SizedBox(width: 100, child: Text('Tab Opacity:')),
            Expanded(
              child: Slider(
                value: _tabOpacity,
                min: 0.2,
                divisions: 8,
                label: _tabOpacity.toStringAsFixed(1),
                onChanged: (double value) {
                  setState(() {
                    _tabOpacity = value;
                  });
                },
              ),
            ),
            SizedBox(width: 50, child: Text(_tabOpacity.toStringAsFixed(1))),
          ],
        ),
        Row(
          children: <Widget>[
            const SizedBox(width: 100, child: Text('Menu Opacity:')),
            Expanded(
              child: Slider(
                value: _menuOpacity,
                min: 0.2,
                divisions: 8,
                label: _menuOpacity.toStringAsFixed(1),
                onChanged: (double value) {
                  setState(() {
                    _menuOpacity = value;
                  });
                },
              ),
            ),
            SizedBox(width: 50, child: Text(_menuOpacity.toStringAsFixed(1))),
          ],
        ),
        Row(
          children: <Widget>[
            const SizedBox(width: 100, child: Text('Overlay Opacity:')),
            Expanded(
              child: Slider(
                value: _overlayOpacity,
                max: 0.9,
                divisions: 9,
                label: _overlayOpacity.toStringAsFixed(1),
                onChanged: (double value) {
                  setState(() {
                    _overlayOpacity = value;
                  });
                },
              ),
            ),
            SizedBox(
              width: 50,
              child: Text(_overlayOpacity.toStringAsFixed(1)),
            ),
          ],
        ),
        SwitchListTile(
          title: const Text('Use Overlay'),
          value: _useOverlay,
          onChanged: (bool value) {
            setState(() {
              _useOverlay = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildAnimationControls() {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Animation Duration'),
          subtitle: Text('${_animationDuration.inMilliseconds} ms'),
          trailing: DropdownButton<Duration>(
            value: _animationDuration,
            onChanged: (Duration? value) {
              setState(() {
                _animationDuration = value!;
              });
            },
            items: const <DropdownMenuItem<Duration>>[
              DropdownMenuItem<Duration>(
                value: Duration(milliseconds: 100),
                child: Text('100ms'),
              ),
              DropdownMenuItem<Duration>(
                value: Duration(milliseconds: 200),
                child: Text('200ms'),
              ),
              DropdownMenuItem<Duration>(
                value: Duration(milliseconds: 300),
                child: Text('300ms'),
              ),
              DropdownMenuItem<Duration>(
                value: Duration(milliseconds: 400),
                child: Text('400ms'),
              ),
              DropdownMenuItem<Duration>(
                value: Duration(milliseconds: 500),
                child: Text('500ms'),
              ),
              DropdownMenuItem<Duration>(
                value: Duration(milliseconds: 750),
                child: Text('750ms'),
              ),
              DropdownMenuItem<Duration>(
                value: Duration(milliseconds: 1000),
                child: Text('1000ms'),
              ),
            ],
          ),
        ),
        ListTile(
          title: const Text('Animation Curve'),
          subtitle: Text(_getCurveName(_animationCurve)),
          trailing: DropdownButton<Curve>(
            value: _animationCurve,
            onChanged: (Curve? value) {
              setState(() {
                _animationCurve = value!;
              });
            },
            items: const <DropdownMenuItem<Curve>>[
              DropdownMenuItem<Curve>(
                value: Curves.linear,
                child: Text('Linear'),
              ),
              DropdownMenuItem<Curve>(
                value: Curves.easeIn,
                child: Text('Ease In'),
              ),
              DropdownMenuItem<Curve>(
                value: Curves.easeOut,
                child: Text('Ease Out'),
              ),
              DropdownMenuItem<Curve>(
                value: Curves.easeInOut,
                child: Text('Ease In Out'),
              ),
              DropdownMenuItem<Curve>(
                value: Curves.elasticIn,
                child: Text('Elastic In'),
              ),
              DropdownMenuItem<Curve>(
                value: Curves.elasticOut,
                child: Text('Elastic Out'),
              ),
              DropdownMenuItem<Curve>(
                value: Curves.bounceIn,
                child: Text('Bounce In'),
              ),
              DropdownMenuItem<Curve>(
                value: Curves.bounceOut,
                child: Text('Bounce Out'),
              ),
              DropdownMenuItem<Curve>(
                value: Curves.easeOutBack,
                child: Text('Ease Out Back'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getCurveName(Curve curve) {
    if (curve == Curves.linear) {
      return 'Linear';
    }
    if (curve == Curves.easeIn) {
      return 'Ease In';
    }
    if (curve == Curves.easeOut) {
      return 'Ease Out';
    }
    if (curve == Curves.easeInOut) {
      return 'Ease In Out';
    }
    if (curve == Curves.elasticIn) {
      return 'Elastic In';
    }
    if (curve == Curves.elasticOut) {
      return 'Elastic Out';
    }
    if (curve == Curves.bounceIn) {
      return 'Bounce In';
    }
    if (curve == Curves.bounceOut) {
      return 'Bounce Out';
    }
    if (curve == Curves.easeOutBack) {
      return 'Ease Out Back';
    }
    return 'Custom';
  }

  void _resetAllSettings() {
    setState(() {
      _menuPosition = kDefaultMenuPosition;
      _axis = kDefaultAxis;
      _tabWidth = kDefaultTabWidth;
      _tabHeight = kDefaultTabHeight;
      _baseColor = Colors.grey[900]!;
      _tabColor = Colors.orange;
      _tabOpacity = kDefaultTabOpacity;
      _menuOpacity = kDefaultMenuOpacity;
      _foregroundColor = Colors.white;
      _autoHide = kDefaultAutoHide;
      _autoHideDelay = kDefaultAutoHideDelay;
      _animationDuration = kDefaultAnimationDuration;
      _animationCurve = kDefaultAnimationCurve;
      _elevation = kDefaultElevation;
      _borderRadius = kDefaultBorderRadius;
      _overlayOpacity = kDefaultOverlayOpacity;
      _useOverlay = kDefaultUseOverlay;
      _maxMenuHeightFactor = kDefaultMaxMenuHeightFactor;
      _itemSize = kDefaultItemSize;
      _railBreadth = kDefaultRailBreadth;
      _closeMenuOnTap = kDefaultCloseMenuOnTap;
      _allowDragging = kDefaultAllowDragging;
      _openOnTabHover = kDefaultOpenOnTabHover;
      _dividerThickness = kDefaultDividerThickness;
      _dividerIndent = kDefaultDividerIndent;

      // Configuration will be updated through the build method

      // Reopen the menu
      _controller.openMenu();
    });
  }

  Widget _buildAppearanceControls() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            const SizedBox(width: 100, child: Text('Elevation:')),
            Expanded(
              child: Slider(
                value: _elevation,
                max: 24,
                divisions: 12,
                label: _elevation.toStringAsFixed(1),
                onChanged: (double value) {
                  setState(() {
                    _elevation = value;
                  });
                },
              ),
            ),
            SizedBox(width: 50, child: Text('${_elevation.toInt()}dp')),
          ],
        ),
        Row(
          children: <Widget>[
            const SizedBox(width: 100, child: Text('Border Radius:')),
            Expanded(
              child: Slider(
                value: _borderRadius,
                max: 32,
                divisions: 16,
                label: _borderRadius.toStringAsFixed(1),
                onChanged: (double value) {
                  setState(() {
                    _borderRadius = value;
                  });
                },
              ),
            ),
            SizedBox(width: 50, child: Text('${_borderRadius.toInt()}px')),
          ],
        ),
        Row(
          children: <Widget>[
            const SizedBox(width: 100, child: Text('Max Height:')),
            Expanded(
              child: Slider(
                value: _maxMenuHeightFactor,
                min: 0.3,
                max: 0.9,
                divisions: 6,
                label: '${(_maxMenuHeightFactor * 100).toInt()}%',
                onChanged: (double value) {
                  setState(() {
                    _maxMenuHeightFactor = value;
                  });
                },
              ),
            ),
            SizedBox(
              width: 50,
              child: Text('${(_maxMenuHeightFactor * 100).toInt()}%'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBehaviorControls() {
    return Column(
      children: <Widget>[
        SwitchListTile(
          title: const Text('Auto Hide'),
          subtitle: const Text('Automatically hide after delay'),
          value: _autoHide,
          onChanged: (bool value) {
            setState(() {
              _autoHide = value;
            });
          },
        ),
        ListTile(
          title: const Text('Auto Hide Delay'),
          subtitle: Text('${_autoHideDelay.inSeconds} seconds'),
          enabled: _autoHide,
          trailing: DropdownButton<Duration>(
            value: _autoHideDelay,
            onChanged:
                _autoHide
                    ? (Duration? value) {
                      setState(() {
                        _autoHideDelay = value!;
                      });
                    }
                    : null,
            items: const <DropdownMenuItem<Duration>>[
              DropdownMenuItem<Duration>(
                value: Duration(seconds: 1),
                child: Text('1s'),
              ),
              DropdownMenuItem<Duration>(
                value: Duration(seconds: 2),
                child: Text('2s'),
              ),
              DropdownMenuItem<Duration>(
                value: Duration(seconds: 3),
                child: Text('3s'),
              ),
              DropdownMenuItem<Duration>(
                value: Duration(seconds: 5),
                child: Text('5s'),
              ),
              DropdownMenuItem<Duration>(
                value: Duration(seconds: 10),
                child: Text('10s'),
              ),
            ],
          ),
        ),
        SwitchListTile(
          title: const Text('Close On Tap'),
          subtitle: const Text('Close menu after item tap'),
          value: _closeMenuOnTap,
          onChanged: (bool value) {
            setState(() {
              _closeMenuOnTap = value;
            });
          },
        ),
        SwitchListTile(
          title: const Text('Allow Dragging'),
          subtitle: const Text('Enable drag to open'),
          value: _allowDragging,
          onChanged: (bool value) {
            setState(() {
              _allowDragging = value;
            });
          },
        ),
        SwitchListTile(
          title: const Text('Open On Hover'),
          subtitle: const Text('Open menu when hovering over tab'),
          value: _openOnTabHover,
          onChanged: (bool value) {
            setState(() {
              _openOnTabHover = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDividerControls() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            const SizedBox(width: 100, child: Text('Thickness:')),
            Expanded(
              child: Slider(
                value: _dividerThickness,
                min: 0.5,
                max: 5.0,
                divisions: 9,
                label: _dividerThickness.toStringAsFixed(1),
                onChanged: (double value) {
                  setState(() {
                    _dividerThickness = value;
                  });
                },
              ),
            ),
            SizedBox(
              width: 50,
              child: Text('${_dividerThickness.toStringAsFixed(1)}px'),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            const SizedBox(width: 100, child: Text('Indent:')),
            Expanded(
              child: Slider(
                value: _dividerIndent,
                max: 32,
                divisions: 8,
                label: _dividerIndent.toStringAsFixed(1),
                onChanged: (double value) {
                  setState(() {
                    _dividerIndent = value;
                  });
                },
              ),
            ),
            SizedBox(width: 50, child: Text('${_dividerIndent.toInt()}px')),
          ],
        ),
      ],
    );
  }
}
