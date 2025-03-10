import 'package:flutter/material.dart';
import 'package:pull_tab_menu/pull_tab_menu.dart';

// #docregion controller-example
class ControllerExample extends StatefulWidget {
  const ControllerExample({super.key});

  @override
  State<ControllerExample> createState() => _ControllerExampleState();
}

class _ControllerExampleState extends State<ControllerExample> {
  final PullTabController _controller = PullTabController();

  @override
  void initState() {
    super.initState();
    // Demonstrate opening/closing the menu programmatically
    // Give the user a quick peek of the menu to show they can open/close it
    Future<void>.delayed(Durations.short2, () => _controller.openMenu()).then(
      (_) =>
          Future<void>.delayed(Durations.long2, () => _controller.closeMenu()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pull Tab Menu Examples')),
      body: PullTabMenu(
        controller: _controller,
        menuItems: <PullTabMenuItem>[
          PullTabMenuItem(
            label: 'Example 1',
            icon: Icons.draw,
            onTap: () {
              // Handle navigation
              Navigator.pushNamed(context, '/example1');
            },
          ),
          PullTabMenuItem(
            label: 'Example 2',
            icon: Icons.style_outlined,
            onTap: () {
              // Handle navigation
              Navigator.pushNamed(context, '/example2');
            },
          ),
        ],
        child: Center(
          child: MaterialButton(
            child: const Text('Open Menu'),
            onPressed: () {
              // Open the menu
              _controller.openMenu();
            },
          ),
        ),
      ),
    );
  }
}

// #enddocregion controller-example
