import 'package:flutter/material.dart';

class ChangeProvider extends ChangeNotifier {
  void changed(bool isTrue) {
    isTrue = !isTrue;
    notifyListeners();
  }
}
