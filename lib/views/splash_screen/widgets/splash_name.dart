import 'package:flutter/material.dart';
import 'package:nest_user_app/controllers/animation_provider/splash_screen_animation.dart';
import 'package:provider/provider.dart';

class AnimatedAppName extends StatelessWidget {
  const AnimatedAppName({super.key});

  @override
  Widget build(BuildContext context) {
    final isAnimating = context.watch<SplashAnimationProvider>().isAnimating;

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1500),
      tween: Tween(begin: 0.0, end: isAnimating ? 1.0 : 0.0),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: Column(
              children: [
                Text(
                  'Find Your Perfect Rooms',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
