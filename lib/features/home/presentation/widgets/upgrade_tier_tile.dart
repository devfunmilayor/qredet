import 'package:flutter/material.dart';
import 'package:qredet/core/l10n/generated/app_localizations.dart';
import 'package:qredet/core/theme/theme.dart';
import 'package:qredet/features/home/domain/entities/upgrade_tier.dart';

extension UpgradeTierLabels on UpgradeTierType {
  String name(AppLocalizations l10n) => switch (this) {
    UpgradeTierType.basic => l10n.tierBasicName,
    UpgradeTierType.standard => l10n.tierStandardName,
    UpgradeTierType.premium => l10n.tierPremiumName,
  };

  String price(AppLocalizations l10n) => switch (this) {
    UpgradeTierType.basic => l10n.tierBasicPrice,
    UpgradeTierType.standard => l10n.tierStandardPrice,
    UpgradeTierType.premium => l10n.tierPremiumPrice,
  };

  String limitDescription(AppLocalizations l10n) => switch (this) {
    UpgradeTierType.basic => l10n.tierBasicLimit,
    UpgradeTierType.standard => l10n.tierStandardLimit,
    UpgradeTierType.premium => l10n.tierPremiumLimit,
  };
}

class UpgradeTierTile extends StatelessWidget {
  const UpgradeTierTile({super.key, required this.tier, required this.onTap});

  final UpgradeTier tier;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = AppLocalizations.of(context);
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tier.type.name(l10n),
                    style: AppTextStyles.cardTitle.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                  Text(
                    tier.type.limitDescription(l10n),
                    style: AppTextStyles.cardSubtitle.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              tier.type.price(l10n),
              style: AppTextStyles.pillLabel.copyWith(color: colors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
