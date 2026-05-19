import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

/// A bottom sheet to select the image source (camera or gallery).
class AvatarSourceSheet extends StatelessWidget {
  const AvatarSourceSheet({required this.onSourceSelected, super.key});

  // Future<void> instead of ValueChanged — the callback is async
  // (it uploads the image) and must be awaited to avoid swallowing errors.
  final Future<void> Function(ImageSource) onSourceSelected;

  static Future<void> show(
    BuildContext context, {
    required Future<void> Function(ImageSource) onSourceSelected,
  }) =>
      showModalBottomSheet<void>(
        context: context,
        backgroundColor: AppColors.surface(context),
        showDragHandle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        builder: (context) =>
            AvatarSourceSheet(onSourceSelected: onSourceSelected),
      );

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSourceItem(
                context,
                icon: Icons.image_rounded,
                title: context.l10n.gallery,
                subtitle: context.l10n.galleryDescription,
                onTap: () async {
                  context.pop();
                  await onSourceSelected(ImageSource.gallery);
                },
              ),
              SizedBox(height: 12.h),
              _buildSourceItem(
                context,
                icon: Icons.camera_alt_rounded,
                title: context.l10n.camera,
                subtitle: context.l10n.cameraDescription,
                onTap: () async {
                  context.pop();
                  await onSourceSelected(ImageSource.camera);
                },
              ),
            ],
          ),
        ),
      );

  Widget _buildSourceItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) =>
      InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: AppColors.primaryAppColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  icon,
                  color: AppColors.primaryAppColor,
                  size: 24.r,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.bodyMedium(context).copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: AppTextStyles.bodySmall(context).copyWith(
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textSecondary(context),
                size: 24.r,
              ),
            ],
          ),
        ),
      );
}
