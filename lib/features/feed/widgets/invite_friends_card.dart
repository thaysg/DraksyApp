import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_decorated_box.dart';

class InviteFriendsCard extends StatelessWidget {
  const InviteFriendsCard({super.key});

  Future<void> _shareInvite(BuildContext context) async {
    final l10n = context.l10n;
    final message = '${l10n.inviteFriendsMessage} ${l10n.inviteFriendsURL}';

    try {
      await SharePlus.instance.share(ShareParams(text: message));
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.somethingWentWrong),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => _shareInvite(context),
        child: SizedBox(
          width: 85.w,
          child: Column(
            children: [
              CustomDecoratedBox(
                padding: EdgeInsets.all(12.r),
                color: AppColors.surfaceContainerHighest(context),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.r),
                child: Icon(
                  Icons.group_add_rounded,
                  color: AppColors.primaryAppColor,
                  size: 28.r,
                ),
              ),
              8.heightBox,
              Text(
                context.l10n.inviteFriendsLabel,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall(context).copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 11.sp,
                  height: 1.1,
                ),
              ),
            ],
          ),
        ),
      );
}
