import 'package:flutter/material.dart';
import 'package:pull_tab_menu/pull_tab_menu.dart';

import '../config_menu.dart';

class AnimationConfig extends StatelessWidget {
  const AnimationConfig({
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
      title: 'Animation',
      content: _buildAnimationControls(),
      onReset: onReset,
    );
  }

  Widget _buildAnimationControls() {
    const List<DropdownMenuItem<Curve>> curveItems = <DropdownMenuItem<Curve>>[
      DropdownMenuItem<Curve>(value: Curves.linear, child: Text('Linear')),
      DropdownMenuItem<Curve>(value: Curves.easeIn, child: Text('Ease In')),
      DropdownMenuItem<Curve>(value: Curves.easeOut, child: Text('Ease Out')),
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
      DropdownMenuItem<Curve>(value: Curves.bounceIn, child: Text('Bounce In')),
      DropdownMenuItem<Curve>(
        value: Curves.bounceOut,
        child: Text('Bounce Out'),
      ),
      DropdownMenuItem<Curve>(
        value: Curves.easeOutBack,
        child: Text('Ease Out Back'),
      ),
    ];

    return Column(
      children: <Widget>[
        ConfigMenuSlider(
          title: 'Show Duration (ms)',
          value: configuration.showDuration.inMilliseconds.toDouble(),
          min: 100,
          max: 1000,
          steps: 100,
          onChanged:
              (double value) => onConfigChange(
                configuration.copyWith(
                  showDuration: Duration(milliseconds: value.toInt()),
                ),
              ),
        ),
        ConfigMenuDropDown(
          title: 'Show Curve',
          value: configuration.showCurve,
          options: curveItems,
          onChanged:
              (dynamic value) => onConfigChange(
                configuration.copyWith(showCurve: value as Curve),
              ),
        ),
        const Divider(),
        ConfigMenuSlider(
          title: 'Hide Duration (ms)',
          value: configuration.hideDuration.inMilliseconds.toDouble(),
          min: 100,
          max: 1000,
          steps: 100,
          onChanged:
              (double value) => onConfigChange(
                configuration.copyWith(
                  hideDuration: Duration(milliseconds: value.toInt()),
                ),
              ),
        ),
        ConfigMenuDropDown(
          title: 'Hide Curve',
          value: configuration.hideCurve,
          options: curveItems,
          onChanged:
              (dynamic value) => onConfigChange(
                configuration.copyWith(hideCurve: value as Curve),
              ),
        ),
      ],
    );
  }
}
