import 'package:flutter/material.dart';
import '../../../../core/formatters/formatters.dart';
import '../../../../core/theme/theme.dart';
import '../../domain/entities/transaction.dart';
import 'transaction_details_sheet.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final locale = Localizations.localeOf(context);
    final isDebit = transaction.type == TransactionType.debit;
    final sign = isDebit ? '-' : '+';

    return InkWell(
      onTap: () => TransactionDetailsSheet.show(context, transaction),
      borderRadius: BorderRadius.circular(AppSpacing.md),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: colors.surfaceAvatar,
              child: Icon(
                isDebit ? Icons.arrow_upward : Icons.arrow_downward,
                size: 18,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(transaction.alias, style: AppTextStyles.tileAlias.copyWith(color: colors.textPrimary)),
                  Text(
                    formatTransactionDate(transaction.date, locale: locale),
                    style: AppTextStyles.tileDate.copyWith(color: colors.textMuted),
                  ),
                ],
              ),
            ),
            Text(
              '$sign${formatCurrency(transaction.amount, locale: locale)}',
              style: AppTextStyles.tileAmount.copyWith(color: colors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
