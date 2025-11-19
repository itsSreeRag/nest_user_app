import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/views/auth/login_page_email/widget/login_page_email_reg.dart';
import 'package:nest_user_app/views/auth/login_page_email/widget/login_page_heading.dart';
import 'package:nest_user_app/views/auth/login_page_email/widget/sign_up_link.dart';

class LoginPageEmail extends StatelessWidget {
  const LoginPageEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width:MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withAlpha(200),
              AppColors.primary,
              AppColors.primary.withAlpha(200),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 100),
                  LoginPageHeading(),
                  LoginPageEmailReg(),
                  SignUpLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
