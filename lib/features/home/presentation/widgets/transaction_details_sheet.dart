import 'package:flutter/material.dart';
import 'package:qredet/core/formatters/formatters.dart';
import 'package:qredet/core/l10n/generated/app_localizations.dart';
import 'package:qredet/core/widgets/widgets.dart';
import 'package:qredet/features/home/domain/entities/transaction.dart';

class TransactionDetailsSheet extends StatelessWidget {
  const TransactionDetailsSheet({super.key, required this.transaction});

  final Transaction transaction;

  static Future<void> show(BuildContext context, Transaction transaction) {
    return GlassSheet.show(
      context,
      builder: (_) => TransactionDetailsSheet(transaction: transaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    final isDebit = transaction.type == TransactionType.debit;
    final sign = isDebit ? '-' : '+';
    return GlassSheet(
      title: l10n.transactionDetails,
      onCancel: () => Navigator.of(context).pop(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DetailRow(label: l10n.recipient, value: transaction.alias),
          DetailRow(
            label: l10n.date,
            value: formatTransactionDate(transaction.date, locale: locale),
          ),
          DetailRow(
            label: l10n.transactionType,
            value: isDebit ? l10n.debit : l10n.credit,
          ),
          DetailRow(
            label: l10n.amount,
            value: '$sign${formatCurrency(transaction.amount, locale: locale)}',
          ),
        ],
      ),
    );
  }
}
