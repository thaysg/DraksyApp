import 'package:flutter/material.dart';

import '../extensions/spacing.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'custom_decorated_box.dart';
import 'icon_row.dart';

class HeaderPage extends StatelessWidget {
  const HeaderPage({
    required this.icon1,
    required this.iconColor1,
    required this.valueText1,
    required this.title,
    required this.iconWidget,
    this.subtitle,
    this.valueColor1,
    this.hasColumn = false,
    this.hasRow = false,
    this.icon2,
    this.iconColor2,
    this.valueText2,
    this.valueColor2,
    super.key,
  });
  final Widget iconWidget;
  final bool hasColumn;
  final String title;
  final String? subtitle;
  final bool hasRow;
  final IconData icon1;
  final Color iconColor1;
  final String valueText1;
  final Color? valueColor1;
  final IconData? icon2;
  final Color? iconColor2;
  final String? valueText2;
  final Color? valueColor2;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomDecoratedBox(
            padding: const EdgeInsets.all(10),
            borderRadius: BorderRadius.circular(12),
            color: AppColors.primaryAppColor,
            borderColor: AppColors.primaryAppColor,
            opacity: 1,
            child: iconWidget,
          ),
          12.widthBox,
          Visibility(
            visible: hasColumn,
            replacement: Text(
              title,
              style: AppTextStyles.h4(context),
            ),
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodySmall(context).copyWith(
                      color: AppColors.textSecondary(context),
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    subtitle ?? '',
                    style: AppTextStyles.h4(context).copyWith(
                      color: AppColors.textPrimary(context),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (hasRow) const Spacer(),
          Visibility(
            visible: hasRow,
            replacement: IconRow(
              icon: icon1,
              iconColor: iconColor1,
              value: valueText1,
              valueColor: valueColor1,
            ),
            child: Row(
              children: [
                IconRow(
                  icon: icon1,
                  iconColor: iconColor1,
                  value: valueText1,
                  valueColor: valueColor1,
                ),
                2.widthBox,
                IconRow(
                  icon: icon2,
                  iconColor: iconColor2,
                  value: valueText2,
                  valueColor: valueColor2,
                ),
              ],
            ),
          ),
        ],
      );
}
