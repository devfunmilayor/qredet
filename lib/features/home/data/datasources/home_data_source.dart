import '../../domain/entities/transactions_page.dart';
import '../../domain/entities/wallet_summary.dart';

/// Implemented by both [HomeMockDataSource] and [HomeHttpDataSource] so
/// [HomeRepositoryImpl] — and everything above it — never knows which one
/// is answering.
abstract class HomeDataSource {
  Future<WalletSummary> getWalletSummary();

  Future<TransactionsPage> getTransactions({required int page, required int pageSize});
}
