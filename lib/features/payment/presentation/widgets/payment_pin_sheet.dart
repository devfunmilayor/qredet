import 'package:flutter/material.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../home/presentation/widgets/primary_button.dart';

const _pinLength = 4;

class PaymentPinSheet extends StatefulWidget {
  const PaymentPinSheet({super.key, required this.onConfirmed});

  final VoidCallback onConfirmed;

  static Future<void> show(BuildContext context, {required VoidCallback onConfirmed}) {
    return GlassSheet.show(context, builder: (_) => PaymentPinSheet(onConfirmed: onConfirmed));
  }

  @override
  State<PaymentPinSheet> createState() => _PaymentPinSheetState();
}

class _PaymentPinSheetState extends State<PaymentPinSheet> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final filled = _controller.text.length;
    return GlassSheet(
      title: l10n.enterPin,
      onCancel: () => Navigator.of(context).pop(),
      child: GestureDetector(
        onTap: () => _focusNode.requestFocus(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pinLength, (index) {
                final isFilled = index < filled;
                return Container(
                  width: 16,
                  height: 16,
                  margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isFilled ? colors.primary : colors.divider,
                  ),
                );
              }),
            ),
            Offstage(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: _pinLength,
                onChanged: (value) {
                  setState(() {});
                  if (value.length == _pinLength) widget.onConfirmed();
                },
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            PrimaryButton(
              label: l10n.confirm,
              onPressed: filled == _pinLength ? widget.onConfirmed : null,
            ),
          ],
        ),
      ),
    );
  }
}
