import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nest_user_app/controllers/animation_provider/splash_screen_animation.dart';
import 'package:provider/provider.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final isAnimating = context.watch<SplashAnimationProvider>().isAnimating;

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 2000),
      tween: Tween(begin: 0.0, end: isAnimating ? 1.0 : 0.0),
      curve: Curves.easeIn,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Lottie.asset(
            'assets/animations/Glow loading.json',
            width: 100,
            height: 100,
            fit: BoxFit.fill,
          ),
        );
      },
    );
  }
}