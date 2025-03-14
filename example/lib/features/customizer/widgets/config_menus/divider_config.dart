import 'package:flutter/material.dart';
import 'package:pull_tab_menu/pull_tab_menu.dart';

import '../config_menu.dart';

class DividerConfig extends StatelessWidget {
  const DividerConfig({
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
      title: 'Divider Appearance',
      content: _buildDividerControls(),
      onReset: onReset,
    );
  }

  Widget _buildDividerControls() {
    return Column(
      children: <Widget>[
        ConfigMenuSlider(
          title: 'Thickness',
          value: configuration.dividerThickness,
          min: 0.5,
          max: 4.0,
          steps: 0.5,
          onChanged:
              (double value) => onConfigChange(
                configuration.copyWith(dividerThickness: value),
              ),
        ),
        ConfigMenuSlider(
          title: 'Indent',
          value: configuration.dividerIndent,
          min: 0,
          max: 20,
          steps: 4,
          onChanged:
              (double value) =>
                  onConfigChange(configuration.copyWith(dividerIndent: value)),
        ),
      ],
    );
  }
}
