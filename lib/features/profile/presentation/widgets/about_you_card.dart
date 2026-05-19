import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/widgets/custom_decorated_box.dart';

class AboutYouCard extends StatelessWidget {
  const AboutYouCard({
    required TextEditingController bioController,
    super.key,
  }) : _bioController = bioController;

  final TextEditingController _bioController;

  @override
  Widget build(BuildContext context) => CustomDecoratedBox(
        opacity: 1,
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.aboutYou,
              style: AppTextStyles.bodySmall(context).copyWith(
                color: AppColors.textSecondary(context),
                fontWeight: FontWeight.w700,
              ),
            ),
            8.heightBox,
            CustomDecoratedBox(
              padding: const EdgeInsets.all(8),
              borderColor: AppColors.scafoldBackgroungLight,
              child: AppTextFormField(
                controller: _bioController,
                hintText: context.l10n.enterBio,
                keyboardType: TextInputType.multiline,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                maxLines: 4,
                maxLength: 120,
              ),
            ),
            4.heightBox,
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${_bioController.text.length}/120',
                style: AppTextStyles.bodySmall(context).copyWith(
                  color: AppColors.textSecondary(context),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
}
