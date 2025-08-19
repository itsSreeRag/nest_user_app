import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/password_field_types.dart';

class CustometexfieldProvider with ChangeNotifier {
  
  final Map<PasswordFieldType, bool> obscureMap = {
    PasswordFieldType.login: true,
    PasswordFieldType.register: true,
    PasswordFieldType.confirm: true,
  };

  bool isObscure(PasswordFieldType type) {
    return obscureMap[type] ?? true;
  }

  void toggleVisibility(PasswordFieldType type) {
    obscureMap[type] = !(obscureMap[type] ?? true);
    notifyListeners();
  }
}
