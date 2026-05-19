import 'package:flutter/material.dart';

import '../extensions/spacing.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'custom_decorated_box.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    required this.title,
    required this.icon,
    required this.iconColor,
    super.key,
    this.subtitle,
    this.onTap,
    this.trailing,
    this.showBorder = true,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool showBorder;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              CustomDecoratedBox(
                shape: BoxShape.circle,
                padding: const EdgeInsets.all(8),
                opacity: 0.2,
                color: iconColor,
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),
              16.widthBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.bodyLarge(context).copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (subtitle != null) ...[
                      2.heightBox,
                      Text(
                        subtitle!,
                        style: AppTextStyles.bodySmall(context).copyWith(
                          color: AppColors.textSecondary(context),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              trailing ??
                  Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textSecondary(context),
                  ),
            ],
          ),
        ),
      );
}
