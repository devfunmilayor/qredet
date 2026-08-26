import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/state_placeholder.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../bloc/transactions_state.dart';
import 'section_header.dart';
import 'transaction_tile.dart';
import 'transaction_tile_shimmer.dart';

class TransactionsSection extends StatelessWidget {
  const TransactionsSection({super.key, this.onSeeAll});

  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => previous.transactions != current.transactions,
      builder: (context, state) {
        return SliverMainAxisGroup(
          slivers: [
            SliverToBoxAdapter(
              child: SectionHeader(title: l10n.payments, actionLabel: l10n.seeAll, onAction: onSeeAll),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),
            switch (state.transactions) {
              TransactionsLoading() => const SliverToBoxAdapter(child: TransactionTileShimmer()),
              TransactionsError() => SliverToBoxAdapter(
                  child: StatePlaceholder(
                    icon: Icons.error_outline,
                    title: l10n.transactionsErrorTitle,
                    subtitle: l10n.tryAgainMessage,
                    retryLabel: l10n.retry,
                    onRetry: () => context.read<HomeBloc>().add(const HomeEvent.transactionsRetried()),
                  ),
                ),
              TransactionsEmpty() => SliverToBoxAdapter(
                  child: StatePlaceholder(
                    icon: Icons.inbox_outlined,
                    title: l10n.transactionsEmptyTitle,
                    subtitle: l10n.transactionsEmptySubtitle,
                  ),
                ),
              TransactionsLoaded(:final transactions) => SliverList.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    return TransactionTile(transaction: transactions[index])
                        .animate(delay: (40 * index).ms)
                        .fadeIn(duration: 250.ms)
                        .slideY(begin: 0.15, end: 0, curve: Curves.easeOut);
                  },
                ),
            },
          ],
        );
      },
    );
  }
}
