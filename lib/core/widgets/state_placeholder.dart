import 'package:flutter/material.dart';
import 'package:qredet/core/theme/app_semantic_colors.dart';
import 'package:qredet/core/theme/app_spacing.dart';
import 'package:qredet/core/theme/app_text_styles.dart';

class StatePlaceholder extends StatelessWidget {
  const StatePlaceholder({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.retryLabel,
    this.onRetry,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final String? retryLabel;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 32, color: colors.textMuted),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              style: AppTextStyles.stateTitle.copyWith(
                color: colors.textPrimary,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: AppTextStyles.stateSubtitle.copyWith(
                  color: colors.textMuted,
                ),
              ),
            ],
            if (retryLabel != null && onRetry != null) ...[
              const SizedBox(height: AppSpacing.lg),
              TextButton(onPressed: onRetry, child: Text(retryLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}
