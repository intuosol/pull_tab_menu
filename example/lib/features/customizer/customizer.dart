import 'package:flutter/material.dart';
import 'package:intuosol_design_system/intuosol_design_system.dart';
import 'package:pull_tab_menu/pull_tab_menu.dart';

import 'widgets/config_menus/animation_config.dart';
import 'widgets/config_menus/behavior_config.dart';
import 'widgets/config_menus/colors_config.dart';
import 'widgets/config_menus/divider_config.dart';
import 'widgets/config_menus/menu_alignment_config.dart';
import 'widgets/config_menus/menu_layout_config.dart';
import 'widgets/config_menus/opacity_config.dart';
import 'widgets/config_menus/tab_size_config.dart';
import 'widgets/custom_snackbar.dart';

// Example with customization
class PullTabMenuCustomizer extends StatefulWidget {
  const PullTabMenuCustomizer({super.key});

  @override
  State<PullTabMenuCustomizer> createState() => _PullTabMenuCustomizerState();
}

class _PullTabMenuCustomizerState extends State<PullTabMenuCustomizer> {
  final PullTabController _controller = PullTabController();
  PullTabMenuConfiguration _configuration = const PullTabMenuConfiguration();

  /// The default configuration for the pull tab menu
  final PullTabMenuConfiguration kDefaultConfig =
      const PullTabMenuConfiguration();

  // Customizer default values (specific to this example)
  static const MenuAlignment kDefaultInitialMenuAlignment =
      MenuAlignment.bottomLeft;
  static const Axis kDefaultAxis = Axis.vertical;
  static const Curve kDefaultShowCurve = Curves.bounceOut;
  static const Duration kDefaultShowDuration = Duration(milliseconds: 500);
  static const bool kDefaultUseBackgroundOverlay = false;

  @override
  void initState() {
    _setBaseConfig();
    Future<void>.delayed(
      Durations.short3,
      () => setState(() {
        _controller.openMenu();
      }),
    );
    super.initState();
  }

  /// Resets all settings to the base configuration
  void _setBaseConfig() {
    setState(() {
      _configuration = const PullTabMenuConfiguration(
        initialAlignment: kDefaultInitialMenuAlignment,
        axis: kDefaultAxis,
        showDuration: kDefaultShowDuration,
        showCurve: kDefaultShowCurve,
        useBackgroundOverlay: kDefaultUseBackgroundOverlay,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<PullTabMenuItem> menuItems = <PullTabMenuItem>[
      PullTabMenuItem(
        label: 'Reset All Settings',
        icon: Icons.restart_alt,
        onTap: _setBaseConfig,
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
    ];

    return IntuoSolScaffold(
      appBar: AppBar(title: const Text('Pull Tab Menu Customizer')),
      body: PullTabMenu(
        menuItems: menuItems,
        controller: _controller,
        configuration: _configuration,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                children: <Widget>[
                  IntuoSolSectionHeader(
                    title: 'Use the controls below to customize the menu.',
                    textStyle: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'The customization parameters shown here are for demonstration only. See the pull tab menu documentation for complete customization options.',
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 8),
                  MenuAlignmentConfig(
                    configuration: _configuration,
                    onConfigChange: (
                      PullTabMenuConfiguration newConfiguration,
                    ) {
                      setState(() {
                        _controller.position = Offset.zero;
                        _configuration = newConfiguration;
                      });
                    },
                    onReset:
                        () => setState(() {
                          _controller.position = Offset.zero;
                          _configuration = _configuration.copyWith(
                            initialAlignment: kDefaultInitialMenuAlignment,
                            allowRepositioning:
                                kDefaultConfig.allowRepositioning,
                          );
                        }),
                  ),
                  MenuLayoutConfig(
                    configuration: _configuration,
                    onConfigChange: (
                      PullTabMenuConfiguration newConfiguration,
                    ) {
                      setState(() {
                        _configuration = newConfiguration;
                      });
                    },
                    onReset:
                        () => setState(() {
                          _configuration = _configuration.copyWith(
                            axis: kDefaultAxis,
                            borderRadius: kDefaultConfig.borderRadius,
                            itemExtent: kDefaultConfig.itemExtent,
                            menuBreadth: kDefaultConfig.menuBreadth,
                          );
                        }),
                  ),

                  TabSizeConfig(
                    configuration: _configuration,
                    onConfigChange:
                        (PullTabMenuConfiguration newConfiguration) =>
                            setState(() => _configuration = newConfiguration),
                    onReset:
                        () => setState(() {
                          _configuration = _configuration.copyWith(
                            tabHeight: kDefaultConfig.tabHeight,
                            tabWidth: kDefaultConfig.tabWidth,
                          );
                        }),
                  ),
                  ColorsConfig(
                    configuration: _configuration,
                    onConfigChange:
                        (PullTabMenuConfiguration newConfiguration) =>
                            setState(() => _configuration = newConfiguration),
                    onReset:
                        () => setState(
                          () =>
                              _configuration = _configuration.copyWith(
                                baseColor:
                                    Theme.of(
                                      context,
                                    ).colorScheme.inverseSurface,
                                tabColor:
                                    Theme.of(
                                      context,
                                    ).colorScheme.inverseSurface,
                                foregroundColor:
                                    Theme.of(
                                      context,
                                    ).colorScheme.onInverseSurface,
                              ),
                        ),
                  ),
                  DividerConfig(
                    configuration: _configuration,
                    onConfigChange:
                        (PullTabMenuConfiguration newConfiguration) =>
                            setState(() => _configuration = newConfiguration),
                    onReset:
                        () => setState(
                          () =>
                              _configuration = _configuration.copyWith(
                                dividerThickness:
                                    kDefaultConfig.dividerThickness,
                                dividerIndent: kDefaultConfig.dividerIndent,
                              ),
                        ),
                  ),
                  OpacityConfig(
                    configuration: _configuration,
                    onConfigChange:
                        (PullTabMenuConfiguration newConfiguration) =>
                            setState(() => _configuration = newConfiguration),
                    onReset:
                        () => setState(
                          () =>
                              _configuration = _configuration.copyWith(
                                tabOpacity: kDefaultConfig.tabOpacity,
                                menuOpacity: kDefaultConfig.menuOpacity,
                                backgroundOverlayOpacity:
                                    kDefaultConfig.backgroundOverlayOpacity,
                                useBackgroundOverlay:
                                    kDefaultUseBackgroundOverlay,
                              ),
                        ),
                  ),
                  AnimationConfig(
                    configuration: _configuration,
                    onConfigChange:
                        (PullTabMenuConfiguration newConfiguration) =>
                            setState(() => _configuration = newConfiguration),
                    onReset:
                        () => setState(
                          () =>
                              _configuration = _configuration.copyWith(
                                showDuration: kDefaultShowDuration,
                                hideDuration: kDefaultConfig.hideDuration,
                                showCurve: kDefaultShowCurve,
                                hideCurve: kDefaultConfig.hideCurve,
                              ),
                        ),
                  ),
                  BehaviorConfig(
                    configuration: _configuration,
                    onConfigChange:
                        (PullTabMenuConfiguration newConfiguration) =>
                            setState(() => _configuration = newConfiguration),
                    onReset:
                        () => setState(
                          () =>
                              _configuration = _configuration.copyWith(
                                autoHide: kDefaultConfig.autoHide,
                                autoHideDelay: kDefaultConfig.autoHideDelay,
                                closeMenuOnTap: kDefaultConfig.closeMenuOnTap,
                                openOnTabHover: kDefaultConfig.openOnTabHover,
                              ),
                        ),
                  ),
                  const SizedBox(height: 275),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
