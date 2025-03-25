import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/auth_provider/auth_provider.dart';
import 'package:nest_user_app/views/auth/forgot_password/forgot_password_page.dart';
import 'package:nest_user_app/views/auth/signup_page/sign_up_screen.dart';
import 'package:nest_user_app/widgets/my_button.dart';
import 'package:nest_user_app/widgets/my_custom_text_field.dart';

import 'package:provider/provider.dart';

class LoginPageEmailAuth extends StatelessWidget {
  const LoginPageEmailAuth({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final authProvider = Provider.of<MyAuthProviders>(context);
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'E-Mail ID',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 10),
          MyCustomTextFormField(
            controller: emailController,
            prefixIcon: const Icon(Icons.email),
            labelText: 'Email',
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              } else if (!RegExp(
                r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-z]{2,7}$',
              ).hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Password',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 10),
          MyCustomTextFormField(
            controller: passwordController,
            labelText: 'Password',
            prefixIcon: const Icon(Icons.password),
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              } else if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                );
              },
              child: Text(
                ' Forgot Password?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 40),
          MyCustomButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                authProvider.loginAccount(
                  emailController.text,
                  passwordController.text,
                  context,
                );
              } else {
                null;
              }
            },
            backgroundcolor: AppColors.primary,
            textcolor: AppColors.white,
            text: 'LogIn',
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MySignUpPage()),
              );
            },
            child: const Text(
              'Don’t have an account? Sign up',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
