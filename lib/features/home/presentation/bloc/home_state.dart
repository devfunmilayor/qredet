import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qredet/features/home/presentation/bloc/balance_state.dart';
import 'package:qredet/features/home/presentation/bloc/transactions_state.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    required BalanceState balance,
    required TransactionsState transactions,
    @Default(false) bool isRefreshing,
  }) = _HomeState;

  factory HomeState.initial() => const HomeState(
    balance: BalanceState.loading(),
    transactions: TransactionsState.loading(),
  );
}
