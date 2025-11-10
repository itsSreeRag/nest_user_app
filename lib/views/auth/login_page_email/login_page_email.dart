import 'package:flutter/material.dart';
import 'package:nest_user_app/views/auth/login_page_email/widget/login_page_email_reg.dart';
import 'package:nest_user_app/views/auth/login_page_email/widget/login_page_heading.dart';
import 'package:nest_user_app/views/auth/login_page_email/widget/sign_up_link.dart';

class LoginPageEmail extends StatelessWidget {
  const LoginPageEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
    );
  }
}
