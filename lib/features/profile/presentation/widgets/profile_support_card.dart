import 'package:flutter/material.dart';

import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/custom_decorated_box.dart';

class ProfileSupportCard extends StatelessWidget {
  const ProfileSupportCard({
    required this.onLogout,
    required this.onDeleteAccount,
    super.key,
  });

  final VoidCallback onLogout;
  final VoidCallback onDeleteAccount;

  @override
  Widget build(BuildContext context) => CustomDecoratedBox(
        child: Column(
          children: [
            InkWell(
              onTap: onLogout,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    context.l10n.logout,
                    style: AppTextStyles.bodyLarge(context).copyWith(
                      color: AppColors.primaryAppColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.textSecondary(context).withValues(alpha: 0.1),
            ),
            InkWell(
              onTap: onDeleteAccount,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    context.l10n.deleteAccount,
                    style: AppTextStyles.bodyLarge(context).copyWith(
                      color: AppColors.primaryAppColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
