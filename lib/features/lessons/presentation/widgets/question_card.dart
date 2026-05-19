import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_decorated_box.dart';
import '../../data/models/node_content_model.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    required this.content,
    required this.selectedAnswer,
    required this.onSelect,
    required this.isAnswered,
    super.key,
  });

  final QuestionContentModel content;
  final int? selectedAnswer;
  final ValueChanged<int> onSelect;
  final bool isAnswered;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(
            content.question,
            style: AppTextStyles.h3(context),
            textAlign: TextAlign.center,
          ),
          32.heightBox,
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 0.85,
            ),
            itemCount: content.options.length,
            itemBuilder: (context, index) {
              final option = content.options[index];
              final isSelected = selectedAnswer == index;
              final isCorrect = index == content.correctIndex;

              var borderColor = AppColors.transparent;
              var textColor = AppColors.textPrimary(context);

              if (isAnswered) {
                if (isCorrect) {
                  borderColor = AppColors.success;
                  textColor = AppColors.success;
                } else if (isSelected) {
                  borderColor = AppColors.error;
                  textColor = AppColors.error;
                }
              } else if (isSelected) {
                borderColor = AppColors.secondaryLight;
                textColor = AppColors.secondaryLight;
              }

              return GestureDetector(
                onTap: isAnswered ? null : () => onSelect(index),
                child: CustomDecoratedBox(
                  opacity: 1,
                  padding: const EdgeInsets.all(12),
                  borderColor: borderColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        option.emoji,
                        style: AppTextStyles.h1(context),
                      ),
                      8.heightBox,
                      Text(
                        option.text,
                        style: AppTextStyles.bodyLarge(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      );
}
