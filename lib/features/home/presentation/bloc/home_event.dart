import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.freezed.dart';

@freezed
sealed class HomeEvent with _$HomeEvent {
  const factory HomeEvent.started() = HomeStarted;
  const factory HomeEvent.refreshed() = HomeRefreshed;
  const factory HomeEvent.balanceRetried() = BalanceRetried;
  const factory HomeEvent.transactionsRetried() = TransactionsRetried;
}
