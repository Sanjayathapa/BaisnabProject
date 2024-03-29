
import 'package:flutter/material.dart';


class MessageCountProvider extends ChangeNotifier {
  int _newMessageCount = 0;

  int get newMessageCount => _newMessageCount;

  void incrementMessageCount() {
    _newMessageCount++;
    notifyListeners();
  }
void decrementMessageCount() {
    _newMessageCount--;
    notifyListeners();
  }
  void resetMessageCount() {
    _newMessageCount = 0;
    notifyListeners();
  }
}
class LoadingProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners(); // Notify listeners about the change in state
  }
}