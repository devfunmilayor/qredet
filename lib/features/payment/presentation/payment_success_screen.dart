import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/theme.dart';
import '../../home/presentation/widgets/primary_button.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(color: colors.primary, shape: BoxShape.circle),
                child: const Icon(Icons.check, color: Colors.white, size: 48),
              ).animate().scale(
                    begin: const Offset(0.4, 0.4),
                    end: const Offset(1, 1),
                    duration: 450.ms,
                    curve: Curves.elasticOut,
                  ),
              const SizedBox(height: AppSpacing.xxl),
              Text(
                l10n.paymentSuccessful,
                style: AppTextStyles.sheetTitle.copyWith(color: colors.textPrimary),
              ).animate(delay: 300.ms).fadeIn(duration: 300.ms),
              const SizedBox(height: AppSpacing.xs),
              Text(
                l10n.paymentSuccessMessage,
                style: AppTextStyles.cardSubtitle.copyWith(color: colors.textMuted),
              ).animate(delay: 400.ms).fadeIn(duration: 300.ms),
              const SizedBox(height: AppSpacing.xxxl),
              PrimaryButton(label: l10n.backToHome, onPressed: () => context.go(AppRoutes.home)),
            ],
          ),
        ),
      ),
    );
  }
}
