import 'package:flutter/material.dart';
import '../models/menu_item.dart';

/// Controller for the pull tab menu.
class PullTabController extends ChangeNotifier {
  bool _isMenuOpen = false;
  bool _isDragging = false;
  Offset position = Offset.zero;
  List<PullTabMenuItem> menuItems = <PullTabMenuItem>[];

  /// Whether the menu is currently open.
  bool get isMenuOpen => _isMenuOpen;

  /// Whether the tab is currently being dragged.
  bool get isDragging => _isDragging;

  /// Sets whether the tab is being dragged.
  set isDragging(bool isDragging) {
    _isDragging = isDragging;
    notifyListeners();
  }

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

  /// Determines if the menu is on the left edge of the screen based on its position.
  bool isMenuOnLeftEdge(double screenWidth) {
    if (position.dx < screenWidth / 2) {
      return true;
    }
    return false;
  }
}
