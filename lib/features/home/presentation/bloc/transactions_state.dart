import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qredet/core/error/failure.dart';
import 'package:qredet/features/home/domain/entities/transaction.dart';

part 'transactions_state.freezed.dart';

@freezed
sealed class TransactionsState with _$TransactionsState {
  const factory TransactionsState.loading() = TransactionsLoading;
  const factory TransactionsState.loaded(List<Transaction> transactions) =
      TransactionsLoaded;
  const factory TransactionsState.empty() = TransactionsEmpty;
  const factory TransactionsState.error(Failure failure) = TransactionsError;
}
