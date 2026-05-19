import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/dragon_assets.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_scroll.dart';
import '../../../../core/widgets/xp_bar.dart';
import '../../../profile/presentation/providers/user_stats_provider.dart';
import '../../data/models/node_content_model.dart';
import '../models/lesson_view_data.dart';
import '../providers/lesson_provider.dart';
import '../widgets/check_button.dart';
import '../widgets/dragon_widget.dart';
import '../widgets/explanation_card.dart';
import '../widgets/lesson_completion_view.dart';
import '../widgets/question_card.dart';

class LessonMobileView extends ConsumerWidget {
  const LessonMobileView({required this.data, super.key});

  final LessonViewData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = data.session;

    if (session.isLessonFinished) {
      return LessonCompletionView(
        data: data,
        onFinish: () {
          ref.read(lessonSessionProvider.notifier).reset();
          context.pop();
        },
      );
    }

    final node = data.nodes[session.currentIndex];
    final notifier = ref.read(lessonSessionProvider.notifier);

    final isLastNode = session.currentIndex == data.nodes.length - 1;

    final isExplanation = node.content is ExplanationContentModel;
    final isAnswered = session.isAnswered;

    final lives = ref.watch(userStatsProvider).lives;

    // Handle out of lives
    if (lives <= 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text(context.l10n.noLivesTitle),
            content: Text(context.l10n.noLivesMessage),
            actions: [
              TextButton(
                onPressed: () {
                  context.pop(); // Close dialog
                  // context.pop(); // Go back to map
                },
                child: Text(context.l10n.ok),
              ),
            ],
          ),
        );
      });
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => context.pop(),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: XpBar(
                    currentXp: (data.progress * 100).toInt(),
                    maxXp: 100,
                    showLabel: false,
                    color: AppColors.primaryAppColor,
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(Icons.favorite, color: AppColors.hp, size: 24.r),
                  4.widthBox,
                  Text(
                    lives.toString(),
                    style: AppTextStyles.bodyMedium(context).copyWith(
                      color: AppColors.hp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: CustomScroll(
            child: Column(
              children: [
                Text(
                  data.lessonTitle,
                  style: AppTextStyles.h4(context).copyWith(
                    color: AppColors.primaryAppColor,
                    height: 1.1,
                  ),
                  textAlign: TextAlign.center,
                ),
                24.heightBox,
                if (isExplanation)
                  ExplanationCard(
                    content: node.content as ExplanationContentModel,
                    dragonColor: DragonAssets
                        .colors[node.orderIndex % DragonAssets.colors.length],
                  )
                else if (node.content is QuestionContentModel) ...[
                  DragonWidget(
                    imageKey: session.dragonImageKey ?? 'dragon_neutral',
                    dragonColor: DragonAssets
                        .colors[node.orderIndex % DragonAssets.colors.length],
                  ),
                  24.heightBox,
                  QuestionCard(
                    content: node.content as QuestionContentModel,
                    selectedAnswer: session.selectedAnswer,
                    isAnswered: isAnswered,
                    onSelect: (index) {
                      if (!isAnswered && lives > 0) {
                        notifier.updateSelectedAnswer(index);
                      }
                    },
                  ),
                ],
                100.heightBox,
              ],
            ),
          ),
        ),
        CheckButton(
          text: (isExplanation || isAnswered)
              ? context.l10n.continueButton
              : context.l10n.submit,
          onTap: (isExplanation || isAnswered)
              ? () async {
                  if (isLastNode) {
                    if (session.accuracy >= 0.8) {
                      await notifier.finishLesson(
                        unitId: data.unitId,
                        lessonId: data.lessonId,
                        nodeId: data.nodes.last.id,
                      );
                    }
                    notifier.advance();
                  } else {
                    notifier.advance();
                  }
                }
              : (session.selectedAnswer != null
                  ? () => notifier.selectAnswer(
                        session.selectedAnswer!,
                        (node.content as QuestionContentModel).correctIndex,
                      )
                  : null),
        ),
      ],
    );
  }
}
