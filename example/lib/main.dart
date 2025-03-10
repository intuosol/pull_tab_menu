import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pull_tab_menu/pull_tab_menu.dart';
import 'screens/customized_example.dart';
import 'screens/sketch_pad.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pull Tab Menu Example',
      darkTheme: AppTheme.darkTheme,
      home: const MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/customized': (BuildContext context) => const CustomizedExample(),
        '/sketchpad': (BuildContext context) => const SketchPad(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PullTabController _controller = PullTabController();

  @override
  void initState() {
    // Give the user a quick peek of the menu to show they can open/close it
    Future<void>.delayed(Durations.short2, () => _controller.openMenu()).then(
      (_) =>
          Future<void>.delayed(Durations.long2, () => _controller.closeMenu()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // The actual implementation
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pull Tab Menu Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: PullTabMenu(
        controller: _controller,
        menuItems: <PullTabMenuItem>[
          PullTabMenuItem(
            label: 'Sketch Pad Example',
            icon: Symbols.draw,
            onTap: () {
              Navigator.pushNamed(context, '/sketchpad');
            },
          ),
          PullTabMenuItem(
            label: 'Customized Example',
            icon: Icons.style_outlined,
            onTap: () {
              Navigator.pushNamed(context, '/customized');
            },
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              const Spacer(),
              Text(
                'Select an Example',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Divider(),
              const SizedBox(height: 20),

              _buildExampleButton(
                context: context,
                title: 'Sketch Pad Example',
                icon: Symbols.draw,
                description:
                    'Draw on the screen, use the menu to select drawing options',
                route: '/sketchpad',
              ),
              _buildExampleButton(
                context: context,
                title: 'Customized Example',
                icon: Icons.style_outlined,
                description: 'Customize the menu appearance and behavior',
                route: '/customized',
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExampleButton({
    required String title,
    required IconData icon,
    required String description,
    required String route,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: Theme.of(
          context,
        ).colorScheme.inverseSurface.withValues(alpha: 0.01),
        onTap: () => Navigator.pushNamed(context, route),
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(description),
      ),
    );
  }
}
