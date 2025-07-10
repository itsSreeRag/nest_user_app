import 'package:flutter/material.dart';
import 'package:nest_user_app/controllers/animation_provider/home_animation.dart';
import 'package:provider/provider.dart';

class SlideFadeAnimation extends StatelessWidget {
  final Widget child;
  final Offset beginOffset;
  final Offset endOffset;
  final bool trigger;
  final Duration delay;
  final Duration duration;

  const SlideFadeAnimation({
    super.key,
    required this.child,
    this.beginOffset = const Offset(0, 0.2),
    this.endOffset = Offset.zero,
    required this.trigger,
    this.delay = const Duration(milliseconds: 500),
    this.duration = const Duration(milliseconds: 700),
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!trigger) {
        Future.delayed(delay, () {
          final animProvider = Provider.of<HomeAnimationProvider>(
            // ignore: use_build_context_synchronously
            context,
            listen: false,
          );
          animProvider.triggerAnimations();
        });
      }
    });

    return AnimatedOpacity(
      duration: duration,
      opacity: trigger ? 1 : 0,
      child: AnimatedSlide(
        duration: duration,
        offset: trigger ? endOffset : beginOffset,
        child: child,
      ),
    );
  }
}