import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qredet/core/error/failure.dart';
import 'package:qredet/core/usecase/usecase.dart';
import 'package:qredet/features/home/domain/entities/wallet_summary.dart';
import 'package:qredet/features/home/domain/repositories/home_repository.dart';

@lazySingleton
class GetWalletSummary implements UseCase<WalletSummary, NoParams> {
  const GetWalletSummary(this._repository);

  final HomeRepository _repository;

  @override
  Future<Either<Failure, WalletSummary>> call(NoParams params) =>
      _repository.getWalletSummary();
}
