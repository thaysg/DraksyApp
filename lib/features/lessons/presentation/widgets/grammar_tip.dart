import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_decorated_box.dart';
import 'bubble_tail_painter.dart';

class GrammarTip extends StatelessWidget {
  const GrammarTip({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Stack(
        clipBehavior: Clip.none,
        children: [
          CustomDecoratedBox(
            color: AppColors.secondaryLight,
            opacity: 1,
            borderColor: AppColors.transparent,
            padding: EdgeInsets.all(20.r),
            borderRadius: BorderRadius.circular(24.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: AppTextStyles.bodyMedium(context).copyWith(
                    color: AppColors.backgroundDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                12.heightBox,
                Row(
                  children: [
                    Text(
                      context.l10n.grammarTip,
                      style: AppTextStyles.bodySmall(context).copyWith(
                        color: AppColors.backgroundDark.withValues(alpha: 0.7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.lightbulb_outline,
                      color: AppColors.backgroundDark.withValues(alpha: 0.7),
                      size: 16.r,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: -10,
            top: 20,
            child: CustomPaint(
              painter: BubbleTailPainter(color: AppColors.secondaryLight),
              size: const Size(20, 20),
            ),
          ),
        ],
      );
}
