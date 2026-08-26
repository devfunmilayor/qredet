import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class PaymentDetailRow extends StatelessWidget {
  const PaymentDetailRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.cardSubtitle.copyWith(color: colors.textMuted)),
          Text(value, style: AppTextStyles.chipBankName.copyWith(color: colors.textPrimary)),
        ],
      ),
    );
  }
}
