import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/menu_item.dart';

/// Controller for the pull tab menu.
class PullTabController extends ChangeNotifier {
  bool _isMenuOpen = false;
  bool _isDragging = false;
  double _dragPosition = 0.0;
  List<PullTabMenuItem> menuItems = <PullTabMenuItem>[];

  /// Whether the menu is currently open.
  bool get isMenuOpen => _isMenuOpen;

  /// Whether the tab is currently being dragged.
  bool get isDragging => _isDragging;

  /// The current position of the tab while dragging.
  double get dragPosition => _dragPosition;

  /// Opens the menu.
  void openMenu() {
    if (!_isMenuOpen) {
      _isMenuOpen = true;
      notifyListeners();
    }
  }

  /// Closes the menu.
  void closeMenu() {
    if (_isMenuOpen) {
      _isMenuOpen = false;
      notifyListeners();
    }
  }

  /// Toggles the menu open/closed state.
  void toggleMenu() {
    _isMenuOpen = !_isMenuOpen;
    notifyListeners();
  }

  /// Updates the drag position of the tab.
  void updateDragPosition(double position) {
    _dragPosition = position;
    notifyListeners();
  }

  /// Sets whether the tab is being dragged.
  void setDragging(bool isDragging) {
    _isDragging = isDragging;
    notifyListeners();
  }

  /// Saves the current tab position to persistent storage.
  Future<void> saveTabPosition(double top, double left) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('pull_tab_position_top', top);
    await prefs.setDouble('pull_tab_position_left', left);
  }

  /// Loads the saved tab position from persistent storage.
  Future<Map<String, double>> loadTabPosition() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final double? top = prefs.getDouble('pull_tab_position_top');
    final double? left = prefs.getDouble('pull_tab_position_left');

    return <String, double>{'top': top ?? 0.0, 'left': left ?? 0.0};
  }
}
