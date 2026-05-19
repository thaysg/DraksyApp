import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_decorated_box.dart';

class ProfilePhotoCard extends StatelessWidget {
  const ProfilePhotoCard({
    required this.isSelected,
    required this.isCamera,
    required this.isUploading,
    required this.avatarUrl,
    super.key,
  });

  final bool isSelected;
  final bool isCamera;
  final bool isUploading;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          SizedBox(
            width: 76.r,
            height: 76.r,
            child: CustomDecoratedBox(
              padding: const EdgeInsets.all(2),
              shape: BoxShape.circle,
              borderColor: isSelected ? AppColors.primaryAppColor : null,
              child: isCamera
                  ? CustomDecoratedBox(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.primaryAppColor,
                          AppColors.rpgOrange,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      child: isUploading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.surfaceLight,
                                strokeWidth: 3,
                              ),
                            )
                          : Icon(
                              Icons.camera_alt_rounded,
                              color: AppColors.surfaceLight,
                              size: 30.r,
                            ),
                    )
                  : CircleAvatar(
                      radius: 38.r,
                      backgroundImage: avatarUrl.isNotEmpty
                          ? CachedNetworkImageProvider(avatarUrl)
                          : null,
                      backgroundColor:
                          AppColors.surfaceContainerHighest(context),
                      child: avatarUrl.isEmpty
                          ? Image.asset(
                              AppImages.logo,
                              width: 40.r,
                              height: 40.r,
                            )
                          : null,
                    ),
            ),
          ),
          if (isSelected)
            Positioned(
              bottom: 0,
              right: 0,
              child: CustomDecoratedBox(
                padding: const EdgeInsets.all(4),
                shape: BoxShape.circle,
                color: AppColors.primaryAppColor,
                opacity: 1,
                child: Icon(
                  Icons.check_rounded,
                  color: AppColors.surfaceLight,
                  size: 12.r,
                ),
              ),
            ),
        ],
      );
}
