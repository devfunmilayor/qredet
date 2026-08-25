import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/error.dart';
import '../../domain/entities/transactions_page.dart';
import '../../domain/entities/wallet_summary.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_data_source.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this._dataSource);

  final HomeDataSource _dataSource;

  @override
  Future<Either<Failure, WalletSummary>> getWalletSummary() async {
    try {
      return Right(await _dataSource.getWalletSummary());
    } catch (e) {
      return Left(_toFailure(e));
    }
  }

  @override
  Future<Either<Failure, TransactionsPage>> getTransactions({required int page, required int pageSize}) async {
    try {
      return Right(await _dataSource.getTransactions(page: page, pageSize: pageSize));
    } catch (e) {
      return Left(_toFailure(e));
    }
  }

  /// [ErrorInterceptor] already maps Dio errors onto `DioException.error`;
  /// reuse that instead of re-deriving it from `error.type`.
  Failure _toFailure(Object error) {
    if (error is DioException && error.error is Failure) return error.error as Failure;
    return mapExceptionToFailure(error);
  }
}
