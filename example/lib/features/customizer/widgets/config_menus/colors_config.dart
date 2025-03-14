import 'package:flutter/material.dart';
import 'package:pull_tab_menu/pull_tab_menu.dart';

import '../config_menu.dart';

class ColorsConfig extends StatelessWidget {
  const ColorsConfig({
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
      title: 'Colors',
      content: _buildColorControls(context),
      onReset: onReset,
    );
  }

  Widget _buildColorControls(BuildContext context) {
    final Color defaultBaseColor = Theme.of(context).colorScheme.inverseSurface;
    final Color defaultForegroundColor =
        Theme.of(context).colorScheme.onInverseSurface;

    final List<Color> menuColors = <Color>[
      defaultBaseColor,
      Colors.green[100]!,
      Colors.deepPurple[100]!,
      Colors.brown[100]!,
      Colors.blue[100]!,
      Colors.pink[100]!,
      Colors.cyan[100]!,
      Colors.amber[100]!,
    ];
    return Column(
      children: <Widget>[
        ConfigMenuColorPicker(
          title: 'Base Color',
          subtitle: 'The base color of the menu',
          selectedColor: configuration.baseColor ?? defaultBaseColor,
          options: menuColors,
          onColorChanged:
              (Color color) =>
                  onConfigChange(configuration.copyWith(baseColor: color)),
        ),
        ConfigMenuColorPicker(
          title: 'Tab Color',
          subtitle: 'Defaults to the base color if not set',
          selectedColor: configuration.tabColor ?? defaultBaseColor,
          options: menuColors,
          onColorChanged:
              (Color color) =>
                  onConfigChange(configuration.copyWith(tabColor: color)),
        ),
        ConfigMenuColorPicker(
          title: 'Foreground Color',
          subtitle: 'Color of the menu items',
          selectedColor:
              configuration.foregroundColor ?? defaultForegroundColor,
          options: <Color>[
            defaultForegroundColor,
            Colors.green[900]!,
            Colors.deepPurple[900]!,
            Colors.brown[900]!,
            Colors.blue[900]!,
            Colors.pink[900]!,
            Colors.cyan[900]!,
            Colors.amber[900]!,
          ],
          onColorChanged:
              (Color color) => onConfigChange(
                configuration.copyWith(foregroundColor: color),
              ),
        ),
      ],
    );
  }
}
