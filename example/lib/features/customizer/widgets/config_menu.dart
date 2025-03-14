import 'package:flutter/material.dart';

class ConfigMenu extends StatelessWidget {
  const ConfigMenu({
    super.key,
    required this.title,
    required this.content,
    required this.onReset,
  });

  final String title;
  final Widget content;
  final VoidCallback? onReset;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerTheme: DividerThemeData(
          color: Theme.of(context).dividerColor,
          thickness: 0.25,
        ),
        listTileTheme: const ListTileThemeData(tileColor: Colors.transparent),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                  if (onReset != null)
                    IconButton(
                      icon: const Icon(Icons.restart_alt, size: 20),
                      tooltip: 'Reset to default',
                      onPressed: onReset,
                    ),
                ],
              ),
              const Divider(),
              content,
            ],
          ),
        ),
      ),
    );
  }
}

class ConfigMenuSlider extends StatelessWidget {
  const ConfigMenuSlider({
    super.key,
    required this.title,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.subtitle = '',
    this.steps = 2,
  });

  final String title;
  final String subtitle;
  final double value;
  final double min;
  final double max;
  final double steps;
  final ValueChanged<double>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: 100,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            Expanded(
              child: Slider(
                value: value,
                min: min,
                max: max,
                divisions: max ~/ steps,
                label: value.toStringAsFixed(1),
                onChanged: onChanged,
              ),
            ),
            SizedBox(width: 50, child: Text(value.toStringAsFixed(1))),
          ],
        ),
        if (subtitle.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              subtitle,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ),
      ],
    );
  }
}

class ConfigMenuColorPicker extends StatelessWidget {
  const ConfigMenuColorPicker({
    super.key,
    required this.title,
    required this.selectedColor,
    required this.options,
    required this.onColorChanged,
    this.subtitle = '',
  });

  final String title;
  final String subtitle;
  final Color? selectedColor;
  final List<Color> options;
  final ValueChanged<Color>? onColorChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      contentPadding: EdgeInsets.zero,
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          subtitle,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
      trailing: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: selectedColor,
          border: Border.all(),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      onTap: () async {
        await showDialog(
          context: context,
          builder:
              (BuildContext context) => AlertDialog(
                title: Text('Select $title'),
                content: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        options.map((Color color) {
                          return MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                onColorChanged?.call(color);
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                decoration:
                                    color == selectedColor
                                        ? BoxDecoration(
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.surface,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: color,
                                            width: 3,
                                          ),
                                        )
                                        : null,
                                padding: const EdgeInsets.all(4),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
        );
      },
    );
  }
}

class ConfigMenuDropDown extends StatelessWidget {
  const ConfigMenuDropDown({
    super.key,
    required this.title,
    required this.value,
    required this.options,
    required this.onChanged,
    this.subtitle = '',
  });

  final String title;
  final String subtitle;
  final dynamic value;
  final List<DropdownMenuItem<dynamic>> options;
  final ValueChanged<dynamic>? onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.labelLarge),
      trailing: DropdownButton<dynamic>(
        value: value,
        items: options,
        onChanged: onChanged,
      ),
    );
  }
}

class ConfigMenuSwitch extends StatelessWidget {
  const ConfigMenuSwitch({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle = '',
  });

  final String title;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          subtitle,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
      value: value,
      onChanged: onChanged,
    );
  }
}
