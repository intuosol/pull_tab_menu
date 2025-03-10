import 'package:flutter/material.dart';
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
  final PullTabController _controller = PullTabController();

  int _menuIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (!_controller.isMenuOpen) {
        setState(() {
          _menuIndex = 0;
        });
      }
    });
  }

  List<PullTabMenuItem> _mainMenuItems() {
    return <PullTabMenuItem>[
      PullTabMenuItem(
        label: 'Clear',
        icon: Icons.cleaning_services,
        iconColor: lines.isEmpty ? Colors.white12 : null,
        onTap:
            () => setState(() {
              undoLines.addAll(lines);
              lines.clear();
              _controller.closeMenu();
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
    void onColorTap(Color color) => setState(() {
      selectedColor = color;
      _controller.closeMenu();
    });

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
        onTap: () => onColorTap(Colors.white),
      ),
      PullTabMenuItem(
        label: 'Red',
        icon: Icons.circle,
        iconColor: Colors.red,
        isSelected: selectedColor == Colors.red,
        onTap: () => onColorTap(Colors.red),
      ),
      PullTabMenuItem(
        label: 'Blue',
        icon: Icons.circle,
        iconColor: Colors.blue,
        isSelected: selectedColor == Colors.blue,
        onTap: () => onColorTap(Colors.blue),
      ),
      PullTabMenuItem(
        label: 'Green',
        icon: Icons.circle,
        iconColor: Colors.green,
        isSelected: selectedColor == Colors.green,
        onTap: () => onColorTap(Colors.green),
      ),
    ];
  }

  List<PullTabMenuItem> _strokeMenuItems() {
    void onStrokeTap(double strokeWidth) => setState(() {
      this.strokeWidth = strokeWidth;
      _controller.closeMenu();
    });

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
        onTap: () => onStrokeTap(1.0),
      ),
      PullTabMenuItem(
        label: 'Medium Stroke',
        icon: Symbols.pen_size_2,
        isSelected: strokeWidth == 5.0,
        onTap: () => onStrokeTap(5.0),
      ),
      PullTabMenuItem(
        label: 'Thick Stroke',
        icon: Symbols.pen_size_4,
        isSelected: strokeWidth == 10.0,
        onTap: () => onStrokeTap(10.0),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Draw Pad')),
      body: PullTabMenu(
        controller: _controller,
        configuration: PullTabMenuConfiguration(
          baseColor: Theme.of(context).colorScheme.primaryContainer,
          foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          menuPosition: MenuPosition.topLeft,
          axis: Axis.horizontal,
          closeMenuOnTap: false,
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
              const Center(
                child: Text(
                  'Pull tab to select drawing options',
                  style: TextStyle(color: Colors.grey),
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
              onPanEnd: (_) {
                // No need to add any ending point
              },
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
