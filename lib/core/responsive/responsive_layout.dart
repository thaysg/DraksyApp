import 'package:flutter/material.dart';

import 'app_responsive.dart';

/// Types of devices based on screen width.
enum DeviceType {
  /// Mobile device (width < 600)
  mobile,

  /// Tablet device (600 <= width < 900)
  tablet,

  /// Desktop device (width >= 900)
  desktop,
}

/// A builder that provides the [DeviceType] to its children.
class ResponsiveLayoutBuilder extends StatelessWidget {
  /// Creates a responsive layout builder.
  const ResponsiveLayoutBuilder({
    required this.builder,
    super.key,
  });

  /// Builder function that provides the [DeviceType].
  final Widget Function(BuildContext context, DeviceType deviceType) builder;

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType;
    if (AppResponsive.isDesktop(context)) {
      deviceType = DeviceType.desktop;
    } else if (AppResponsive.isTablet(context)) {
      deviceType = DeviceType.tablet;
    } else {
      deviceType = DeviceType.mobile;
    }

    return builder(context, deviceType);
  }
}

/// Responsive layout widget that adapts to device size.
/// Shows different layouts for mobile, tablet, and desktop.
class ResponsiveLayout extends StatelessWidget {
  /// Creates a responsive layout widget
  const ResponsiveLayout({
    required this.mobile,
    super.key,
    this.tablet,
    this.desktop,
  });

  /// Mobile layout (width < 600)
  final Widget mobile;

  /// Tablet layout (600 <= width < 900)
  final Widget? tablet;

  /// Desktop layout (width >= 900)
  final Widget? desktop;

  @override
  Widget build(BuildContext context) => ResponsiveLayoutBuilder(
        builder: (context, deviceType) {
          switch (deviceType) {
            case DeviceType.desktop:
              return desktop ?? tablet ?? mobile;
            case DeviceType.tablet:
              return tablet ?? mobile;
            case DeviceType.mobile:
              return mobile;
          }
        },
      );
}
