/// Defines the position of the menu on the screen.
enum MenuPosition {
  /// Menu is positioned at the top left of the screen.
  topLeft,

  /// Menu is positioned at the center left of the screen.
  centerLeft,

  /// Menu is positioned at the bottom left of the screen.
  bottomLeft,

  /// Menu is positioned at the top right of the screen.
  topRight,

  /// Menu is positioned at the center right of the screen.
  centerRight,

  /// Menu is positioned at the bottom right of the screen.
  bottomRight,
}

/// Extension to determine if the menu position is on the left or right side of the screen.
extension MenuPositionExtension on MenuPosition {
  bool get isLeft =>
      this == MenuPosition.topLeft ||
      this == MenuPosition.centerLeft ||
      this == MenuPosition.bottomLeft;
  bool get isRight =>
      this == MenuPosition.topRight ||
      this == MenuPosition.centerRight ||
      this == MenuPosition.bottomRight;
}
