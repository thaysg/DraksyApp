import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../presentation/models/edit_profile_view_data.dart';
import '../../presentation/providers/profile_provider.dart';
import '../views/edit_profile_desktop_view.dart';
import '../views/edit_profile_mobile_view.dart';
import '../views/edit_profile_tablet_view.dart';
import '../widgets/edit_profile_loading.dart';
import '../widgets/edit_profile_title.dart';

class EditProfilePage extends ConsumerWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileViewProvider);
    final controllerState = ref.watch(profileControllerProvider);

    // Listen for success or error from the controller
    ref.listen(profileControllerProvider, (previous, next) {
      next.when(
        data: (data) {
          if (previous is AsyncLoading) {
            ref.read(profilePreviewPhotoProvider.notifier).url = null;
            context
              ..showSuccessSnackBar(context.l10n.profileUpdatedSuccess)
              ..pop();
          }
        },
        error: (error, st) {
          context.showErrorSnackBar(error.toString());
        },
        loading: () {},
      );
    });

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground(context),
      body: SafeArea(
        child: profileAsync.when(
          data: (profileData) {
            final editData = EditProfileViewData(
              displayName: profileData.userName,
              username: profileData.userTag,
              email: profileData.email,
              photoUrl: profileData.photo,
              bio: profileData.bio,
              level: profileData.level,
            );

            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const EditProfileTitle(),
                ResponsiveLayoutBuilder(
                  builder: (context, deviceType) => switch (deviceType) {
                    DeviceType.mobile => EditProfileMobileView(
                        data: editData,
                        isSaving: controllerState.isLoading,
                        onSave: ({
                          required displayName,
                          required photoUrl,
                          required bio,
                        }) =>
                            ref
                                .read(profileControllerProvider.notifier)
                                .editProfile(
                                  displayName: displayName,
                                  photoUrl: photoUrl,
                                  bio: bio,
                                ),
                      ),
                    DeviceType.tablet => EditProfileTabletView(
                        data: editData,
                        isSaving: controllerState.isLoading,
                        onSave: ({
                          required displayName,
                          required photoUrl,
                          required bio,
                        }) =>
                            ref
                                .read(profileControllerProvider.notifier)
                                .editProfile(
                                  displayName: displayName,
                                  photoUrl: photoUrl,
                                  bio: bio,
                                ),
                      ),
                    DeviceType.desktop => EditProfileDesktopView(
                        data: editData,
                        isSaving: controllerState.isLoading,
                        onSave: ({
                          required displayName,
                          required photoUrl,
                          required bio,
                        }) =>
                            ref
                                .read(profileControllerProvider.notifier)
                                .editProfile(
                                  displayName: displayName,
                                  photoUrl: photoUrl,
                                  bio: bio,
                                ),
                      ),
                  },
                ),
              ],
            );
          },
          loading: () => const EditProfileLoading(),
          error: (error, __) => Center(
            child: Text(
              error.toString(),
              style: AppTextStyles.error(context),
            ),
          ),
        ),
      ),
    );
  }
}
