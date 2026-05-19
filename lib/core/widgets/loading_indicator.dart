import 'package:flutter/material.dart';

/// Loading indicator widget for draksy.
/// Shows a centered circular progress indicator.
class LoadingIndicator extends StatelessWidget {
  /// Creates a loading indicator
  const LoadingIndicator({super.key, this.size});

  /// Custom indicator size
  final double? size;

  @override
  Widget build(BuildContext context) => Center(
        child: SizedBox(
          width: size ?? 48,
          height: size ?? 48,
          child: const CircularProgressIndicator(strokeWidth: 3),
        ),
      );
}
