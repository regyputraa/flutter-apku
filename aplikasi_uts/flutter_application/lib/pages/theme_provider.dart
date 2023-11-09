import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void resetToDefault() {
    _isDarkMode = false;
    // Setel semua pengaturan lainnya ke nilai default
    // Contoh:
    // _someSetting = initialValue;
    notifyListeners();
  }

  ThemeData getTheme() {
    return _isDarkMode ? _darkTheme : _lightTheme;
  }

  ThemeData _lightTheme = ThemeData(
    primarySwatch: MaterialColor(
      0xFF00425A,
      <int, Color>{
        50: Color(0xFF00425A),
        100: Color(0xFF00425A),
        200: Color(0xFF00425A),
        300: Color(0xFF00425A),
        400: Color(0XFF00425A),
        500: Color(0xFF00425A),
        600: Color(0xFF00425A),
        700: Color(0xFF00425A),
        800: Color(0xFF00425A),
        900: Color(0xFF00425A),
      },
    ),
  );

  ThemeData _darkTheme = ThemeData.dark();
}
