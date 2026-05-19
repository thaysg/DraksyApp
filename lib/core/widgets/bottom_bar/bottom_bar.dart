import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../extensions/context_extension.dart';
import '../../extensions/spacing.dart';
import '../../theme/app_colors.dart';
import 'animated_nav_tiles.dart';
import 'bar_clipper.dart';
import 'bar_items.dart' show BottomBarItem;
import 'bubble_navigation_tile.dart';
import 'dot_nav_tile.dart';
import 'enums_bottom_bar.dart';
import 'options.dart'
    show AnimatedBarOptions, BubbleBarOptions, BottomBarOption, DotBarOptions;

///[StylishBottomBar] class to implement beautiful bottom bar widget
///
///```dart
///
/// StylishBottomBar(
///   items: [
///     BottomBarItem(
///       icon: Icon(
///               Icons.home,
///         ),
///       selectedColor: Colors.deepPurple,
///       backgroundColor: Colors.amber,
///       title: Text('Home')),
///     BottomBarItem(
///       icon: Icon(
///               Icons.add_circle_outline,
///         ),
///       selectedColor: Colors.green,
///       backgroundColor: Colors.amber,
///       title: Text('Add')),
///     BottomBarItem(
///       icon: Icon(
///               Icons.person,
///         ),
///       backgroundColor: Colors.amber,
///       selectedColor: Colors.pinkAccent,
///       title: Text('Profile')),
///    ],
///    option: AnimatedBarOptions(
///        iconStyle: IconStyle.animated,
///        barAnimation: BarAnimation.liquid,
///        opacity: 0.3,
///    ),
///    onTap: (index) {
///        setState(() {
///            selected = index;
///        });
///    },
///
///  );
///
///```
class StylishBottomBar extends StatefulWidget {
  StylishBottomBar({
    required this.items,
    required this.option,
    super.key,
    this.backgroundColor,
    this.elevation = 8.0,
    this.currentIndex = 0,
    this.onTap,
    this.borderRadius,
    this.fabLocation,
    this.hasNotch = false,
    this.gradient,
    this.iconSpace = 1.5,
    this.notchStyle = NotchStyle.themeDefault,
  })  : assert(items.length >= 2,
            '\n\nStylish Bottom Navigation must have 2 or more items'),
        assert(
          items.every((item) => item.title != null),
          '\n\nEvery item must have a non-null title',
        ),
        assert(
            currentIndex < items.length,
            '\n\nCurrent index is out of bond. Provided: $currentIndex  '
            'Bond: 0 to ${items.length - 1}'),
        assert(
            currentIndex >= 0,
            '\n\nCurrent index is out of bond. Provided: $currentIndex '
            ' Bond: 0 to ${items.length - 1}');

  ///Add navigation bar items
  ///[BottomBarItem]
  ///
  ///You can use `BottomBarItem` class to add navigation bar items
  final List<BottomBarItem> items;

  ///Change animated navigation bar background color
  final Color? backgroundColor;

  ///Add elevation to bottom navigation bar
  ///
  ///Default value is 8.0
  final double elevation;

  ///Used to change the selected item index
  ///
  /// Default value is 0
  final int currentIndex;

  ///Add notch effect to floating action button
  ///
  ///to make floating action button notch transparent set extendBody to true
  /// in scaffold
  ///
  ///```dart
  ///  return Scaffold(
  ///     extendBody: true
  ///
  ///   ...
  ///   );
  ///```
  final bool hasNotch;

  ///Function to return current selected item index
  ///
  ///```dart
  /// onTap: (index){
  ///
  /// },
  ///
  ///```
  final ValueChanged<int>? onTap;

  ///Change navigation bar border radius
  final BorderRadius? borderRadius;

  ///Adjust bubble navigation items according to the fab location
  ///
  ///You can change Fab Location [StylishBarFabLocation.center]
  ///
  ///and [StylishBarFabLocation.end]
  final StylishBarFabLocation? fabLocation;

  /// Customize bottom bar items style and other properties
  ///
  /// You can use
  /// [AnimatedBarOptions] and [BubbleBarOptions]
  /// to change the properties.
  final BottomBarOption option;

  /// The gradient property defines a gradient color pattern for the widget.
  /// The gradient can be used to add a colorful background or add gradient
  /// colors to the widget.
  /// The gradient is defined using the [Gradient] class, which provides
  /// various options to specify the gradient colors and direction.
  /// Example usage:
  /// ```dart
  /// final gradient = LinearGradient(
  ///   colors: [Colors.red, Colors.yellow],
  ///   begin: Alignment.topLeft,
  ///   end: Alignment.bottomRight,
  /// );
  /// ```
  final Gradient? gradient;

  ///Assign icon sapce;
  final double iconSpace;

  /// Specify the notch style
  ///
  /// [NotchStyle.circle]
  ///
  /// [NotchStyle.square] * Similar to material3
  ///
  /// [NotchStyle.themeDefault] * Depends on the
  ///  `Theme.of(context).useMaterial3`
  final NotchStyle notchStyle;

  @override
  State<StylishBottomBar> createState() => _StylishBottomBarState();
}

class _StylishBottomBarState extends State<StylishBottomBar>
    with TickerProviderStateMixin {
  List<AnimationController> _controllers = <AnimationController>[];
  late List<CurvedAnimation> _animations;
  Color? _backgroundColor;

  late ValueListenable<ScaffoldGeometry> _geometryListenable;
  late Animatable<double> _flexTween;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _geometryListenable = Scaffold.geometryOf(context);
    _flexTween = widget.hasNotch
        ? Tween<double>(begin: 1.15, end: 2)
        : Tween<double>(begin: 1.15, end: 1.75);
  }

  void _state() {
    for (final controller in _controllers) {
      controller.dispose();
    }

    _controllers = List<AnimationController>.generate(
        widget.items.length,
        (index) => AnimationController(
              duration: const Duration(milliseconds: 200),
              vsync: this,
            )..addListener(() {
                if (widget.option is BubbleBarOptions) {
                  setState(() {});
                }
              }));
    _animations = List<CurvedAnimation>.generate(
        widget.items.length,
        (index) => CurvedAnimation(
              parent: _controllers[index],
              curve: Curves.fastOutSlowIn,
              reverseCurve: Curves.fastOutSlowIn.flipped,
            ));
    _controllers[widget.currentIndex].value = 1.0;
    _backgroundColor = widget.items[widget.currentIndex].backgroundColor;
  }

  @override
  void initState() {
    super.initState();
    _state();
  }

  @override
  void dispose() {
    ///Dispose controllers
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  double _evaluateFlex(Animation<double> animation) =>
      _flexTween.evaluate(animation);

  @override
  void didUpdateWidget(StylishBottomBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.items.length != oldWidget.items.length) {
      _state();
      return;
    }

    if (widget.currentIndex != oldWidget.currentIndex) {
      _controllers[oldWidget.currentIndex].reverse();
      _controllers[widget.currentIndex].forward();

      if (widget.fabLocation == StylishBarFabLocation.center) {
        _controllers[oldWidget.currentIndex].reverse();
        _controllers[widget.currentIndex].forward();
        _state();
      }
    } else {
      if (_backgroundColor !=
          widget.items[widget.currentIndex].backgroundColor) {
        _backgroundColor = widget.items[widget.currentIndex].backgroundColor;
      }
    }
  }

  bool getStyle() => widget.notchStyle == NotchStyle.themeDefault
      ? context.theme.useMaterial3
      : widget.notchStyle == NotchStyle.square;

  @override
  Widget build(BuildContext context) {
    double additionalBottomPadding = 0;
    var listWidget = <Widget>[];

    final mediaQuery = MediaQuery.of(context);
    final option = widget.option;

    if (option is AnimatedBarOptions) {
      additionalBottomPadding =
          math.max(mediaQuery.padding.bottom - bottomMargin, 0) + 2;
      listWidget = _animatedBarChilds();
    } else if (option is BubbleBarOptions) {
      additionalBottomPadding =
          math.max(mediaQuery.padding.bottom - bottomMargin, 0) + 4;
      listWidget = _bubbleBarTiles();
    } else if (option is DotBarOptions) {
      additionalBottomPadding =
          math.max(mediaQuery.padding.bottom - bottomMargin, 0) + 4;
      listWidget = _dotBarChilds();
    }

    final isUsingMaterial3 = getStyle();

    final barHeight = 64.0 + 8.0 + (additionalBottomPadding > 0 ? 12.0 : 8.0);

    final hostShape = RoundedRectangleBorder(
      borderRadius: widget.borderRadius ?? BorderRadius.zero,
    );

    final guestShape = isUsingMaterial3
        ? const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
          )
        : const CircleBorder();

    return SizedBox(
      height: barHeight,
      child: Semantics(
        explicitChildNodes: true,
        child: widget.hasNotch
            ? Builder(builder: (context) {
                final notchShape = AutomaticNotchedShape(hostShape, guestShape);
                return PhysicalShape(
                  elevation: widget.elevation,
                  color: widget.backgroundColor ?? AppColors.surfaceLight,
                  clipper: BarClipper(
                    shape: notchShape,
                    geometry: _geometryListenable,
                    notchMargin: 6,
                  ),
                  child: ClipPath(
                    clipper: BarClipper(
                      shape: notchShape,
                      geometry: _geometryListenable,
                      notchMargin: 6,
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: widget.borderRadius,
                        gradient: widget.gradient,
                        color: widget.backgroundColor ?? AppColors.surfaceLight,
                      ),
                      child: _innerWidget(
                        context,
                        additionalBottomPadding,
                        widget.fabLocation,
                        listWidget,
                        option is AnimatedBarOptions
                            ? option.barAnimation
                            : null,
                      ),
                    ),
                  ),
                );
              })
            : Material(
                elevation: widget.elevation,
                borderRadius: widget.borderRadius,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: widget.borderRadius,
                    gradient: widget.gradient,
                    color: widget.backgroundColor ?? AppColors.surfaceLight,
                  ),
                  child: _innerWidget(
                      context,
                      additionalBottomPadding + 2,
                      widget.fabLocation,
                      listWidget,
                      option is AnimatedBarOptions
                          ? option.barAnimation
                          : null),
                ),
              ),
      ),
    );
  }

  List<Widget> _bubbleBarTiles() {
    final localizations = MaterialLocalizations.of(context);
    final list = <Widget>[];

    final options = widget.option as BubbleBarOptions;

    list.addAll(List.generate(
        widget.items.length,
        (i) => BubbleNavigationTile(
              widget.items[i],
              options.opacity!,
              _animations[i],
              options.iconSize,
              options.barStyle,
              onTap: () {
                if (widget.onTap != null) {
                  widget.onTap!(i);
                }
              },
              selected: i == widget.currentIndex,
              flex: _evaluateFlex(_animations[i]),
              indexLabel: localizations.tabLabel(
                  tabIndex: i + 1, tabCount: widget.items.length),
              ink: options.inkEffect,
              inkColor: options.inkColor,
              padding: options.padding,
              fillStyle: options.bubbleFillStyle,
              itemBorderRadius: options.borderRadius,
            )));

    if (widget.fabLocation == StylishBarFabLocation.center) {
      list.insert(
          1,
          const Spacer(
            flex: 1500,
          ));
    }
    return list;
  }

  List<Widget> _animatedBarChilds() {
    final list = <Widget>[];
    final localizations = MaterialLocalizations.of(context);

    final options = widget.option as AnimatedBarOptions;

    list.addAll(
      List.generate(
          widget.items.length,
          (i) => AnimatedNavigationTiles(
                widget.items[i],
                options.iconSize,
                padding: options.padding,
                inkEffect: options.inkEffect,
                inkColor: options.inkColor,
                selected: widget.currentIndex == i,
                opacity: options.opacity!,
                animation: _animations[i],
                barAnimation: options.barAnimation,
                iconStyle: options.iconStyle ?? IconStyle.Default,
                onTap: () {
                  if (widget.onTap != null) {
                    widget.onTap!(i);
                  }
                },
                flex: _evaluateFlex(_animations[i]),
                indexLabel: localizations.tabLabel(
                    tabIndex: i + 1, tabCount: widget.items.length),
              )),
    );

    insertSpace(list);

    return list;
  }

  List<Widget> insertSpace(List<Widget> list) {
    if (widget.fabLocation == StylishBarFabLocation.center) {
      if (list.length == 2) {
        list.insert(1, const Spacer()); // One at start, one at end
      } else if (list.length == 3) {
        list
          ..insert(2, const Spacer(flex: 1)) // Push second item towards FAB
          ..insert(4, const Spacer()); // Minimal spacing after FAB
      } else if (list.length == 4) {
        list.insert(2, const Spacer()); // Two before, two after FAB
      }
    }
    return list;
  }

  List<Widget> _dotBarChilds() {
    final list = <Widget>[];
    final localizations = MaterialLocalizations.of(context);

    final options = widget.option as DotBarOptions;

    list.addAll(
      List.generate(
          widget.items.length,
          (i) => DotNavigationTiles(
                widget.items[i],
                selected: widget.currentIndex == i,
                animation: _animations[i],
                options: options,
                onTap: () {
                  if (widget.onTap != null) {
                    widget.onTap!(i);
                  }
                },
                flex: _evaluateFlex(_animations[i]),
                indexLabel: localizations.tabLabel(
                    tabIndex: i + 1, tabCount: widget.items.length),
              )),
    );

    insertSpace(list);
    return list;
  }

  Widget _innerWidget(
    BuildContext context,
    double additionalBottomPadding,
    StylishBarFabLocation? fabLocation,
    List<Widget> childs, [
    BarAnimation? barAnimation,
  ]) =>
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: 64.0 + (additionalBottomPadding > 0 ? 12.0 : 0.0)),
          child: Material(
            type: MaterialType.transparency,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 8,
                  bottom: barAnimation == BarAnimation.liquid
                      ? 0
                      : (additionalBottomPadding > 0 ? 12.0 : 8.0),
                  right: fabLocation == StylishBarFabLocation.end ? 72 : 0),
              child: MediaQuery.removePadding(
                context: context,
                removeBottom: true,
                child: DefaultTextStyle.merge(
                  overflow: TextOverflow.ellipsis,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: childs,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
