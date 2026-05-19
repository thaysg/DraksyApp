import 'package:flutter/material.dart';

/// Simple fade in animation widget for draksy.
/// Uses [TweenAnimationBuilder] to be Stateless.
class FadeInWidget extends StatelessWidget {
  /// Creates a fade in widget
  const FadeInWidget({
    required this.child,
    super.key,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
  });

  /// Widget to animate
  final Widget child;

  /// Duration of the fade
  final Duration duration;

  /// Delay before starting the fade
  final Duration delay;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: duration,
        curve: Curves.easeIn,
        builder: (context, value, child) => Opacity(
          opacity: value,
          child: child,
        ),
        child: child,
      );
}
