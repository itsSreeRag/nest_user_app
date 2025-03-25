import 'package:flutter/material.dart';
import 'package:nest_user_app/controllers/auth_provider/auth_provider.dart';
import 'package:nest_user_app/views/auth/login_page/login_page_main.dart';

import 'package:provider/provider.dart';

class SignupPageBottom extends StatelessWidget {
  const SignupPageBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LogInPageMain()),
            );
          },
          child: const Text(
            'Already have an account? Log in',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 50),
        const Divider(thickness: 0.5, color: Colors.grey),
        const Text(
          'sign up using',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 20),
        Consumer<MyAuthProviders>(
          builder: (context, authProvider, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    authProvider.regUsingGoogleAcc(context);
                  },
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset('assets/icons/google_icon.png'),
                  ),
                ),
                // const SizedBox(width: 30),
                // SizedBox(
                //   width: 50,
                //   height: 50,
                //   child: Image.asset('assets/icons/facebook_icon.jpg'),
                // ),
              ],
            );
          },
        ),
      ],
    );
  }
}
