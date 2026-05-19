import 'package:flutter/material.dart';

import '../../../../core/constants/dragon_assets.dart';

/// Animated dragon mascot widget that springs into view.
class DragonWidget extends StatefulWidget {
  const DragonWidget({
    required this.imageKey,
    required this.dragonColor, // e.g. 'Black', 'Blue', 'Orange'
    this.height = 180,
    super.key,
  });

  final String imageKey;
  final String dragonColor;
  final double height;

  @override
  State<DragonWidget> createState() => _DragonWidgetState();
}

class _DragonWidgetState extends State<DragonWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _scale = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _fade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.4, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(DragonWidget old) {
    super.didUpdateWidget(old);
    if (old.imageKey != widget.imageKey) {
      _controller.forward(from: 0); // replay spring on every card change
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _fade,
        child: ScaleTransition(
          scale: _scale,
          child: Image.asset(
            DragonAssets.resolve(widget.imageKey, widget.dragonColor),
            height: widget.height,
            fit: BoxFit.contain,
          ),
        ),
      );
}
