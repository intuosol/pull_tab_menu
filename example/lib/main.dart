import 'package:flutter/material.dart';
import 'package:intuosol_design_system/intuosol_design_system.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pull_tab_menu/pull_tab_menu.dart';
import 'features/customizer/customizer.dart';
import 'features/sketch_pad.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return IntuoSolApp(
      title: 'Pull Tab Menu Demo',
      home: const MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/customizer-playground':
            (BuildContext context) => const PullTabMenuCustomizer(),
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
      (_) => Future<void>.delayed(
        Durations.extralong2,
        () => _controller.closeMenu(),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // The actual implementation
    return IntuoSolScaffold(
      appBar: AppBar(title: const Text('Pull Tab Menu Demo')),
      body: PullTabMenu(
        controller: _controller,
        menuItems: <PullTabMenuItem>[
          PullTabMenuItem(
            label: 'Sketch Pad',
            icon: Symbols.draw,
            onTap: () {
              Navigator.pushNamed(context, '/sketchpad');
            },
          ),
          const PullTabMenuItem.divider(),
          PullTabMenuItem(
            label: 'Customizer Playground',
            icon: Icons.style_outlined,
            onTap: () {
              Navigator.pushNamed(context, '/customizer-playground');
            },
          ),
          const PullTabMenuItem.divider(),
          PullTabMenuItem(
            label: 'Pub.dev',
            icon: Symbols.package_2,
            onTap: () {
              RedirectHandler.openPackage('pull_tab_menu');
            },
          ),
          const PullTabMenuItem.divider(),
          PullTabMenuItem(
            label: 'API Reference',
            icon: Symbols.docs,
            onTap: () {
              RedirectHandler.openPackageDocumentation('pull_tab_menu');
            },
          ),
        ],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 400,
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 24),
                  const IntuoSolSectionHeader(
                    title: 'Select a Demo',
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  _buildMenuOption(
                    context: context,
                    title: 'Sketch Pad',
                    icon: Symbols.draw,
                    subtitle:
                        'Draw on the screen, use the menu for more options.',
                    onTap: () => Navigator.pushNamed(context, '/sketchpad'),
                  ),
                  _buildMenuOption(
                    context: context,
                    title: 'Customizer Playground',
                    icon: Icons.style_outlined,
                    subtitle: 'Customize the menu appearance and behavior.',
                    onTap:
                        () => Navigator.pushNamed(
                          context,
                          '/customizer-playground',
                        ),
                  ),
                  const SizedBox(height: 24),
                  const IntuoSolSectionHeader(
                    title: 'More Info',
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  _buildMenuOption(
                    context: context,
                    title: 'Pub.dev',
                    icon: Symbols.package_2,
                    subtitle: 'View the package on pub.dev.',
                    onTap: () => RedirectHandler.openPackage('pull_tab_menu'),
                  ),
                  _buildMenuOption(
                    context: context,
                    title: 'API Reference',
                    icon: Symbols.docs,
                    subtitle: 'Read the documentation.',
                    onTap:
                        () => RedirectHandler.openPackageDocumentation(
                          'pull_tab_menu',
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: IntuoSolButtons.floatingAboutPackage(
        context: context,
        packageName: 'pull_tab_menu',
        description:
            'Elegant context menus for Flutter apps via a discreet pull-out tab. Preserves clean aesthetics while providing quick access to actions.',
      ),
    );
  }

  Widget _buildMenuOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: Theme.of(
          context,
        ).colorScheme.inverseSurface.withValues(alpha: 0.02),
        onTap: onTap,
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
