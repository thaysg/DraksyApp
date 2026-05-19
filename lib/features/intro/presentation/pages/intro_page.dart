import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/intro_providers.dart';
import '../views/intro_desktop_view.dart';
import '../views/intro_mobile_view.dart';
import '../views/intro_tablet_view.dart';

class IntroPage extends ConsumerWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(introViewProvider);
    final controller = ref.watch(pageControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.primaryAppColor,
      body: SafeArea(
        child: ResponsiveLayoutBuilder(
          builder: (context, deviceType) {
            Future<void> onComplete() async {
              await ref.read(introIndexProvider.notifier).completeOnboarding();
            }

            void onNext() =>
                ref.read(introIndexProvider.notifier).next(controller);
            void onPrevious() =>
                ref.read(introIndexProvider.notifier).previous(controller);
            dynamic onIndexChanged(index) =>
                ref.read(introIndexProvider.notifier).index = index;

            return switch (deviceType) {
              DeviceType.mobile => IntroMobileView(
                  data: data,
                  controller: controller,
                  onCompleteOnboarding: onComplete,
                  onNext: onNext,
                  onPrevious: onPrevious,
                  onIndexChanged: onIndexChanged,
                ),
              DeviceType.tablet => IntroTabletView(
                  data: data,
                  controller: controller,
                  onCompleteOnboarding: onComplete,
                  onNext: onNext,
                  onPrevious: onPrevious,
                  onIndexChanged: onIndexChanged,
                ),
              DeviceType.desktop => IntroDesktopView(
                  data: data,
                  controller: controller,
                  onCompleteOnboarding: onComplete,
                  onNext: onNext,
                  onPrevious: onPrevious,
                  onIndexChanged: onIndexChanged,
                ),
            };
          },
        ),
      ),
    );
  }
}
