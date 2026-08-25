import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../domain/entities/upgrade_tier.dart';

class UpgradeTierTile extends StatelessWidget {
  const UpgradeTierTile({super.key, required this.tier, required this.onTap});

  final UpgradeTier tier;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.md),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md, horizontal: AppSpacing.sm),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tier.name, style: AppTextStyles.cardTitle.copyWith(color: colors.textPrimary)),
                  Text(
                    tier.limitDescription,
                    style: AppTextStyles.cardSubtitle.copyWith(color: colors.textMuted),
                  ),
                ],
              ),
            ),
            Text(tier.price, style: AppTextStyles.pillLabel.copyWith(color: colors.primary)),
          ],
        ),
      ),
    );
  }
}
