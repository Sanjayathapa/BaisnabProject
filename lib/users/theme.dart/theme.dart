import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = ThemeData.light();
  bool _isDarkMode = false;

  ThemeData getTheme() => _currentTheme;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _currentTheme = _isDarkMode ? ThemeData.dark() : ThemeData.light();
    notifyListeners();
  }

  void setTheme(ThemeData theme) {
    _currentTheme = theme;
    notifyListeners();
  }
}

class IconNotifier extends ChangeNotifier {
  int _selectedIconCodePoint =
      Icons.wb_sunny_outlined.codePoint; // Default icon code point

  int get selectedIconCodePoint => _selectedIconCodePoint;

  void setIconCodePoint(int codePoint) {
    _selectedIconCodePoint = codePoint;
    notifyListeners();
  }
}

class CounterProvider extends ChangeNotifier {
  int _counter = 1;

  int get counter => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners(); // Notify listeners about the change in state
  }
}

class ContainerColorProvider extends ChangeNotifier {
  Color _containerColor = Color.fromARGB(255, 252, 202, 38);
  Color _containColor = Color.fromARGB(255, 206, 245, 251);
  bool _isColorChanged = false;

  Color get containerColor => _containerColor;
  Color get containColor => _containColor;
  bool get isColorChanged => _isColorChanged;

  void setHoverColor() {
    _containerColor = Color.fromARGB(255, 128, 248, 9).withOpacity(0.7);
     _containColor = Color.fromARGB(255, 5, 147, 229);
    _isColorChanged = true;
    notifyListeners();
  }

  void resetColor() {
    _containerColor = Color.fromARGB(255, 252, 202, 38);
       _containColor =  Color.fromARGB(255, 235, 249, 239);
    _isColorChanged = false;
    notifyListeners();
  }
}
