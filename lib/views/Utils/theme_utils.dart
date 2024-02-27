import 'package:flutter/material.dart';

class ThemeUtils {
  static ThemeData getLightTheme() {
    return ThemeData.light().copyWith(
        primaryColor: Colors.blue,
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Colors.grey.shade300,
            onPrimary: Colors.lightBlue.shade400,
            secondary: Colors.lightBlue.shade200,
            onSecondary: Colors.black,
            error: Colors.red,
            onError: Colors.red,
            background: Colors.grey.shade300,
            onBackground: Colors.black45,
            surface: Colors.white70,
            onSurface: Colors.black54.withOpacity(0.7))
        // Add other properties for the light theme
        );
  }

  static ThemeData getDarkTheme() {
    return ThemeData.dark().copyWith(
        primaryColor: Colors.red,
        colorScheme: ColorScheme(
            brightness: Brightness.dark,
            primary: Colors.grey.shade700.withOpacity(0.2),
            onPrimary: Colors.grey,
            secondary: Colors.pink,
            onSecondary: Colors.white,
            error: Colors.red,
            onError: Colors.red,
            background: Colors.grey.withOpacity(0.2),
            onBackground: Colors.grey.shade800,
            surface: Colors.grey.shade900,
            onSurface: Colors.white70)
        // Add other properties for the light theme
        );
  }
}
