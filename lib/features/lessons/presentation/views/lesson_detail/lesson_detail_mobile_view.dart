import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extensions/spacing.dart';
import '../../../../../core/services/tts_service.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/custom_scroll.dart';
import '../../models/lesson_detail_view_data.dart';
import '../../widgets/card_meaning.dart';
import '../../widgets/exercice_divider.dart';
import '../../widgets/grammar_tip.dart';
import '../../widgets/lesson_options_grid.dart';

class LessonDetailMobileView extends ConsumerWidget {
  const LessonDetailMobileView({required this.data, super.key});

  final LessonDetailViewData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tts = ref.watch(ttsServiceProvider);

    return CustomScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            data.title,
            style: AppTextStyles.h4(context).copyWith(
              color: AppColors.primaryAppColor,
              height: 1.1,
            ),
            textAlign: TextAlign.center,
          ),
          16.heightBox,
          CardMeaning(
            meaningTitle: data.meaningTitle,
            targetWord: data.targetWord,
            description: data.description,
            dragonImage: data.dragonImage,
            onPlayAudio: () => tts.speak(data.targetWord),
          ),
          24.heightBox,
          const GrammarTip(text: 'Grammar tip placeholder'),
          32.heightBox,
          const ExerciceDivider(),
          24.heightBox,
          Text(
            data.exerciseTitle,
            style: AppTextStyles.h3(context),
            textAlign: TextAlign.center,
          ),
          24.heightBox,
          LessonOptionsGrid(
            options: data.options,
            selectedOptionIndex: data.selectedOptionIndex,
          ),
        ],
      ),
    );
  }
}
