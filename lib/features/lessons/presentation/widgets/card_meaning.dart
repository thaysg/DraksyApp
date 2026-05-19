import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_decorated_box.dart';

class CardMeaning extends StatelessWidget {
  const CardMeaning({
    required this.meaningTitle,
    required this.targetWord,
    required this.description,
    required this.dragonImage,
    this.onPlayAudio,
    super.key,
  });

  final String meaningTitle;
  final String targetWord;
  final String description;
  final String dragonImage;
  final VoidCallback? onPlayAudio;

  @override
  Widget build(BuildContext context) => CustomDecoratedBox(
        opacity: 1,
        child: Column(
          children: [
            Image.asset(
              dragonImage,
              height: 180.h,
              fit: BoxFit.contain,
            ),
            16.heightBox,
            GestureDetector(
              onTap: onPlayAudio,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppTextStyles.bodyLarge(context).copyWith(
                    color: AppColors.onSurface(context),
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: meaningTitle.split(targetWord).first,
                    ),
                    TextSpan(
                        text: targetWord,
                        style: AppTextStyles.titleLarge(context).copyWith(
                          color: AppColors.primaryAppColor,
                          fontWeight: FontWeight.w900,
                        )),
                    TextSpan(
                      text: meaningTitle.split(targetWord).last,
                    ),
                  ],
                ),
              ),
            ),
            8.heightBox,
            Text(
              description,
              style: AppTextStyles.bodyMedium(context).copyWith(
                color: AppColors.onSurface(context).withValues(alpha: 0.8),
              ),
              textAlign: TextAlign.center,
            ),
            16.heightBox,
            InkWell(
              onTap: onPlayAudio,
              borderRadius: BorderRadius.circular(30.r),
              child: CustomDecoratedBox(
                shape: BoxShape.circle,
                padding: EdgeInsets.all(12.r),
                opacity: 0.3,
                color: AppColors.primaryAppColor,
                borderColor: AppColors.transparent,
                child: Icon(
                  Icons.volume_up_rounded,
                  color: AppColors.primaryAppColor,
                  size: 24.r,
                ),
              ),
            ),
          ],
        ),
      );
}
