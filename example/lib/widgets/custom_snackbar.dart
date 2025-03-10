import 'package:flutter/material.dart';

class CustomSnackBar {
  // Private constructor that takes the context
  CustomSnackBar._(this._context);
  final BuildContext _context;

  // Static 'of' method that returns a CustomSnackBar instance
  static CustomSnackBar of(BuildContext context) {
    return CustomSnackBar._(context);
  }

  // Method to show a message using the stored context
  void showMessage(String message) {
    ScaffoldMessenger.of(_context).hideCurrentSnackBar();
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Theme.of(_context).colorScheme.onInverseSurface,
          ),
        ),
        backgroundColor: Theme.of(_context).colorScheme.inverseSurface,
        behavior: SnackBarBehavior.floating,
        duration: Durations.long4,
      ),
    );
  }
}
