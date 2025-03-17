import 'package:flutter/material.dart';
import 'package:pull_tab_menu/pull_tab_menu.dart';

import '../config_menu.dart';

class ColorsConfig extends StatelessWidget {
  const ColorsConfig({
    super.key,
    required this.configuration,
    required this.onConfigChange,
    required this.onColorChange,
    required this.onReset,
  });

  final PullTabMenuConfiguration configuration;
  final Function(PullTabMenuConfiguration configuration) onConfigChange;
  final Function() onReset;

  // Used for source code generation
  final Function({
    required String baseColorAsString,
    required String tabColorAsString,
    required String foregroundColorAsString,
  })
  onColorChange;

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

    /// List of colors to choose from for the menu and tab
    final List<Color> backgroundColors = <Color>[
      defaultBaseColor,
      Colors.green[100]!,
      Colors.deepPurple[100]!,
      Colors.brown[100]!,
      Colors.blue[100]!,
      Colors.pink[100]!,
      Colors.cyan[100]!,
      Colors.amber[100]!,
    ];

    /// List of colors to choose from for the foreground
    final List<Color> foregroundColors = <Color>[
      defaultForegroundColor,
      Colors.green[900]!,
      Colors.deepPurple[900]!,
      Colors.brown[900]!,
      Colors.blue[900]!,
      Colors.pink[900]!,
      Colors.cyan[900]!,
      Colors.amber[900]!,
    ];

    /// The list of background color names (used for source code generation)
    List<String> colorNames(int shade) => <String>[
      'null',
      'Colors.green[$shade]',
      'Colors.deepPurple[$shade]',
      'Colors.brown[$shade]',
      'Colors.blue[$shade]',
      'Colors.pink[$shade]',
      'Colors.cyan[$shade]',
      'Colors.amber[$shade]',
    ];

    /// Name of the currently selected color
    String selectedColorName({
      required Color? color,
      bool isBackgroundColor = true,
    }) {
      int colorIndex = -1;
      if (color == null) {
        return 'null';
      }

      if (isBackgroundColor) {
        colorIndex = backgroundColors.indexOf(color);
        return colorNames(100)[colorIndex];
      } else {
        colorIndex = foregroundColors.indexOf(color);
        return colorNames(900)[colorIndex];
      }
    }

    return Column(
      children: <Widget>[
        ConfigMenuColorPicker(
          title: 'Base Color',
          subtitle: 'The base color of the menu',
          selectedColor: configuration.baseColor ?? defaultBaseColor,
          options: backgroundColors,
          onColorChanged: (Color color) {
            onColorChange(
              baseColorAsString: selectedColorName(color: color),
              tabColorAsString: selectedColorName(
                color: configuration.tabColor,
              ),
              foregroundColorAsString: selectedColorName(
                color: configuration.foregroundColor,
                isBackgroundColor: false,
              ),
            );
            onConfigChange(configuration.copyWith(baseColor: color));
          },
        ),
        ConfigMenuColorPicker(
          title: 'Tab Color',
          subtitle: 'Defaults to the base color if not set',
          selectedColor: configuration.tabColor ?? defaultBaseColor,
          options: backgroundColors,
          onColorChanged: (Color color) {
            onColorChange(
              baseColorAsString: selectedColorName(
                color: configuration.baseColor,
              ),
              tabColorAsString: selectedColorName(color: color),
              foregroundColorAsString: selectedColorName(
                color: configuration.foregroundColor,
                isBackgroundColor: false,
              ),
            );
            onConfigChange(configuration.copyWith(tabColor: color));
          },
        ),
        ConfigMenuColorPicker(
          title: 'Foreground Color',
          subtitle: 'Color of the menu items',
          selectedColor:
              configuration.foregroundColor ?? defaultForegroundColor,
          options: foregroundColors,
          onColorChanged: (Color color) {
            onColorChange(
              baseColorAsString: selectedColorName(
                color: configuration.baseColor,
              ),
              tabColorAsString: selectedColorName(
                color: configuration.tabColor,
              ),
              foregroundColorAsString: selectedColorName(
                color: color,
                isBackgroundColor: false,
              ),
            );
            onConfigChange(configuration.copyWith(foregroundColor: color));
          },
        ),
      ],
    );
  }
}
