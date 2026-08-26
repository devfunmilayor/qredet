import 'package:qredet/features/home/domain/entities/transactions_page.dart';
import 'package:qredet/features/home/domain/entities/wallet_summary.dart';

abstract class HomeDataSource {
  Future<WalletSummary> getWalletSummary();

  Future<TransactionsPage> getTransactions({
    required int page,
    required int pageSize,
  });
}
