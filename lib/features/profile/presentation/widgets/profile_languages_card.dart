import 'package:flutter/material.dart';

import '../../../../../core/extensions/localization_extension.dart';
import '../../../../../core/extensions/spacing.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_decorated_box.dart';
import '../../../../../core/widgets/custom_list_tile.dart';
import '../../../../core/widgets/section_header.dart';
import '../models/profile_view_data.dart';

class ProfileLanguagesCard extends StatelessWidget {
  const ProfileLanguagesCard({required this.languages, super.key});

  final List<ProfileLanguageData> languages;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: context.l10n.lessons,
          ),
          16.heightBox,
          CustomDecoratedBox(
            padding: EdgeInsets.zero,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: languages.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: AppColors.surface(context).withValues(alpha: 0.1),
                indent: 72,
              ),
              itemBuilder: (context, index) {
                final language = languages[index];
                return CustomListTile(
                  title: language.title,
                  subtitle: language.subtitle,
                  icon: language.icon,
                  iconColor: language.color,
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      );
}
