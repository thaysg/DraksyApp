import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/extensions/spacing.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/custom_decorated_box.dart';

class ProfileStatItem extends StatelessWidget {
  const ProfileStatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    super.key,
    this.child,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) => SizedBox.expand(
        child: CustomDecoratedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomDecoratedBox(
                shape: BoxShape.circle,
                padding: const EdgeInsets.all(8),
                opacity: 0.3,
                color: color,
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: AppTextStyles.h4(context).copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    label.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodySmall(context).copyWith(
                      color: AppColors.textSecondary(context),
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      fontSize: 10.sp, // Use .sp for consistency
                    ),
                  ),
                  if (child != null) ...[
                    8.heightBox,
                    child!,
                  ],
                ],
              ),
            ],
          ),
        ),
      );
}
