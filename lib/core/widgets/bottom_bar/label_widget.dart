import 'package:flutter/material.dart';

import '../../extensions/spacing.dart';
import 'bar_items.dart';

class LabelWidget extends StatelessWidget {
  const LabelWidget({
    required this.animation,
    required this.item,
    super.key,
  });

  final Animation<double> animation;
  final BottomBarItem item;

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.center,
        heightFactor: 1,
        child: FadeTransition(
          alwaysIncludeSemantics: true,
          opacity: animation,
          child: DefaultTextStyle.merge(
            style: TextStyle(
              fontSize: activeFontSize,
              fontWeight: FontWeight.w600,
              color: item.backgroundColor ?? item.selectedColor,
            ),
            child: item.title!,
          ),
        ),
      );
}
