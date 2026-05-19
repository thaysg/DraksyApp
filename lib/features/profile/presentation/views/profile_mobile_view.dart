import 'package:flutter/material.dart';

import '../../../../../core/extensions/spacing.dart';
import '../../../../../core/widgets/custom_scroll.dart';
import '../models/profile_view_data.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_info_section.dart';
import '../widgets/profile_menu.dart';
import '../widgets/profile_stats.dart';

class ProfileMobileView extends StatelessWidget {
  const ProfileMobileView({
    required this.data,
    required this.onLogout,
    required this.onDeleteAccount,
    super.key,
  });

  final ProfileViewData data;
  final VoidCallback onLogout;
  final VoidCallback onDeleteAccount;

  @override
  Widget build(BuildContext context) => CustomScroll(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeader(
              userName: data.userName,
              userTag: data.userTag,
              photo: data.photo,
              level: data.level,
            ),
            20.heightBox,
            ProfileStats(
              totalXp: data.totalXp,
              streak: data.streak,
              lessons: data.lessons,
              accuracy: data.accuracy,
              currentXp: data.currentXp,
              maxXp: data.maxXp,
            ),
            20.heightBox,
            ProfileInfoSection(data: data),
            20.heightBox,
            ProfileMenu(
              onLogout: onLogout,
              onDeleteAccount: onDeleteAccount,
            ),
            100.heightBox,
          ],
        ),
      );
}
