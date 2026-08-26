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
    final filled = _controller.text.length;
    return GlassSheet(
      title: l10n.enterPin,
      onCancel: () => Navigator.of(context).pop(),
      child: GestureDetector(
        onTap: () => _focusNode.requestFocus(),
        behavior: HitTestBehavior.translucent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pinLength,
                    (index) => _PinBox(isFilled: index < filled),
                  ),
                ),
                SizedBox(
                  width: 0,
                  height: 0,
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    maxLength: _pinLength,
                    showCursor: false,
                    decoration: const InputDecoration(counterText: '', border: InputBorder.none),
                    style: const TextStyle(color: Colors.transparent, height: 0.01, fontSize: 0.01),
                    cursorWidth: 0,
                    onChanged: (value) => setState(() {}),
                  ),
                ),
              ],
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
        border: Border.all(color: isFilled ? colors.primary : colors.divider, width: 1.5),
      ),
      child: isFilled
          ? Container(width: 10, height: 10, decoration: BoxDecoration(color: colors.primary, shape: BoxShape.circle))
          : null,
    );
  }
}
