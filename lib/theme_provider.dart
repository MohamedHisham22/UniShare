import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MyThemes {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(
      primary: Colors.grey.shade800,
      secondary: Colors.grey.shade600,
    ),
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: Colors.grey.shade300,
      secondary: Colors.grey.shade100,
    ),
  );
}

class ThemeProvider extends ChangeNotifier {
  // Default theme mode
  ThemeMode _themeMode = ThemeMode.light;

  // Getter for the current theme mode
  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadThemeFromHive();
  }
  // Function to toggle the theme
  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
      
    } else {
      _themeMode = ThemeMode.light;
      
    }
    _saveThemeToHive();
    notifyListeners(); // Notify listeners about the change
  }

  // Function to set a specific theme
  void setTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    _saveThemeToHive();
    notifyListeners();
  }

  void _saveThemeToHive() {
    final box = Hive.box('settings');
    box.put('isDarkMode', _themeMode == ThemeMode.dark);
  }

  void _loadThemeFromHive() {
    final box = Hive.box('settings');
    final isDarkMode = box.get('isDarkMode', defaultValue: false);
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
