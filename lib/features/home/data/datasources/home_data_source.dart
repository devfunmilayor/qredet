import '../../domain/entities/transactions_page.dart';
import '../../domain/entities/wallet_summary.dart';

abstract class HomeDataSource {
  Future<WalletSummary> getWalletSummary();

  Future<TransactionsPage> getTransactions({
    required int page,
    required int pageSize,
  });
}
