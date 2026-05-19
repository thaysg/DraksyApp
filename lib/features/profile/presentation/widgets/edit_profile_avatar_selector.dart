import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_decorated_box.dart';

class EditProfileAvatarSelector extends StatefulWidget {
  const EditProfileAvatarSelector({
    required this.photoUrl,
    super.key,
  });

  final String photoUrl;

  @override
  State<EditProfileAvatarSelector> createState() =>
      _EditProfileAvatarSelectorState();
}

class _EditProfileAvatarSelectorState extends State<EditProfileAvatarSelector> {
  late String selectedPhotoUrl;

  final List<String> presetAvatars = [
    'https://via.placeholder.com/150/FF69B4/FFFFFF?text=Avatar1',
    'https://via.placeholder.com/150/FF6B6B/FFFFFF?text=Avatar2',
    'https://via.placeholder.com/150/4ECDC4/FFFFFF?text=Avatar3',
    'https://via.placeholder.com/150/45B7D1/FFFFFF?text=Avatar4',
    'https://via.placeholder.com/150/FFA07A/FFFFFF?text=Avatar5',
  ];

  @override
  void initState() {
    super.initState();
    selectedPhotoUrl = widget.photoUrl;
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.profilePhoto,
            style: AppTextStyles.bodySmall(context).copyWith(
              color: AppColors.textSecondary(context),
              fontWeight: FontWeight.w700,
            ),
          ),
          12.heightBox,
          SizedBox(
            height: 120.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: presetAvatars.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPhotoUrl = presetAvatars[index];
                    });
                  },
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundImage:
                            CachedNetworkImageProvider(presetAvatars[index]),
                      ),
                      if (selectedPhotoUrl == presetAvatars[index])
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CustomDecoratedBox(
                            padding: const EdgeInsets.all(6),
                            shape: BoxShape.circle,
                            color: AppColors.primaryAppColor,
                            opacity: 1,
                            child: Icon(
                              Icons.check,
                              color: AppColors.surfaceLight,
                              size: 16.r,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}
