import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/widgets/custom_decorated_box.dart';

class TextFieldCards extends StatelessWidget {
  const TextFieldCards({
    required TextEditingController displayNameController,
    required TextEditingController usernameController,
    required TextEditingController emailController,
    super.key,
  })  : _displayNameController = displayNameController,
        _usernameController = usernameController,
        _emailController = emailController;

  final TextEditingController _displayNameController;
  final TextEditingController _usernameController;
  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) => CustomDecoratedBox(
        opacity: 1,
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.displayName,
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
                controller: _displayNameController,
                hintText: context.l10n.enterDisplayName,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
            20.heightBox,
            Text(
              context.l10n.username,
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
                controller: _usernameController,
                hintText: context.l10n.enterUsername,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
            20.heightBox,
            Text(
              context.l10n.email,
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
                controller: _emailController,
                hintText: context.l10n.enterEmail,
                keyboardType: TextInputType.emailAddress,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ],
        ),
      );
}
