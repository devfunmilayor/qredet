import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qredet/core/l10n/generated/app_localizations.dart';
import 'package:qredet/core/theme/theme.dart';
import 'package:qredet/core/widgets/state_placeholder.dart';
import 'package:qredet/features/home/presentation/bloc/balance_state.dart';
import 'package:qredet/features/home/presentation/bloc/home_bloc.dart';
import 'package:qredet/features/home/presentation/bloc/home_event.dart';
import 'package:qredet/features/home/presentation/bloc/home_state.dart';
import 'package:qredet/features/home/presentation/widgets/balance_header.dart';
import 'package:qredet/features/home/presentation/widgets/balance_shimmer.dart';
import 'package:qredet/features/home/presentation/widgets/virtual_account_chip.dart';

class BalanceSection extends StatelessWidget {
  const BalanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => previous.balance != current.balance,
      builder: (context, state) {
        return switch (state.balance) {
          BalanceLoading() => const BalanceShimmer(),
          BalanceError() => StatePlaceholder(
            icon: Icons.error_outline,
            title: l10n.balanceErrorTitle,
            subtitle: l10n.tryAgainMessage,
            retryLabel: l10n.retry,
            onRetry: () =>
                context.read<HomeBloc>().add(const HomeEvent.balanceRetried()),
          ),
          BalanceLoaded(:final summary) => Column(
            children: [
              BalanceHeader(
                balance: summary.balance,
                label: l10n.walletBalance,
              ),
              const SizedBox(height: AppSpacing.lg),
              VirtualAccountChip(account: summary.virtualAccount),
              const SizedBox(height: AppSpacing.xs),
              Text(
                l10n.virtualAccount,
                style: AppTextStyles.virtualAccountCaption.copyWith(
                  color: context.colors.textMuted,
                ),
              ),
            ],
          ),
        };
      },
    );
  }
}
