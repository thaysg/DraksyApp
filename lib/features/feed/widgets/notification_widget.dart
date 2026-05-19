import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_decorated_box.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => CustomDecoratedBox(
        padding: EdgeInsets.all(10.r),
        color: AppColors.surfaceContainerHighest(context),
        shape: BoxShape.circle,
        child: Stack(
          children: [
            Icon(
              Icons.notifications_none_rounded,
              color: AppColors.textPrimary(context),
              size: 26.r,
            ),
            Positioned(
              right: 2,
              top: 2,
              child: SizedBox(
                width: 8.r,
                height: 8.r,
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.primaryAppColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
