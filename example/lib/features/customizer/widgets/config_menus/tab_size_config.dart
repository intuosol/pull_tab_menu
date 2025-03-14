import 'package:flutter/material.dart';
import 'package:pull_tab_menu/pull_tab_menu.dart';

import '../config_menu.dart';

class TabSizeConfig extends StatelessWidget {
  const TabSizeConfig({
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
      title: 'Tab Size',
      content: _buildTabSizeControls(),
      onReset: onReset,
    );
  }

  Widget _buildTabSizeControls() {
    return Column(
      children: <Widget>[
        ConfigMenuSlider(
          title: 'Tab Width',
          value: configuration.tabWidth,
          min: 30,
          max: 60,
          steps: 5,
          onChanged:
              (double value) =>
                  onConfigChange(configuration.copyWith(tabWidth: value)),
        ),
        ConfigMenuSlider(
          title: 'Tab Height',
          value: configuration.tabHeight,
          min: 60,
          max: 120,
          steps: 5,
          subtitle:
              'Ignored when the axis is horizontal. Defaults to the menu breadth.',
          onChanged:
              configuration.axis == Axis.horizontal
                  ? null
                  : (double value) =>
                      onConfigChange(configuration.copyWith(tabHeight: value)),
        ),
      ],
    );
  }
}
