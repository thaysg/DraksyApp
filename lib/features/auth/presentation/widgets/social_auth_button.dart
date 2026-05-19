import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_decorated_box.dart';

class SocialAuthButton extends StatelessWidget {
  const SocialAuthButton({
    required this.onPressed,
    super.key,
    this.icon,
    this.assetIcon,
  });

  final IconData? icon;
  final String? assetIcon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(15.r),
        child: CustomDecoratedBox(
          color: AppColors.primaryDark,
          opacity: 0.1,
          borderRadius: BorderRadius.circular(15.r),
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Center(
            child: icon != null
                ? Icon(
                    icon,
                    color: AppColors.textPrimaryDark,
                    size: 24.r,
                  )
                : Image.asset(
                    assetIcon!,
                    height: 24.r,
                    color: AppColors.textPrimaryDark,
                  ),
          ),
        ),
      );
}
