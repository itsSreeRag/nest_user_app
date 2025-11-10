// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:nest_user_app/constants/colors.dart';
import 'package:nest_user_app/controllers/auth_provider/auth_provider.dart';
import 'package:nest_user_app/views/auth/signin_page/signin_page_main.dart';
import 'package:nest_user_app/views/navigation_bar/navigation_bar.dart';
import 'package:nest_user_app/views/splash_screen/widgets/splash_loading_indicator.dart';
import 'package:nest_user_app/views/splash_screen/widgets/splash_logo.dart';
import 'package:nest_user_app/views/splash_screen/widgets/splash_name.dart';
import 'package:provider/provider.dart';

class MySplashScreen extends StatelessWidget {
  const MySplashScreen({super.key});

  void navigateUser(BuildContext context) async {
    final authProvider = Provider.of<MyAuthProviders>(context, listen: false);
    bool isLoggedIn = await authProvider.checkUserLogin();

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  isLoggedIn ? const MyNavigationBar() : const SignInPageMain(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.microtask(() => navigateUser(context));

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
             AppColors.primary.withAlpha(200),
              AppColors.primary,
              AppColors.primary.withAlpha(200),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AnimatedLogo(),
              const SizedBox(height: 30),
              const AnimatedAppName(),
              const SizedBox(height: 10),
              const LoadingIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}


