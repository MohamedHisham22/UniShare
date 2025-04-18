import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.grey.shade900,
      colorScheme: ColorScheme.dark(
        primary: Colors.grey.shade800,
        secondary: Colors.grey.shade600,
      ));

  static final lightTheme = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(
        primary: Colors.grey.shade300,
        secondary: Colors.grey.shade100,
      ));
}

class ThemeProvider extends ChangeNotifier {
  // Default theme mode
  ThemeMode _themeMode = ThemeMode.light;

  // Getter for the current theme mode
  ThemeMode get themeMode => _themeMode;

  // Function to toggle the theme
  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
      notifyListeners(); // Notify listeners about the change
    } else {
      _themeMode = ThemeMode.light;
      notifyListeners(); // Notify listeners about the change
    }
  }

  // Function to set a specific theme
  void setTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }
}
