import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' hide DeviceType;

import '../../../../../core/responsive/responsive_layout.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    required this.children,
    this.mobileCrossAxisCount = 1,
    this.tabletCrossAxisCount = 2,
    this.desktopCrossAxisCount = 3,
    this.mainAxisSpacing = 20.0,
    this.crossAxisSpacing = 20.0,
    this.desktopChildAspectRatio = 1.4,
    this.tabletChildAspectRatio = 1.2,
    this.mobileChildAspectRatio = 1.0,
    super.key,
  });

  final List<Widget> children;
  final int mobileCrossAxisCount;
  final int tabletCrossAxisCount;
  final int desktopCrossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double desktopChildAspectRatio;
  final double tabletChildAspectRatio;
  final double mobileChildAspectRatio;

  @override
  Widget build(BuildContext context) => ResponsiveLayoutBuilder(
        builder: (context, deviceType) {
          int crossAxisCount;
          double childAspectRatio;
          double mainSpacing;
          double crossSpacing;

          switch (deviceType) {
            case DeviceType.desktop:
              crossAxisCount = children.isEmpty
                  ? 1
                  : (children.length < desktopCrossAxisCount
                      ? children.length
                      : desktopCrossAxisCount);
              childAspectRatio = desktopChildAspectRatio;
              mainSpacing = mainAxisSpacing;
              crossSpacing = crossAxisSpacing;
            case DeviceType.tablet:
              crossAxisCount = tabletCrossAxisCount;
              childAspectRatio = tabletChildAspectRatio;
              mainSpacing = mainAxisSpacing.h;
              crossSpacing = crossAxisSpacing.w;
            case DeviceType.mobile:
              crossAxisCount = mobileCrossAxisCount;
              childAspectRatio = mobileChildAspectRatio;
              mainSpacing = mainAxisSpacing.h;
              crossSpacing = crossAxisSpacing.w;
          }

          return GridView.count(
            crossAxisCount: crossAxisCount,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: mainSpacing,
            crossAxisSpacing: crossSpacing,
            childAspectRatio: childAspectRatio,
            children: children,
          );
        },
      );
}
