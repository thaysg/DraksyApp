import 'package:flutter/material.dart';

import 'bar_items.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    required this.animation,
    required this.iconSize,
    required this.selected,
    required this.item,
    super.key,
  });

  final Animation<double> animation;
  final BottomBarItem item;
  final double iconSize;
  final bool selected;

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.center,
        child: Badge(
          isLabelVisible: item.showBadge,
          label: item.badge,
          backgroundColor: item.badgeColor,
          padding: item.badgePadding,
          child: IconTheme(
            data: IconThemeData(
              color: selected
                  ? item.backgroundColor ?? item.selectedColor
                  : item.unSelectedColor,
              size: iconSize,
            ),
            child: selected ? item.selectedIcon ?? item.icon : item.icon,
            // child: Padding(
            //   padding:
            //       item.showBadge ? const EdgeInsets.all(8.0)
            // : EdgeInsets.zero,
            //   child: selected ? item.selectedIcon ?? item.icon : item.icon,
            // ),
          ),
        ),
      );
}
