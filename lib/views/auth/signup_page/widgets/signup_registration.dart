import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/constants/my_app_validators.dart';
import 'package:nest_user_app/constants/password_field_types.dart';
import 'package:nest_user_app/controllers/auth_provider/auth_provider.dart';
import 'package:nest_user_app/widgets/my_button.dart';
import 'package:nest_user_app/widgets/my_custom_text_field.dart';
import 'package:provider/provider.dart';

class SignupRegistration extends StatelessWidget {
  const SignupRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<MyAuthProviders>(context);
    final myAppValidators = MyAppValidators();

    return Form(
      key: authProvider.signupFormKey,
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
            controller: authProvider.signupEmailController,
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
            controller: authProvider.signupPasswordController,
            hintText: 'Enter password',
            prefixIcon: Icons.password,
            obscureText: true,
            passwordType: PasswordFieldType.register,
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
            controller: authProvider.signupRepasswordController,
            hintText: 'Enter Password',
            prefixIcon: Icons.password,
            obscureText: true,
            passwordType: PasswordFieldType.confirm,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: myAppValidators.validatePassword,
          ),
          const SizedBox(height: 30),

          // Submit button
          Consumer<MyAuthProviders>(
            builder: (context, authProvider, child) {
              return authProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : MyCustomButton(
                    onPressed: () async {
                      if (authProvider.signupFormKey.currentState!.validate()) {
                        if (authProvider.signupPasswordController.text ==
                            authProvider.signupRepasswordController.text) {
                          bool success = await authProvider.createAccount(
                            authProvider.signupEmailController.text.trim(),
                            authProvider.signupPasswordController.text.trim(),
                            context,
                          );
                          if (success) {
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
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
                    backgroundcolor: AppColors.secondary,
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
