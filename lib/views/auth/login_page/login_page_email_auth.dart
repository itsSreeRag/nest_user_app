import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/constants/my_app_validators.dart';
import 'package:nest_user_app/constants/password_field_types.dart';
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
    // final authProvider = Provider.of<MyAuthProviders>(context);
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
            hintText: 'Enter Password',
            prefixIcon: Icons.password,
            obscureText: true,
            passwordType: PasswordFieldType.login,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: myAppValidators.validatePassword,
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
          Consumer<MyAuthProviders>(
            builder: (context, authProvider, _) {
              return authProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : MyCustomButton(
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
                  );
            },
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
