import 'package:flutter/material.dart';

import '../extensions/localization_extension.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'custom_button.dart';

/// Error retry widget for displaying error states with retry button.
class ErrorRetryWidget extends StatelessWidget {
  /// Creates an error retry widget
  const ErrorRetryWidget({
    required this.error,
    required this.onRetry,
    super.key,
    this.title,
  });

  /// Error message to display
  final String error;

  /// Callback when user taps retry
  final VoidCallback onRetry;

  /// Custom error title
  final String? title;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: AppColors.error),
              const SizedBox(height: 16),
              Text(
                title ?? context.l10n.error,
                style: AppTextStyles.h3(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                error,
                style: AppTextStyles.bodyMedium(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: context.l10n.tryAgain,
                onPressed: onRetry,
              ),
            ],
          ),
        ),
      );
}
