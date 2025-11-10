import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';

class SignupPageBottom extends StatelessWidget {
  const SignupPageBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account? Log in ",
              style: TextStyle(fontSize: 14, color: AppColors.grey),
            ),
            const Text(
              'Log in',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
