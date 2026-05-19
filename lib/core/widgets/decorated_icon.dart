import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_decorated_box.dart';

class DecoratedIcon extends StatelessWidget {
  const DecoratedIcon({
    required this.icon,
    required this.color,
    super.key,
    this.iconColor,
    this.size,
  });

  final IconData icon;
  final Color color;
  final Color? iconColor;
  final double? size;

  @override
  Widget build(BuildContext context) => CustomDecoratedBox(
        shape: BoxShape.circle,
        padding: const EdgeInsets.all(8),
        opacity: 0.2,
        color: color,
        child: Icon(
          icon,
          color: iconColor ?? color,
          size: size ?? 20.r,
        ),
      );
}
