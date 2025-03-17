import 'package:flutter/material.dart';
import 'package:pull_tab_menu/pull_tab_menu.dart';

/// Preview of the pull tab menu widget to display in the WidgetSnippet modal
class PullTabMenuPreview extends StatefulWidget {
  const PullTabMenuPreview({
    super.key,
    required this.menuItems,
    required this.configuration,
  });
  final List<PullTabMenuItem> menuItems;

  final PullTabMenuConfiguration configuration;

  @override
  State<PullTabMenuPreview> createState() => _PullTabMenuPreviewState();
}

class _PullTabMenuPreviewState extends State<PullTabMenuPreview> {
  final PullTabController _controller = PullTabController();

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(Durations.short2, () => _controller.openMenu());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: Row(
        children: <Widget>[
          Placeholder(
            child: PullTabMenu(
              controller: _controller,
              menuItems: widget.menuItems,
              configuration: widget.configuration,
              child: Container(),
            ),
          ),
        ],
      ),
    );
  }
}
