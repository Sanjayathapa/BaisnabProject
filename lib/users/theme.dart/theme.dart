
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
  int _selectedIconCodePoint = Icons.wb_sunny_outlined.codePoint; // Default icon code point

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


 
