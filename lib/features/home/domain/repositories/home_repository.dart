import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/transactions_page.dart';
import '../entities/wallet_summary.dart';

abstract class HomeRepository {
  Future<Either<Failure, WalletSummary>> getWalletSummary();

  Future<Either<Failure, TransactionsPage>> getTransactions({required int page, required int pageSize});
}
