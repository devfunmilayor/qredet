import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/error/failure.dart';
import '../../../home/domain/entities/transaction.dart';

part 'transactions_list_state.freezed.dart';

enum TransactionsListStatus { loading, loaded, error }

@freezed
abstract class TransactionsListState with _$TransactionsListState {
  const TransactionsListState._();

  const factory TransactionsListState({
    @Default(TransactionsListStatus.loading) TransactionsListStatus status,
    @Default(<Transaction>[]) List<Transaction> items,
    @Default('') String query,
    @Default(false) bool hasMore,
    @Default(false) bool isLoadingMore,
    Failure? failure,
  }) = _TransactionsListState;

  List<Transaction> get visibleItems {
    if (query.isEmpty) return items;
    final needle = query.toLowerCase();
    return items.where((t) => t.alias.toLowerCase().contains(needle)).toList();
  }
}
