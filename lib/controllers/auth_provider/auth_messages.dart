import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/widgets/my_custom_snack_bar.dart';


class AuthMessages {
  static void showSuccess(BuildContext context, String message) {
    MyCustomSnackBar.show(
      context: context,
      title: 'Success',
      message: message,
      icon: Icons.check_circle,
      backgroundColor: AppColors.green,
    );
  }

  static void showError(BuildContext context, String message) {
    MyCustomSnackBar.show(
      context: context,
      title: 'Error',
      message: message,
      icon: Icons.error,
      backgroundColor: AppColors.red,
    );
  }
}

