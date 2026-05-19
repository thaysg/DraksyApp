import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_decorated_box.dart';

class SettingsTitle extends StatelessWidget {
  const SettingsTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 16, top: 24, bottom: 8),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => context.pop(),
              child: SizedBox(
                width: 40.h,
                height: 40.w,
                child: CustomDecoratedBox(
                  borderRadius: BorderRadius.circular(12.r),
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Icon(
                      Icons.chevron_left_rounded,
                      color: AppColors.textPrimary(context),
                      size: 22.r,
                    ),
                  ),
                ),
              ),
            ),
            16.widthBox,
            Text(
              context.l10n.settings,
              style: AppTextStyles.h4(context).copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      );
}
