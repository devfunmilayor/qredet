import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/router/app_routes.dart';
import 'primary_button.dart';

class MakePaymentButton extends StatefulWidget {
  const MakePaymentButton({super.key});

  @override
  State<MakePaymentButton> createState() => _MakePaymentButtonState();
}

class _MakePaymentButtonState extends State<MakePaymentButton> {
  bool _isLoading = false;

  Future<void> _onPressed() async {
    setState(() => _isLoading = true);
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    setState(() => _isLoading = false);
    context.push(AppRoutes.paymentDetails);
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      label: AppLocalizations.of(context).makePayment,
      isLoading: _isLoading,
      onPressed: _onPressed,
    );
  }
}
