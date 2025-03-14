import 'package:flutter/material.dart';
import 'package:pull_tab_menu/pull_tab_menu.dart';

import '../config_menu.dart';

class BehaviorConfig extends StatelessWidget {
  const BehaviorConfig({
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
      title: 'Behavior',
      content: _buildBehaviorControls(),
      onReset: onReset,
    );
  }

  Widget _buildBehaviorControls() {
    return Column(
      children: <Widget>[
        ConfigMenuSwitch(
          title: 'Open On Hover',
          subtitle:
              'Open the menu when the tab is hovered over with the mouse.',
          value: configuration.openOnTabHover,
          onChanged:
              (bool value) =>
                  onConfigChange(configuration.copyWith(openOnTabHover: value)),
        ),
        const Divider(),
        ConfigMenuSwitch(
          title: 'Close On Tap',
          subtitle: 'Close the menu when a menu item is tapped.',
          value: configuration.closeMenuOnTap,
          onChanged:
              (bool value) =>
                  onConfigChange(configuration.copyWith(closeMenuOnTap: value)),
        ),
        const Divider(),
        ConfigMenuSwitch(
          title: 'Auto Hide',
          subtitle: 'Automatically hide after delay',
          value: configuration.autoHide,
          onChanged:
              (bool value) =>
                  onConfigChange(configuration.copyWith(autoHide: value)),
        ),
        ConfigMenuSlider(
          title: 'Auto Hide Delay',
          subtitle: 'Ignored when auto hide is disabled.',
          value: configuration.autoHideDelay.inSeconds.toDouble(),
          min: 1,
          max: 6,
          steps: 1,
          onChanged:
              !configuration.autoHide
                  ? null
                  : (double value) => onConfigChange(
                    configuration.copyWith(
                      autoHideDelay: Duration(seconds: value.toInt()),
                    ),
                  ),
        ),
      ],
    );
  }
}
