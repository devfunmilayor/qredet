import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/virtual_account.dart';

class VirtualAccountChip extends StatelessWidget {
  const VirtualAccountChip({super.key, required this.account});

  final VirtualAccount account;

  void _copy(BuildContext context) {
    Clipboard.setData(ClipboardData(text: account.accountNumber));
    AppToast.showSuccess(context, AppLocalizations.of(context).accountNumberCopied);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.chipBackground,
        borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context).ubaBank,
            style: AppTextStyles.chipBankName.copyWith(color: colors.textPrimary),
          ),
          const SizedBox(width: AppSpacing.md),
          Text(
            account.accountNumber,
            style: AppTextStyles.chipAccountNumber.copyWith(color: colors.primary),
          ),
          const SizedBox(width: AppSpacing.xs),
          TapScale(
            onTap: () => _copy(context),
            child: Icon(Icons.copy_rounded, size: 16, color: colors.primary),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1, end: 0, curve: Curves.easeOut);
  }
}
