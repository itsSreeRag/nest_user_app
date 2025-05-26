import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/constants/my_app_validators.dart';
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
    final MyAppValidators myAppValidators = MyAppValidators();

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
            prefixIcon: Icons.email,
            hintText: 'Enter Email',
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: myAppValidators.validateEmail,
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
            hintText: 'Enter password',
            prefixIcon: Icons.password,
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: myAppValidators.validatePassword,
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
            hintText: 'Enter Password',
            prefixIcon: Icons.password,
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: myAppValidators.validatePassword,
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
