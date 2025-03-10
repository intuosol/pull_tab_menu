import 'package:flutter/material.dart';

class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();
  // Dark theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff9ad4a1),
      onPrimary: Color(0xff003916),
      primaryContainer: Color(0xff1a512a),
      onPrimaryContainer: Color(0xffb5f1bc),
      secondary: Color(0xffb7ccb6),
      onSecondary: Color(0xff233425),
      secondaryContainer: Color(0xff394b3b),
      onSecondaryContainer: Color(0xffd3e8d2),
      tertiary: Color(0xffa1ced8),
      onTertiary: Color(0xff00363e),
      tertiaryContainer: Color(0xff204d55),
      onTertiaryContainer: Color(0xffbdeaf4),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff101510),
      onSurface: Color(0xffdfe4dc),
      surfaceTint: Color(0xff9ad4a1),
      outline: Color(0xff8b9389),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe4dc),
      onInverseSurface: Color(0xff2d322c),
      inversePrimary: Color(0xff336940),
    ),
  );
}
