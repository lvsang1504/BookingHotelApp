import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation(this.delay, this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AnimationType>()
      ..add(AnimationType.opacity, Tween(begin: 0.0, end: 1.0),
          const Duration(milliseconds: 500),)
      ..add(
        AnimationType.translateY,
        Tween(begin: 30.0, end: 1.0),
        const Duration(milliseconds: 500),
      );

    return PlayAnimation(
      delay: Duration(milliseconds: (900 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, MultiTweenValues<dynamic> animation) => Opacity(
        opacity: animation.get(AnimationType.opacity),
        child: Transform.translate(
            offset: Offset(0, animation.get(AnimationType.translateY)),
            child: child),
      ),
    );
  }
}

enum AnimationType { opacity, translateY }
