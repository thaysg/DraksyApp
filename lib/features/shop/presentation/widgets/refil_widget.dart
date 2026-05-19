import 'package:flutter/material.dart';

import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_decorated_box.dart';

class RefilWidget extends StatelessWidget {
  const RefilWidget({
    required this.iconColor,
    required this.icon,
    required this.title,
    required this.description,
    super.key,
  });

  final Color iconColor;
  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          CustomDecoratedBox(
            padding: const EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(15),
            color: iconColor.withValues(alpha: 0.1),
            borderColor: iconColor.withValues(alpha: 0.2),
            opacity: 0.2,
            child: Icon(icon, color: iconColor, size: 28),
          ),
          12.widthBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.titleMedium(context).copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                2.heightBox,
                Text(
                  description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmall(context).copyWith(
                    color: AppColors.textSecondary(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
