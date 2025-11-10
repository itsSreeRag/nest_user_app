import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/constants/my_app_validators.dart';
import 'package:nest_user_app/constants/password_field_types.dart';
import 'package:nest_user_app/controllers/auth_provider/auth_provider.dart';
import 'package:nest_user_app/views/auth/forgot_password/forgot_password_page.dart';
import 'package:nest_user_app/widgets/my_button.dart';
import 'package:nest_user_app/widgets/my_custom_text_field.dart';
import 'package:provider/provider.dart';

class LoginPageEmailReg extends StatelessWidget {
  const LoginPageEmailReg({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final myAppValidators = MyAppValidators();

    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [      
            const SizedBox(height: 40),     
            // Email field
            const Text(
              'E-Mail ID',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            MyCustomTextFormField(
              controller: emailController,
              prefixIcon: Icons.email_outlined,
              hintText: 'Enter your email',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: myAppValidators.validateEmail,
            ),
        
            const SizedBox(height: 24),
        
            // Password field
            const Text(
              'Password',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            MyCustomTextFormField(
              controller: passwordController,
              hintText: 'Enter your password',
              prefixIcon: Icons.lock_outline,
              obscureText: true,
              passwordType: PasswordFieldType.login,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: myAppValidators.validatePassword,
            ),
        
            const SizedBox(height: 16),
        
            // Forgot password
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordPage(),
                    ),
                  );
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
        
            const SizedBox(height: 32),
        
            // Login button
            Consumer<MyAuthProviders>(
              builder: (context, authProvider, _) {
                return SizedBox(
                  width: double.infinity,
                  child: MyCustomButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        authProvider.loginAccount(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                          context,
                        );
                      }
                    },
                    backgroundcolor: AppColors.primary,
                    textcolor: AppColors.white,
                    text: 'Log In',
                    isLoading: authProvider.isLoading,
                    width: double.infinity,
                  ),
                );
              },
            ),
        
            const SizedBox(height: 24),
        
            // Sign up link
        
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
