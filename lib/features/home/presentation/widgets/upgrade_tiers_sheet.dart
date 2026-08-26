import 'package:flutter/material.dart';
import 'package:qredet/core/l10n/generated/app_localizations.dart';
import 'package:qredet/core/widgets/widgets.dart';
import 'package:qredet/features/home/data/datasources/upgrade_tier_catalog.dart';
import 'package:qredet/features/home/presentation/widgets/upgrade_tier_tile.dart';

class UpgradeTiersSheet extends StatelessWidget {
  const UpgradeTiersSheet({super.key});

  static Future<void> show(BuildContext context) {
    return GlassSheet.show(context, builder: (_) => const UpgradeTiersSheet());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return GlassSheet(
      title: l10n.upgradeTiersTitle,
      onCancel: () => Navigator.of(context).pop(),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: upgradeTiers.length,
        itemBuilder: (context, index) {
          final tier = upgradeTiers[index];
          return UpgradeTierTile(
            tier: tier,
            onTap: () {
              AppToast.showSuccess(context, l10n.planUpdated);
              Navigator.of(context).pop();
            },
          );
        },
      ),
    );
  }
}
