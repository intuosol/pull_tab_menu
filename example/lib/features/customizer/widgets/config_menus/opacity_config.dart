import 'package:flutter/material.dart';
import 'package:pull_tab_menu/pull_tab_menu.dart';

import '../config_menu.dart';

class OpacityConfig extends StatelessWidget {
  const OpacityConfig({
    super.key,
    required this.configuration,
    required this.onConfigChange,
    required this.onReset,
  });

  final PullTabMenuConfiguration configuration;
  final Function(PullTabMenuConfiguration configuration) onConfigChange;
  final Function() onReset;

  @override
  Widget build(BuildContext context) {
    return ConfigMenu(
      title: 'Opacity',
      content: _buildOpacityControls(context),
      onReset: onReset,
    );
  }

  Widget _buildOpacityControls(BuildContext context) {
    return Column(
      children: <Widget>[
        ConfigMenuSlider(
          title: 'Tab Opacity',
          subtitle: 'Matches the menu opacity, when opened.',
          value: configuration.tabOpacity,
          min: 0.2,
          max: 1.0,
          steps: 0.1,
          onChanged:
              (double value) =>
                  onConfigChange(configuration.copyWith(tabOpacity: value)),
        ),
        ConfigMenuSlider(
          title: 'Menu Opacity',
          value: configuration.menuOpacity,
          min: 0.2,
          max: 1.0,
          steps: 0.1,
          onChanged:
              (double value) =>
                  onConfigChange(configuration.copyWith(menuOpacity: value)),
        ),
        const Divider(),
        ConfigMenuSwitch(
          title: 'Background Overlay',
          subtitle:
              'Show a background overlay and prevent interactions behind the menu.',
          value: configuration.useBackgroundOverlay,
          onChanged:
              (bool value) => onConfigChange(
                configuration.copyWith(useBackgroundOverlay: value),
              ),
        ),
        ConfigMenuSlider(
          title: 'Overlay Opacity',
          value: configuration.backgroundOverlayOpacity,
          min: 0.1,
          max: 0.8,
          steps: 0.1,
          onChanged:
              configuration.useBackgroundOverlay
                  ? (double value) => onConfigChange(
                    configuration.copyWith(backgroundOverlayOpacity: value),
                  )
                  : null,
        ),
      ],
    );
  }
}
