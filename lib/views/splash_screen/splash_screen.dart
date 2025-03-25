import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/auth_provider/auth_provider.dart';
import 'package:nest_user_app/views/auth/login_page/login_page_main.dart';
import 'package:nest_user_app/views/home_screen/home_screen.dart';

import 'package:provider/provider.dart';

class MySplashScreen extends StatelessWidget {
  const MySplashScreen({super.key});

  void _navigateUser(BuildContext context) async {
    final authProvider = Provider.of<MyAuthProviders>(context, listen: false);
    bool isLoggedIn = await authProvider.checkUserLogin();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  isLoggedIn ? const MyHomeScreen() : const LogInPageMain(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.microtask(() => _navigateUser(context));

    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'Nest',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
