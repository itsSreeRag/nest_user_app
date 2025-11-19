import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';

class SignupPageHeading extends StatelessWidget {
  const SignupPageHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Create Account',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        SizedBox(height: 15),
        SizedBox(
          width: 230,
          child: Text(
            'Create an account so you can explore all the  Hotels',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
        ),
        SizedBox(height: 35),
      ],
    );
  }
}
