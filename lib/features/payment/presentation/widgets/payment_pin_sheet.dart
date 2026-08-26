import 'package:flutter/material.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../home/presentation/widgets/primary_button.dart';

const _pinLength = 4;

class PaymentPinSheet extends StatefulWidget {
  const PaymentPinSheet({super.key, required this.onConfirmed});

  final VoidCallback onConfirmed;

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onConfirmed,
  }) {
    return GlassSheet.show(
      context,
      builder: (_) => PaymentPinSheet(onConfirmed: onConfirmed),
    );
  }

  @override
  State<PaymentPinSheet> createState() => _PaymentPinSheetState();
}

class _PaymentPinSheetState extends State<PaymentPinSheet> {
  String _pin = '';

  void _onDigit(String digit) {
    if (_pin.length >= _pinLength) return;
    setState(() => _pin += digit);
  }

  void _onBackspace() {
    if (_pin.isEmpty) return;
    setState(() => _pin = _pin.substring(0, _pin.length - 1));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return GlassSheet(
      title: l10n.enterPin,
      onCancel: () => Navigator.of(context).pop(),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pinLength,
                (index) => _PinBox(isFilled: index < _pin.length),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            PinKeypad(onDigit: _onDigit, onBackspace: _onBackspace),
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(
              label: l10n.confirm,
              onPressed: _pin.length == _pinLength ? widget.onConfirmed : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _PinBox extends StatelessWidget {
  const _PinBox({required this.isFilled});

  final bool isFilled;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: 48,
      height: 56,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.chipBackground,
        borderRadius: BorderRadius.circular(AppSpacing.md),
        border: Border.all(
          color: isFilled ? colors.primary : colors.divider,
          width: 1.5,
        ),
      ),
      child: isFilled
          ? Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: colors.primary,
                shape: BoxShape.circle,
              ),
            )
          : null,
    );
  }
}
