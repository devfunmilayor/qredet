import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/formatters/currency_formatter.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/tap_scale.dart';

class BalanceHeader extends StatefulWidget {
  const BalanceHeader({super.key, required this.balance, required this.label});

  final num balance;
  final String label;

  @override
  State<BalanceHeader> createState() => _BalanceHeaderState();
}

class _BalanceHeaderState extends State<BalanceHeader> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final locale = Localizations.localeOf(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.label, style: AppTextStyles.balanceLabel.copyWith(color: colors.textMuted)),
            const SizedBox(width: AppSpacing.xs),
            TapScale(
              onTap: () => setState(() => _isVisible = !_isVisible),
              child: Icon(
                _isVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                size: 18,
                color: colors.textMuted,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              _isVisible ? formatAmount(widget.balance, locale: locale) : '••••••',
              style: AppTextStyles.balanceAmount.copyWith(color: colors.textNavy),
            ),
            if (_isVisible)
              Text('F', style: AppTextStyles.balanceSuffix.copyWith(color: colors.textNavy)),
          ],
        ),
      ],
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1, end: 0, curve: Curves.easeOut);
  }
}
