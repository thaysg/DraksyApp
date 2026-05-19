import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_decorated_box.dart';
import '../providers/profile_provider.dart';

class EditProfileHeader extends ConsumerWidget {
  const EditProfileHeader({
    required this.displayName,
    required this.username,
    required this.photoUrl,
    required this.level,
    super.key,
  });

  final String displayName;
  final String username;
  final String photoUrl;
  final int level;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final previewPhoto = ref.watch(profilePreviewPhotoProvider);
    final displayPhoto = previewPhoto ?? photoUrl;

    return SizedBox(
      width: context.screenWidth,
      child: CustomDecoratedBox(
        opacity: 1,
        padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 16.w),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 60.r,
                  backgroundImage: displayPhoto.isNotEmpty
                      ? CachedNetworkImageProvider(displayPhoto)
                      : null,
                  backgroundColor: AppColors.surfaceContainerHighest(context),
                  child: displayPhoto.isEmpty
                      ? Image.asset(
                          AppImages.logo,
                          width: 60.r,
                          height: 60.r,
                        )
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CustomDecoratedBox(
                    padding: const EdgeInsets.all(8),
                    shape: BoxShape.circle,
                    color: AppColors.primaryAppColor,
                    opacity: 1,
                    child: Icon(
                      Icons.auto_awesome,
                      color: AppColors.surfaceLight,
                      size: 20.r,
                    ),
                  ),
                ),
              ],
            ),
            16.heightBox,
            Text(
              displayName,
              style: AppTextStyles.h4(context).copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            4.heightBox,
            Text(
              '$username \n${context.l10n.level(level)}',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium(context).copyWith(
                color: AppColors.primaryAppColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
