import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/services/tts_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_decorated_box.dart';
import '../../data/models/node_content_model.dart';
import 'dragon_widget.dart';
import 'grammar_tip.dart';

class ExplanationCard extends ConsumerWidget {
  const ExplanationCard({
    required this.content,
    required this.dragonColor,
    super.key,
  });

  final ExplanationContentModel content;
  final String dragonColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tts = ref.watch(ttsServiceProvider);

    return Column(
      children: [
        SizedBox(
          width: context.screenWidth,
          child: CustomDecoratedBox(
            opacity: 1,
            child: Column(
              children: [
                DragonWidget(
                  imageKey: content.imageKey,
                  dragonColor: dragonColor,
                ),
                16.heightBox,
                GestureDetector(
                  onTap: () => tts.speak(content.phrase),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: AppTextStyles.bodyLarge(context).copyWith(
                        color: AppColors.onSurface(context),
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: content.phrase,
                          style: AppTextStyles.h3(context).copyWith(
                            color: AppColors.primaryAppColor,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        TextSpan(
                          text: '\n${content.translation}',
                          style: AppTextStyles.bodyMedium(context).copyWith(
                            color: AppColors.textSecondary(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                16.heightBox,
                Text(
                  content.contextSentence,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium(context),
                ),
                16.heightBox,
                InkWell(
                  onTap: () => tts.speak(content.phrase),
                  borderRadius: BorderRadius.circular(30.r),
                  child: CustomDecoratedBox(
                    shape: BoxShape.circle,
                    padding: EdgeInsets.all(12.r),
                    opacity: 0.3,
                    color: AppColors.primaryAppColor,
                    borderColor: AppColors.transparent,
                    child: Icon(
                      Icons.volume_up_rounded,
                      color: AppColors.primaryAppColor,
                      size: 24.r,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        24.heightBox,
        GrammarTip(text: content.grammarTip),
      ],
    );
  }
}
