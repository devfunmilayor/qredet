import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/get_transactions.dart';
import '../../domain/usecases/get_wallet_summary.dart';
import 'balance_state.dart';
import 'home_event.dart';
import 'home_state.dart';
import 'transactions_state.dart';

const _homePageSize = 8;

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._getWalletSummary, this._getTransactions)
    : super(HomeState.initial()) {
    on<HomeStarted>((event, emit) => _loadAll(emit));
    on<HomeRefreshed>(_onRefreshed);
    on<BalanceRetried>((event, emit) => _loadBalance(emit));
    on<TransactionsRetried>((event, emit) => _loadTransactions(emit));
  }

  final GetWalletSummary _getWalletSummary;
  final GetTransactions _getTransactions;

  Future<void> _loadAll(Emitter<HomeState> emit, {bool silent = false}) {
    return Future.wait([
      _loadBalance(emit, silent: silent),
      _loadTransactions(emit, silent: silent),
    ]);
  }

  Future<void> _onRefreshed(
    HomeRefreshed event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isRefreshing: true));
    await _loadAll(emit, silent: true);
    emit(state.copyWith(isRefreshing: false));
  }

  Future<void> _loadBalance(
    Emitter<HomeState> emit, {
    bool silent = false,
  }) async {
    if (!silent) emit(state.copyWith(balance: const BalanceState.loading()));
    final result = await _getWalletSummary(const NoParams());
    result.match(
      (failure) => emit(state.copyWith(balance: BalanceState.error(failure))),
      (summary) => emit(state.copyWith(balance: BalanceState.loaded(summary))),
    );
  }

  Future<void> _loadTransactions(
    Emitter<HomeState> emit, {
    bool silent = false,
  }) async {
    if (!silent) {
      emit(state.copyWith(transactions: const TransactionsState.loading()));
    }
    final result = await _getTransactions(
      const GetTransactionsParams(page: 1, pageSize: _homePageSize),
    );
    result.match(
      (failure) =>
          emit(state.copyWith(transactions: TransactionsState.error(failure))),
      (page) => emit(
        state.copyWith(
          transactions: page.items.isEmpty
              ? const TransactionsState.empty()
              : TransactionsState.loaded(page.items),
        ),
      ),
    );
  }
}
