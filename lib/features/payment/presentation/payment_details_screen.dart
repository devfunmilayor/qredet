import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qredet/core/formatters/formatters.dart';
import 'package:qredet/core/l10n/generated/app_localizations.dart';
import 'package:qredet/core/router/app_routes.dart';
import 'package:qredet/core/theme/theme.dart';
import 'package:qredet/core/widgets/widgets.dart';
import 'package:qredet/features/home/presentation/widgets/primary_button.dart';
import 'package:qredet/features/payment/data/mock_payment.dart';
import 'package:qredet/features/payment/presentation/widgets/payment_pin_sheet.dart';

class PaymentDetailsScreen extends StatelessWidget {
  const PaymentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.transactionDetails)),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DetailRow(label: l10n.recipient, value: mockPayment.recipientName),
            DetailRow(
              label: l10n.bankAccount,
              value: '${l10n.ubaBank} ${mockPayment.accountNumber}',
            ),
            DetailRow(
              label: l10n.amount,
              value: formatCurrency(mockPayment.amount, locale: locale),
            ),
            const Spacer(),
            PrimaryButton(
              label: l10n.proceed,
              onPressed: () => PaymentPinSheet.show(
                context,
                onConfirmed: () {
                  Navigator.of(context).pop();
                  context.push(AppRoutes.paymentSuccess);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
