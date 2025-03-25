import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/auth_provider/auth_provider.dart';
import 'package:nest_user_app/views/auth/login_page/login_page_main.dart';
import 'package:nest_user_app/widgets/my_button.dart';
import 'package:nest_user_app/widgets/my_custom_text_field.dart';

import 'package:provider/provider.dart';

class SignupRegistration extends StatelessWidget {
  const SignupRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController repasswordController = TextEditingController();
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
          const SizedBox(height: 30),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Re Enter Password',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 10),
          MyCustomTextFormField(
            controller: repasswordController,
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
          const SizedBox(height: 30),
          Consumer<MyAuthProviders>(
            builder: (context, authProvider, child) {
              return MyCustomButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    if (passwordController.text == repasswordController.text) {
                      bool success = await authProvider.createAccount(
                        emailController.text,
                        passwordController.text,
                        context,
                      );
                      if (success) {
                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LogInPageMain(),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: AppColors.red,
                          content: Text('Passwords do not match'),
                        ),
                      );
                    }
                  }
                },
                backgroundcolor: AppColors.primary,
                textcolor: AppColors.white,
                text: 'SignUp',
              );
            },
          ),
        ],
      ),
    );
  }
}
