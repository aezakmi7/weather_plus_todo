import 'package:flutter/material.dart';

// light mode
ThemeData lightMode = ThemeData(
  brightness: Brightness.light, // light theme
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade400,
    primary: Colors.grey.shade600,
    secondary: Colors.grey.shade400,
    inversePrimary: Colors.grey.shade200,
  ),
);

// dark mode
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark, // light theme
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade100,
    secondary: Colors.grey.shade700,
    inversePrimary: Colors.grey.shade700,
  ),
);
