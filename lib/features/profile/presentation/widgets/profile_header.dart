import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/extensions/spacing.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_decorated_box.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/extensions/context_extension.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    required this.userName,
    required this.userTag,
    required this.level,
    required this.photo,
    super.key,
  });

  final String userName;
  final String userTag;
  final int level;
  final String photo;

  @override
  Widget build(BuildContext context) => SizedBox(
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
                    backgroundImage: photo.isNotEmpty
                        ? CachedNetworkImageProvider(photo)
                        : null,
                    backgroundColor: AppColors.surfaceContainerHighest(context),
                    child: photo.isEmpty
                        ? Image.asset(
                            AppImages.logo,
                            width: 75.r,
                            height: 75.r,
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
                userName,
                style: AppTextStyles.h3(context).copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              4.heightBox,
              Text(
                '$userTag \n${context.l10n.level(level)}',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium(context).copyWith(
                  color: AppColors.primaryAppColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              20.heightBox,
              SizedBox(
                width: 160.w,
                child: CustomButton(
                  text: context.l10n.editProfile,
                  onPressed: () => context.pushNamed(AppRoutes.editProfile),
                  type: ButtonType.outlined,
                  icon: Icons.edit_outlined,
                ),
              ),
            ],
          ),
        ),
      );
}
