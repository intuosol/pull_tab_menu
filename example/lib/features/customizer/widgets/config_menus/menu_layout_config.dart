import 'package:flutter/material.dart';
import 'package:pull_tab_menu/pull_tab_menu.dart';

import '../config_menu.dart';

class MenuLayoutConfig extends StatelessWidget {
  const MenuLayoutConfig({
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
      title: 'Menu Layout',
      content: Column(
        children: <Widget>[
          _buildAxisSelector(),
          const Divider(),
          _buildAppearanceControl(),
        ],
      ),
      onReset: onReset,
    );
  }

  Widget _buildAxisSelector() {
    return Row(
      children: <Widget>[
        Expanded(
          child: RadioListTile<Axis>(
            contentPadding: EdgeInsets.zero,
            title: const Text('Vertical'),
            value: Axis.vertical,
            groupValue: configuration.axis,
            onChanged:
                (Axis? value) =>
                    onConfigChange(configuration.copyWith(axis: value)),
          ),
        ),
        Expanded(
          child: RadioListTile<Axis>(
            contentPadding: EdgeInsets.zero,
            title: const Text('Horizontal'),
            value: Axis.horizontal,
            groupValue: configuration.axis,
            onChanged:
                (Axis? value) =>
                    onConfigChange(configuration.copyWith(axis: value)),
          ),
        ),
      ],
    );
  }

  Widget _buildAppearanceControl() {
    return Column(
      children: <Widget>[
        ConfigMenuSlider(
          title: 'Border Radius',
          value: configuration.borderRadius,
          min: 0,
          max: 32,
          onChanged:
              (double value) =>
                  onConfigChange(configuration.copyWith(borderRadius: value)),
        ),
        ConfigMenuSlider(
          title: 'Item Extent',
          value: configuration.itemExtent,
          min: 35,
          max: 80,
          steps: 5,
          onChanged:
              (double value) =>
                  onConfigChange(configuration.copyWith(itemExtent: value)),
        ),
        ConfigMenuSlider(
          title: 'Menu Breadth',
          value: configuration.menuBreadth,
          min: 40,
          max: 90,
          steps: 10,
          onChanged:
              (double value) =>
                  onConfigChange(configuration.copyWith(menuBreadth: value)),
        ),
        const Divider(),
      ],
    );
  }
}
