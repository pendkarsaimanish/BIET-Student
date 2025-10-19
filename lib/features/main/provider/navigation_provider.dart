import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _index = 2; // Initial index is 'Home'

  int get index => _index;

  void setIndex(int newIndex) {
    if (_index == newIndex) return; // Don't rebuild if the index is the same
    _index = newIndex;
    notifyListeners();
  }
}
