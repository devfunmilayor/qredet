import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../home/domain/usecases/get_transactions.dart';
import 'transactions_list_event.dart';
import 'transactions_list_state.dart';

const _pageSize = 15;

/// Powers the "See all" page. Reuses [GetTransactions] from `home`'s domain
/// layer — `home_mock_data_source.dart` stays the single source of truth
/// for the 50 mock rows rather than forking a second usecase/repository.
@injectable
class TransactionsListBloc extends Bloc<TransactionsListEvent, TransactionsListState> {
  TransactionsListBloc(this._getTransactions) : super(const TransactionsListState()) {
    on<TransactionsListStarted>(_onStarted);
    on<TransactionsListMoreRequested>(_onMoreRequested);
    on<TransactionsListSearched>(_onSearched);
  }

  final GetTransactions _getTransactions;
  int _page = 1;

  Future<void> _onStarted(TransactionsListStarted event, Emitter<TransactionsListState> emit) async {
    _page = 1;
    emit(state.copyWith(status: TransactionsListStatus.loading));
    final result = await _getTransactions(const GetTransactionsParams(page: 1, pageSize: _pageSize));
    result.match(
      (failure) => emit(state.copyWith(status: TransactionsListStatus.error, failure: failure)),
      (page) => emit(
        state.copyWith(status: TransactionsListStatus.loaded, items: page.items, hasMore: page.hasMore),
      ),
    );
  }

  Future<void> _onMoreRequested(TransactionsListMoreRequested event, Emitter<TransactionsListState> emit) async {
    if (!state.hasMore || state.isLoadingMore) return;
    emit(state.copyWith(isLoadingMore: true));
    final result = await _getTransactions(GetTransactionsParams(page: _page + 1, pageSize: _pageSize));
    result.match(
      (failure) => emit(state.copyWith(isLoadingMore: false)),
      (page) {
        _page++;
        emit(
          state.copyWith(items: [...state.items, ...page.items], hasMore: page.hasMore, isLoadingMore: false),
        );
      },
    );
  }

  void _onSearched(TransactionsListSearched event, Emitter<TransactionsListState> emit) {
    emit(state.copyWith(query: event.query));
  }
}
