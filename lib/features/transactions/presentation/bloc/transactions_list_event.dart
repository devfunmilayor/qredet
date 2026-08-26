import 'package:freezed_annotation/freezed_annotation.dart';

part 'transactions_list_event.freezed.dart';

@freezed
sealed class TransactionsListEvent with _$TransactionsListEvent {
  const factory TransactionsListEvent.started() = TransactionsListStarted;
  const factory TransactionsListEvent.moreRequested() =
      TransactionsListMoreRequested;
  const factory TransactionsListEvent.searched(String query) =
      TransactionsListSearched;
}
