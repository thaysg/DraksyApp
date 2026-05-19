import 'package:flutter/material.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/responsive/app_responsive.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_scroll.dart';
import '../../../../core/widgets/section_header.dart';
import '../models/home_view_data.dart';
import '../widgets/daily_challenge_card.dart';
import '../widgets/home_header.dart';
import '../widgets/lesson_progress_card.dart';
import '../widgets/stat_cards_section.dart';

class HomeDesktopView extends StatelessWidget {
  const HomeDesktopView({required this.data, super.key});

  final HomeViewData data;

  @override
  Widget build(BuildContext context) => CustomScroll(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: AppResponsive.maxContentWidth(context),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeader(
                  userName: data.userName,
                  streak: data.streak,
                  userPhotoUrl: data.userPhotoUrl,
                ),
                32.heightBox,
                StatCardsSection(
                  xp: data.xp,
                  level: data.level,
                  lives: data.lives,
                ),
                40.heightBox,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionHeader(
                            title: context.l10n.dailyChallenge,
                            icon: Icons.bolt_rounded,
                            iconColor: AppColors.secondaryLight,
                          ),
                          16.heightBox,
                          DailyChallengeCard(data: data.dailyChallenge),
                        ],
                      ),
                    ),
                    40.widthBox,
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionHeader(
                            icon: Icons.rocket_launch,
                            title: context.l10n.continueLearning,
                            iconColor: AppColors.purple,
                          ),
                          16.heightBox,
                          ...data.lessons.map((lesson) => Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: LessonProgressCard(
                                  title: lesson.title,
                                  subtitle: lesson.subtitle,
                                  emoji: lesson.emoji,
                                  progress: lesson.progress,
                                  iconBgColor: lesson.iconBgColor,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                100.heightBox,
              ],
            ),
          ),
        ),
      );
}
