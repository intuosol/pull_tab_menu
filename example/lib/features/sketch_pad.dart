import 'package:flutter/material.dart';
import 'package:intuosol_design_system/intuosol_design_system.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pull_tab_menu/pull_tab_menu.dart';

class SketchPad extends StatefulWidget {
  const SketchPad({super.key});

  @override
  State<SketchPad> createState() => _SketchPadState();
}

class _SketchPadState extends State<SketchPad> {
  Color selectedColor = Colors.white;
  double strokeWidth = 5.0;
  final List<DrawingLine> lines = <DrawingLine>[];
  final List<DrawingLine> undoLines = <DrawingLine>[];

  int _menuIndex = 0;

  List<PullTabMenuItem> _mainMenuItems() {
    return <PullTabMenuItem>[
      PullTabMenuItem(
        label: 'Clear',
        icon: Symbols.cleaning_services,
        iconColor: lines.isEmpty ? Colors.white12 : null,
        onTap:
            () => setState(() {
              undoLines.addAll(lines);
              lines.clear();
            }),
      ),
      PullTabMenuItem(
        label: 'Undo',
        icon: Icons.undo,
        iconColor: lines.isEmpty ? Colors.white12 : null,
        onTap: () {
          if (lines.isNotEmpty) {
            setState(() {
              undoLines.add(lines.removeLast());
            });
          }
        },
      ),
      PullTabMenuItem(
        label: 'Redo',
        icon: Icons.redo,
        iconColor: undoLines.isEmpty ? Colors.white12 : null,
        onTap: () {
          if (undoLines.isNotEmpty) {
            setState(() {
              lines.add(undoLines.removeLast());
            });
          }
        },
      ),
      const PullTabMenuItem.divider(),
      PullTabMenuItem(
        label: 'Colors',
        icon: Icons.palette_outlined,
        onTap: () {
          setState(() {
            _menuIndex = 1;
          });
        },
      ),
      PullTabMenuItem(
        label: 'Strokes',
        icon: Icons.line_weight,
        onTap: () {
          setState(() {
            _menuIndex = 2;
          });
        },
      ),
    ];
  }

  List<PullTabMenuItem> _colorMenuItems() {
    return <PullTabMenuItem>[
      PullTabMenuItem(
        label: 'Return',
        icon: Symbols.keyboard_return,
        onTap: () {
          setState(() {
            _menuIndex = 0;
          });
        },
      ),
      const PullTabMenuItem.divider(),
      PullTabMenuItem(
        label: 'White',
        icon: Icons.circle,
        iconColor: Colors.white,
        isSelected: selectedColor == Colors.white,
        onTap: () => setState(() => selectedColor = Colors.white),
      ),
      PullTabMenuItem(
        label: 'Red',
        icon: Icons.circle,
        iconColor: Colors.red,
        isSelected: selectedColor == Colors.red,
        onTap: () => setState(() => selectedColor = Colors.red),
      ),
      PullTabMenuItem(
        label: 'Blue',
        icon: Icons.circle,
        iconColor: Colors.blue,
        isSelected: selectedColor == Colors.blue,
        onTap: () => setState(() => selectedColor = Colors.blue),
      ),
      PullTabMenuItem(
        label: 'Green',
        icon: Icons.circle,
        iconColor: Colors.green,
        isSelected: selectedColor == Colors.green,
        onTap: () => setState(() => selectedColor = Colors.green),
      ),
    ];
  }

  List<PullTabMenuItem> _strokeMenuItems() {
    return <PullTabMenuItem>[
      PullTabMenuItem(
        label: 'Return',
        icon: Symbols.keyboard_return,
        onTap: () {
          setState(() {
            _menuIndex = 0;
          });
        },
      ),
      const PullTabMenuItem.divider(),
      PullTabMenuItem(
        label: 'Thin Stroke',
        icon: Symbols.pen_size_1,
        isSelected: strokeWidth == 1.0,
        onTap: () => setState(() => strokeWidth = 1.0),
      ),
      PullTabMenuItem(
        label: 'Medium Stroke',
        icon: Symbols.pen_size_2,
        isSelected: strokeWidth == 5.0,
        onTap: () => setState(() => strokeWidth = 5.0),
      ),
      PullTabMenuItem(
        label: 'Thick Stroke',
        icon: Symbols.pen_size_4,
        isSelected: strokeWidth == 10.0,
        onTap: () => setState(() => strokeWidth = 10.0),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return IntuoSolScaffold(
      appBar: AppBar(title: const Text('Sketch Pad')),
      body: PullTabMenu(
        configuration: PullTabMenuConfiguration(
          baseColor: Theme.of(context).colorScheme.primaryContainer,
          foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          initialAlignment: MenuAlignment.topLeft,
          axis: Axis.horizontal,
          closeMenuOnTap: false,
          useBackgroundOverlay: false,
        ),
        menuItems:
            _menuIndex == 0
                ? _mainMenuItems()
                : _menuIndex == 1
                ? _colorMenuItems()
                : _strokeMenuItems(),
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.black12,
              width: double.infinity,
              height: double.infinity,
            ),
            if (lines.isEmpty)
              Center(
                child: Text(
                  'Draw on the canvas.\nOpen the menu for more options.',
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium!.copyWith(color: Colors.white54),
                  textAlign: TextAlign.center,
                ),
              ),
            GestureDetector(
              onPanStart: (DragStartDetails details) {
                setState(() {
                  lines.add(
                    DrawingLine(
                      color: selectedColor,
                      width: strokeWidth,
                      points: <Offset>[details.localPosition],
                    ),
                  );
                  undoLines.clear();
                });
              },
              onPanUpdate: (DragUpdateDetails details) {
                setState(() {
                  if (lines.isNotEmpty) {
                    lines.last.points.add(details.localPosition);
                  }
                });
              },
              onPanEnd: (_) {},
              child: CustomPaint(
                painter: DrawingPainter(lines: lines),
                size: Size.infinite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawingLine {
  DrawingLine({required this.color, required this.width, required this.points});
  final Color color;
  final double width;
  final List<Offset> points;
}

class DrawingPainter extends CustomPainter {
  DrawingPainter({required this.lines});
  final List<DrawingLine> lines;

  @override
  void paint(Canvas canvas, Size size) {
    for (final DrawingLine line in lines) {
      if (line.points.length < 2) {
        continue;
      }

      final Paint paint =
          Paint()
            ..color = line.color
            ..strokeWidth = line.width
            ..strokeCap = StrokeCap.round
            ..strokeJoin = StrokeJoin.round
            ..style = PaintingStyle.stroke;

      for (int i = 0; i < line.points.length - 1; i++) {
        canvas.drawLine(line.points[i], line.points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant DrawingPainter oldDelegate) {
    return true; // Always repaint for simplicity
  }
}
