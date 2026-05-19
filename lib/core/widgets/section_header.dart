import 'package:flutter/material.dart';

import '../extensions/localization_extension.dart';
import '../extensions/spacing.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    super.key,
    this.icon,
    this.iconColor,
    this.showSeeAll = false,
  });
  final String title;
  final IconData? icon;
  final Color? iconColor;
  final bool showSeeAll;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: iconColor, size: 20),
            8.widthBox,
          ],
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.titleMedium(context).copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          if (showSeeAll) ...[
            8.widthBox,
            Text(
              context.l10n.seeAll,
              style: AppTextStyles.bodySmall(context).copyWith(
                color: AppColors.info,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ],
      );
}
