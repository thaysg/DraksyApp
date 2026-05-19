import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_scroll.dart';
import '../../../../core/widgets/section_header.dart';
import '../models/home_view_data.dart';
import '../widgets/daily_challenge_card.dart';
import '../widgets/home_header.dart';
import '../widgets/lesson_progress_card.dart';
import '../widgets/stat_cards_section.dart';

class HomeMobileView extends StatelessWidget {
  const HomeMobileView({required this.data, super.key});

  final HomeViewData data;

  @override
  Widget build(BuildContext context) => CustomScroll(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(
              userName: data.userName,
              streak: data.streak,
              userPhotoUrl: data.userPhotoUrl,
            ),
            20.heightBox,
            StatCardsSection(
              xp: data.xp,
              level: data.level,
              lives: data.lives,
            ),
            20.heightBox,
            SectionHeader(
              title: context.l10n.dailyChallenge,
              icon: Icons.bolt_rounded,
              iconColor: AppColors.secondaryLight,
            ),
            10.heightBox,
            DailyChallengeCard(data: data.dailyChallenge),
            20.heightBox,
            SectionHeader(
              icon: Icons.rocket_launch,
              title: context.l10n.continueLearning,
              iconColor: AppColors.purple,
            ),
            10.heightBox,
            SizedBox(
              height: 235.r,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: data.lessons.length,
                separatorBuilder: (context, index) => 16.widthBox,
                itemBuilder: (context, index) {
                  final lesson = data.lessons[index];
                  return LessonProgressCard(
                    title: lesson.title,
                    subtitle: lesson.subtitle,
                    emoji: lesson.emoji,
                    progress: lesson.progress,
                    iconBgColor: lesson.iconBgColor,
                    width: 200.r,
                  );
                },
              ),
            ),
            100.heightBox,
          ],
        ),
      );
}
