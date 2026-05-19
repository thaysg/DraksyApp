import 'package:flutter/material.dart';

import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/extensions/spacing.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_decorated_box.dart';
import '../../../../../core/widgets/custom_list_tile.dart';
import '../../../../core/widgets/section_header.dart';
import '../models/profile_view_data.dart';

class ProfileBadgesSection extends StatelessWidget {
  const ProfileBadgesSection({required this.badges, super.key});

  final List<ProfileBadgeData> badges;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: context.l10n.badges,
          ),
          12.heightBox,
          CustomDecoratedBox(
            padding: EdgeInsets.zero,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: badges.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: AppColors.surface(context).withValues(alpha: 0.1),
                indent: 72,
              ),
              itemBuilder: (context, index) {
                final badge = badges[index];
                return CustomListTile(
                  title: badge.title,
                  subtitle: badge.subtitle,
                  icon: badge.icon,
                  iconColor: badge.color,
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      );
}
