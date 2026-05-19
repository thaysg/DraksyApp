import 'package:flutter/material.dart';

import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/extensions/spacing.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_decorated_box.dart';

class ShopSidebarItem extends StatelessWidget {
  const ShopSidebarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    super.key,
  });

  final IconData icon;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: CustomDecoratedBox(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: isSelected
                ? context.colorScheme.primary.withValues(alpha: 0.1)
                : AppColors.transparent,
            borderRadius: BorderRadius.circular(12),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isSelected
                      ? context.colorScheme.primary
                      : context.colorScheme.onSurfaceVariant,
                  size: 24,
                ),
                16.widthBox,
                Text(
                  label,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: isSelected
                        ? context.colorScheme.primary
                        : context.colorScheme.onSurfaceVariant,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
