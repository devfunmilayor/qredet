import 'package:fpdart/fpdart.dart';
import 'package:qredet/core/error/failure.dart';
import 'package:qredet/features/home/domain/entities/transactions_page.dart';
import 'package:qredet/features/home/domain/entities/wallet_summary.dart';

abstract class HomeRepository {
  Future<Either<Failure, WalletSummary>> getWalletSummary();

  Future<Either<Failure, TransactionsPage>> getTransactions({
    required int page,
    required int pageSize,
  });
}
