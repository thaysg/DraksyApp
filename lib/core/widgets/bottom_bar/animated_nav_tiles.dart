import 'package:flutter/material.dart';

import '../../extensions/spacing.dart';
import '../../theme/app_colors.dart';
import 'bar_items.dart';
import 'enums_bottom_bar.dart';
import 'water_drop.dart';

class AnimatedNavigationTiles extends StatelessWidget {
  const AnimatedNavigationTiles(
    this.items,
    this.iconSize, {
    required this.selected,
    required this.opacity,
    required this.barAnimation,
    required this.iconStyle,
    super.key,
    this.padding,
    this.onTap,
    this.inkEffect,
    this.inkColor,
    this.animation,
    this.flex,
    this.indexLabel,
  });

  final BottomBarItem items;

  ///Icon size
  final double iconSize;

  ///onTap gesture event
  final VoidCallback? onTap;

  final bool? inkEffect;
  final Color? inkColor;
  final bool selected;
  final EdgeInsets? padding;

  ///Background color opacity
  final double opacity;
  final double? flex;
  final String? indexLabel;
  final Animation<double>? animation;
  final BarAnimation barAnimation;

  ///icon style of the bottom bar items
  ///[IconStyle.Default]
  ///[IconStyle.animated]
  ///[IconStyle.simple]
  final IconStyle iconStyle;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Semantics(
          container: true,
          header: true,
          selected: selected,
          child: Padding(
            padding: padding ?? const EdgeInsets.only(top: 6),
            child: InkWell(
              onTap: onTap,
              splashColor: inkEffect! ? inkColor : AppColors.transparent,
              highlightColor: AppColors.transparent,
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(52),
                left: Radius.circular(52),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _getBarItems(),
                ),
              ),
            ),
          ),
        ),
      );

  List<Widget> _getBarItems() {
    if (barAnimation == BarAnimation.liquid) {
      return _liquidItems();
    } else if (barAnimation == BarAnimation.drop) {
      return _dropItems();
    } else {
      return _childItems();
    }
  }

  Color get itemColor =>
      items.backgroundColor ??
      (selected ? items.selectedColor : items.unSelectedColor);
  Color get itemColorOnSelected => items.backgroundColor ?? items.selectedColor;

  List<Widget> _defaultItems() {
    final label = LabelWidget(
      iconStyle: iconStyle,
      animation: animation!,
      item: items,
      color: itemColor,
      selected: selected,
    );
    return [
      Align(
        alignment: Alignment.center,
        child: Badge(
          label: items.badge,
          isLabelVisible: items.showBadge,
          backgroundColor: items.badgeColor,
          padding: items.badgePadding,
          child: IconTheme(
            data: IconThemeData(
              color: itemColor,
              size: iconSize,
              // size: selected ? iconSize + 4 : iconSize,
            ),
            child: selected ? items.selectedIcon ?? items.icon : items.icon,
          ),
        ),
      ),
      const SizedBox(height: 2),
      label,
    ];
  }

  List<Widget> _liquidItems() {
    final label = LabelWidget(
      iconStyle: iconStyle,
      animation: animation!,
      item: items,
      color: itemColor,
      selected: selected,
    );
    return [
      Badge(
        label: items.badge,
        isLabelVisible: items.showBadge,
        backgroundColor: items.badgeColor,
        padding: items.badgePadding,
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
                size: iconSize,
              ),
              child: selected ? items.selectedIcon ?? items.icon : items.icon,
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
          height: 20,
          width: 22,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: itemColorOnSelected,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.elliptical(12, 20),
                topRight: Radius.elliptical(12, 20),
              ),
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

  List<Widget> _childItems() {
    final label = LabelWidget(
      iconStyle: iconStyle,
      animation: animation!,
      item: items,
      color: itemColor,
      selected: selected,
    );

    return iconStyle == IconStyle.Default
        ? _defaultItems()
        : iconStyle == IconStyle.animated
            ? [
                Badge(
                  label: items.badge,
                  isLabelVisible: items.showBadge,
                  backgroundColor: items.badgeColor,
                  padding: items.badgePadding,
                  child: IconWidget(
                    item: items,
                    selected: selected,
                    iconSize: iconSize,
                    barAnimation: barAnimation,
                  ),
                ),
                const SizedBox(height: 2),
                label,
              ]
            : [
                Align(
                  alignment: Alignment.center,
                  child: Badge(
                    label: items.badge,
                    isLabelVisible: items.showBadge,
                    backgroundColor: items.badgeColor,
                    padding: items.badgePadding,
                    child: IconTheme(
                      data: IconThemeData(
                        color: itemColor,
                        size: selected ? iconSize + 4 : iconSize,
                      ),
                      child: selected
                          ? items.selectedIcon ?? items.icon
                          : items.icon,
                    ),
                  ),
                ),
              ];
  }

  List<Widget> _dropItems() => [
        Badge(
          label: items.badge,
          isLabelVisible: items.showBadge,
          backgroundColor: items.badgeColor,
          padding: items.badgePadding,
          alignment: const Alignment(0.17, -1),
          child: AnimatedCrossFade(
            firstChild: Align(
              alignment: Alignment.center,
              child: IconTheme(
                data: IconThemeData(
                  color: itemColor,
                  size: iconSize,
                ),
                // child: selected && items.selectedIcon != null
                //     ? items.selectedIcon!
                //     : items.icon,
                child: selected ? items.selectedIcon ?? items.icon : items.icon,
              ),
            ),
            secondChild: Align(
              alignment: Alignment.center,
              child: WaterDrop(
                top: 0,
                color: items.backgroundColor,
                width: 48,
                height: 48,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: IconTheme(
                    data: IconThemeData(
                      color: itemColor,
                      size: iconSize,
                    ),
                    child: selected && items.selectedIcon != null
                        ? items.selectedIcon!
                        : items.icon,
                  ),
                ),
              ),
            ),
            duration: const Duration(milliseconds: 300),
            sizeCurve: Curves.linear,
            firstCurve: Curves.ease,
            secondCurve: Curves.fastOutSlowIn.flipped,
            crossFadeState:
                selected ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          ),
        )
      ];
}

class LabelWidget extends StatelessWidget {
  const LabelWidget({
    required this.animation,
    required this.item,
    required this.color,
    required this.iconStyle,
    required this.selected,
    super.key,
  });

  final Animation<double> animation;
  final BottomBarItem item;
  final Color color;
  final IconStyle iconStyle;
  final bool selected;

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.center,
        heightFactor: 1,
        child: DefaultTextStyle.merge(
          style: TextStyle(
            fontSize: activeFontSize,
            fontWeight: selected ? FontWeight.bold : FontWeight.w600,
            color: color,
          ),
          child: item.title!,
        ),
      );
}

class IconWidget extends StatefulWidget {
  const IconWidget({
    required this.item,
    required this.selected,
    required this.iconSize,
    required this.barAnimation,
    super.key,
  });

  final BottomBarItem item;
  final bool selected;
  final double iconSize;
  final BarAnimation barAnimation;

  @override
  State<IconWidget> createState() => _IconWidgetState();
}

class _IconWidgetState extends State<IconWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  late Animation<Color?> animationColor;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() {
    if (widget.barAnimation != BarAnimation.transform3D) {
      controller = AnimationController(
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 300),
        vsync: this,
      );
    }
    _assignAnimation();
  }

  @override
  void dispose() {
    if (widget.barAnimation != BarAnimation.transform3D) {
      controller?.dispose();
    }
    super.dispose();
  }

  void _assignAnimation() {
    if (widget.barAnimation != BarAnimation.transform3D) {
      if (widget.barAnimation == BarAnimation.blink) {
        animation =
            CurvedAnimation(parent: controller!, curve: Curves.bounceIn);
      } else {
        animation = CurvedAnimation(parent: controller!, curve: Curves.ease);
      }

      animationColor = ColorTween(
        begin: widget.item.backgroundColor ?? widget.item.unSelectedColor,
        end: widget.item.selectedColor,
      ).animate(animation)
        ..addListener(() {
          setState(() {});
        });
    }
  }

  void _playAnimation() {
    if (widget.barAnimation != BarAnimation.transform3D) {
      widget.selected ? controller?.forward() : controller?.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      _init();
    }
    // _assignAnimation();
    _playAnimation();

    return _buildWidget();
  }

  IconTheme _buildWidget() => IconTheme(
        data: IconThemeData(
          color: widget.item.backgroundColor ??
              (widget.selected
                  ? widget.barAnimation == BarAnimation.transform3D
                      ? widget.item.selectedColor
                      : animationColor.value
                  : widget.item.unSelectedColor),
          size: widget.selected ? widget.iconSize + 4 : widget.iconSize,
        ),
        child: widget.selected
            ? widget.barAnimation == BarAnimation.transform3D
                ? Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 0, 0.002)
                      ..rotateY(0), //..rotateY(0),
                    child: widget.item.selectedIcon ?? widget.item.icon,
                  )
                : widget.item.selectedIcon ?? widget.item.icon
            : widget.item.icon,
      );
}
