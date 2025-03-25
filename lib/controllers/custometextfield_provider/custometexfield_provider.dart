import 'package:flutter/material.dart';

class CustometexfieldProvider extends ChangeNotifier {
  bool isObscureText = true;

  visibilityButtonClick() {
    isObscureText = !isObscureText;
    notifyListeners();
  }

  
}
