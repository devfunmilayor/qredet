import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qredet/core/error/failure.dart';
import 'package:qredet/core/usecase/usecase.dart';
import 'package:qredet/features/home/domain/entities/transactions_page.dart';
import 'package:qredet/features/home/domain/repositories/home_repository.dart';

class GetTransactionsParams extends Equatable {
  const GetTransactionsParams({required this.page, required this.pageSize});

  final int page;
  final int pageSize;

  @override
  List<Object?> get props => [page, pageSize];
}

@lazySingleton
class GetTransactions
    implements UseCase<TransactionsPage, GetTransactionsParams> {
  const GetTransactions(this._repository);

  final HomeRepository _repository;

  @override
  Future<Either<Failure, TransactionsPage>> call(GetTransactionsParams params) {
    return _repository.getTransactions(
      page: params.page,
      pageSize: params.pageSize,
    );
  }
}
