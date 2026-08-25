import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/l10n/generated/app_localizations.dart';
import '../../../../core/widgets/state_placeholder.dart';
import '../../../home/presentation/widgets/transaction_tile.dart';
import '../bloc/transactions_list_bloc.dart';
import '../bloc/transactions_list_event.dart';
import '../bloc/transactions_list_state.dart';

class TransactionsListView extends StatefulWidget {
  const TransactionsListView({super.key, required this.state});

  final TransactionsListState state;

  @override
  State<TransactionsListView> createState() => _TransactionsListViewState();
}

class _TransactionsListViewState extends State<TransactionsListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels > _scrollController.position.maxScrollExtent - 200) {
      context.read<TransactionsListBloc>().add(const TransactionsListEvent.moreRequested());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = widget.state.visibleItems;
    if (items.isEmpty) {
      return StatePlaceholder(icon: Icons.search_off, title: l10n.transactionsEmptyTitle);
    }
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverList.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return TransactionTile(transaction: items[index])
                .animate(delay: (30 * index).ms)
                .fadeIn(duration: 200.ms)
                .slideY(begin: 0.1, end: 0, curve: Curves.easeOut);
          },
        ),
        if (widget.state.isLoadingMore)
          const SliverToBoxAdapter(
            child: Padding(padding: EdgeInsets.all(24), child: Center(child: CircularProgressIndicator())),
          ),
      ],
    );
  }
}
