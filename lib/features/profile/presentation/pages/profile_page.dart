import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/widgets/error_retry_widget.dart';
import '../providers/profile_provider.dart';
import '../views/profile_desktop_view.dart';
import '../views/profile_mobile_view.dart';
import '../views/profile_tablet_view.dart';
import '../widgets/profile_loading.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileViewAsync = ref.watch(profileViewProvider);

    // Listen for errors from the controller
    ref.listen(profileControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, st) {
          context.showErrorSnackBar(error.toString());
        },
      );
    });

    return Scaffold(
      body: SafeArea(
        child: profileViewAsync.when(
          data: (data) => ResponsiveLayoutBuilder(
            builder: (context, deviceType) => switch (deviceType) {
              DeviceType.mobile => ProfileMobileView(
                  data: data,
                  onLogout: () =>
                      ref.read(profileControllerProvider.notifier).logout(),
                  onDeleteAccount: () => ref
                      .read(profileControllerProvider.notifier)
                      .confirmAndDeleteAccount(context),
                ),
              DeviceType.tablet => ProfileTabletView(
                  data: data,
                  onLogout: () =>
                      ref.read(profileControllerProvider.notifier).logout(),
                  onDeleteAccount: () => ref
                      .read(profileControllerProvider.notifier)
                      .confirmAndDeleteAccount(context),
                ),
              DeviceType.desktop => ProfileDesktopView(
                  data: data,
                  onLogout: () =>
                      ref.read(profileControllerProvider.notifier).logout(),
                  onDeleteAccount: () => ref
                      .read(profileControllerProvider.notifier)
                      .confirmAndDeleteAccount(context),
                ),
            },
          ),
          loading: () => const ProfileLoading(),
          error: (error, __) => ErrorRetryWidget(
            error: error.toString(),
            onRetry: () => ref.refresh(profileViewProvider),
          ),
        ),
      ),
    );
  }
}
