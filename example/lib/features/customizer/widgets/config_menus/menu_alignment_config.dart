import 'package:flutter/material.dart';
import 'package:pull_tab_menu/pull_tab_menu.dart';

import '../config_menu.dart';

class MenuAlignmentConfig extends StatelessWidget {
  const MenuAlignmentConfig({
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
      title: 'Menu Alignment',
      content: _buildAlignmentSelector(context),
      onReset: onReset,
    );
  }

  Widget _buildAlignmentSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Initial Alignment',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: <Widget>[
                    _buildAlignmentChip(MenuAlignment.topLeft, 'Top Left'),
                    _buildAlignmentChip(
                      MenuAlignment.centerLeft,
                      'Center Left',
                    ),
                    _buildAlignmentChip(
                      MenuAlignment.bottomLeft,
                      'Bottom Left',
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 12,
                  children: <Widget>[
                    _buildAlignmentChip(MenuAlignment.topRight, 'Top Right'),
                    _buildAlignmentChip(
                      MenuAlignment.centerRight,
                      'Center Right',
                    ),
                    _buildAlignmentChip(
                      MenuAlignment.bottomRight,
                      'Bottom Right',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        ConfigMenuSwitch(
          title: 'Allow Repositioning',
          subtitle: 'Reposition by dragging the tab.',
          value: configuration.allowRepositioning,
          onChanged:
              (bool value) => onConfigChange(
                configuration.copyWith(allowRepositioning: value),
              ),
        ),
      ],
    );
  }

  Widget _buildAlignmentChip(MenuAlignment alignment, String label) {
    return FilterChip(
      selected: configuration.initialAlignment == alignment,
      label: Text(label),
      showCheckmark: false,
      onSelected:
          (bool selected) => onConfigChange(
            configuration.copyWith(
              initialAlignment: selected ? alignment : null,
            ),
          ),
    );
  }
}
