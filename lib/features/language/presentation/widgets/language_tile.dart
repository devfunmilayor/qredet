import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../domain/entities/language.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({
    super.key,
    required this.language,
    required this.selected,
    required this.onTap,
  });

  final Language language;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.md),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.md,
          horizontal: AppSpacing.sm,
        ),
        child: Row(
          children: [
            Text(language.flagEmoji, style: const TextStyle(fontSize: 20.5)),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                language.label,
                style: AppTextStyles.pillLabel.copyWith(
                  color: colors.textPrimary,
                ),
              ),
            ),
            if (selected) Icon(Icons.check_circle, color: colors.primary),
          ],
        ),
      ),
    );
  }
}
