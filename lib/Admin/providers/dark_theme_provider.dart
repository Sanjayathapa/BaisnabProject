
import 'package:flutter/material.dart';
import '../services/dark_them_preferences.dart';
class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;

  bool get getDarkTheme => _darkTheme;

  set setDarkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}
class MessageCountProvider extends ChangeNotifier {
  int _newMessageCount = 0;

  int get newMessageCount => _newMessageCount;

  void incrementMessageCount() {
    _newMessageCount++;
    notifyListeners();
  }

  void resetMessageCount() {
    _newMessageCount = 0;
    notifyListeners();
  }
}