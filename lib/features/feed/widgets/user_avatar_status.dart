import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/user_avatar.dart';
import '../presentation/models/feed_view_data.dart';

class UserAvatarStatus extends StatelessWidget {
  const UserAvatarStatus({
    required this.data,
    super.key,
  });

  final FeedActivityData data;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          UserAvatar(
            photoUrl: data.userPhotoUrl,
            radius: 25,
          ),
          if (data.isOnline)
            Positioned(
              bottom: 2,
              right: 2,
              child: SizedBox(
                width: 12.r,
                height: 12.r,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.background(context),
                      width: 2.r,
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
}
