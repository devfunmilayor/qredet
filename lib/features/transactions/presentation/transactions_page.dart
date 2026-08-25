import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/injection.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/widgets.dart';
import '../../home/presentation/widgets/transaction_tile_shimmer.dart';
import 'bloc/transactions_list_bloc.dart';
import 'bloc/transactions_list_event.dart';
import 'bloc/transactions_list_state.dart';
import 'widgets/transactions_list_view.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TransactionsListBloc>()..add(const TransactionsListEvent.started()),
      child: const _TransactionsPageBody(),
    );
  }
}

class _TransactionsPageBody extends StatefulWidget {
  const _TransactionsPageBody();

  @override
  State<_TransactionsPageBody> createState() => _TransactionsPageBodyState();
}

class _TransactionsPageBodyState extends State<_TransactionsPageBody> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.allTransactions)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.md),
            SearchField(
              controller: _searchController,
              hint: l10n.searchTransactions,
              onChanged: (query) => context.read<TransactionsListBloc>().add(TransactionsListEvent.searched(query)),
            ),
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: BlocBuilder<TransactionsListBloc, TransactionsListState>(
                builder: (context, state) {
                  return switch (state.status) {
                    TransactionsListStatus.loading => const TransactionTileShimmer(count: 6),
                    TransactionsListStatus.error => StatePlaceholder(
                        icon: Icons.error_outline,
                        title: l10n.transactionsErrorTitle,
                        subtitle: l10n.tryAgainMessage,
                        retryLabel: l10n.retry,
                        onRetry: () => context.read<TransactionsListBloc>().add(const TransactionsListEvent.started()),
                      ),
                    TransactionsListStatus.loaded => TransactionsListView(state: state),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
