import 'package:flutter/material.dart';

import 'bar_items.dart';
import 'enums_bottom_bar.dart';
import 'label_widget.dart';
import 'options.dart';

class DotNavigationTiles extends StatelessWidget {
  const DotNavigationTiles(
    this.item, {
    required this.selected,
    required this.options,
    super.key,
    this.onTap,
    this.animation,
    this.flex,
    this.indexLabel,
  });

  final DotBarOptions options;

  final BottomBarItem item;

  ///onTap gesture event
  final VoidCallback? onTap;

  final bool selected;

  final double? flex;
  final String? indexLabel;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Semantics(
          enabled: selected,
          container: true,
          header: true,
          label: indexLabel,
          selected: selected,
          child: Padding(
            padding: options.padding ??
                (item.showBadge
                    ? const EdgeInsets.only(
                        top: 6,
                      )
                    : EdgeInsets.zero),
            child: IgnorePointer(
              ignoring: selected,
              child: InkWell(
                onTap: onTap,
                splashColor:
                    options.inkEffect ? options.inkColor : Colors.transparent,
                highlightColor: Colors.transparent,
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(52),
                  left: Radius.circular(52),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: selected
                      ? MainAxisAlignment.spaceEvenly
                      : MainAxisAlignment.center,
                  children: _dotItems(),
                ),
              ),
            ),
          ),
        ),
      );

  Color get itemColor =>
      item.backgroundColor ??
      (selected ? item.selectedColor : item.unSelectedColor);
  Color get itemColorOnSelected => item.backgroundColor ?? item.selectedColor;

  Widget get iconChild => selected ? item.selectedIcon ?? item.icon : item.icon;

  List<Widget> _dotItems() {
    final label = LabelWidget(
      animation: animation!,
      item: item,
    );
    return [
      Badge(
        label: item.badge,
        isLabelVisible: item.showBadge,
        backgroundColor: item.badgeColor,
        padding: item.badgePadding,
        alignment: const Alignment(0.175, -1),
        child: AnimatedCrossFade(
          firstChild: Padding(
            padding: const EdgeInsets.all(6),
            child: label,
          ),
          secondChild: Align(
            alignment: Alignment.center,
            child: IconTheme(
              data: IconThemeData(
                color: itemColor,
                size: options.iconSize,
              ),
              child: iconChild,
            ),
          ),
          duration: const Duration(milliseconds: 600),
          sizeCurve: Curves.fastOutSlowIn,
          firstCurve: Curves.fastOutSlowIn,
          secondCurve: Curves.fastOutSlowIn.flipped,
          crossFadeState:
              selected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
      ),
      AnimatedCrossFade(
        firstChild: const SizedBox(),
        secondChild: SizedBox(
          height: 8,
          width: options.dotStyle == DotStyle.circle ? 8 : 16,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: itemColorOnSelected,
              borderRadius: BorderRadius.circular(4),
              gradient: options.gradient,
            ),
          ),
        ),
        duration: const Duration(milliseconds: 300),
        sizeCurve: Curves.linear,
        firstCurve: Curves.fastOutSlowIn,
        secondCurve: Curves.fastOutSlowIn.flipped,
        crossFadeState:
            selected ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      ),
    ];
  }
}
