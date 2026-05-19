import 'package:flutter/material.dart';

import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/extensions/spacing.dart';
import '../models/profile_view_data.dart';
import 'profile_badges_section.dart';
import 'profile_languages_card.dart';

class ProfileInfoSection extends StatelessWidget {
  const ProfileInfoSection({required this.data, super.key});

  final ProfileViewData data;

  @override
  Widget build(BuildContext context) {
    if (!context.isMobile) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: ProfileBadgesSection(badges: data.badges)),
          32.widthBox,
          Expanded(child: ProfileLanguagesCard(languages: data.languages)),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileBadgesSection(badges: data.badges),
        24.heightBox,
        ProfileLanguagesCard(languages: data.languages),
      ],
    );
  }
}
