import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/wallet_summary.dart';
import '../repositories/home_repository.dart';

@lazySingleton
class GetWalletSummary implements UseCase<WalletSummary, NoParams> {
  const GetWalletSummary(this._repository);

  final HomeRepository _repository;

  @override
  Future<Either<Failure, WalletSummary>> call(NoParams params) =>
      _repository.getWalletSummary();
}
