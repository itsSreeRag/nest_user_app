import 'package:flutter/material.dart';
import 'package:nest_user_app/controllers/auth_provider/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginUsing extends StatelessWidget {
  const LoginUsing({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Column(
        children: [
          const Divider(thickness: 0.5, color: Colors.grey),
          const Text(
            'Log In using',
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
      ),
    );
  }
}
