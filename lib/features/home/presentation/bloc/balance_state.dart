import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/wallet_summary.dart';

part 'balance_state.freezed.dart';

@freezed
sealed class BalanceState with _$BalanceState {
  const factory BalanceState.loading() = BalanceLoading;
  const factory BalanceState.loaded(WalletSummary summary) = BalanceLoaded;
  const factory BalanceState.error(Failure failure) = BalanceError;
}
