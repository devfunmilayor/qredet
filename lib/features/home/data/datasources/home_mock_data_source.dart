import 'package:injectable/injectable.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/transactions_page.dart';
import '../../domain/entities/virtual_account.dart';
import '../../domain/entities/wallet_summary.dart';
import 'home_data_source.dart';

const _mockTransactionCount = 50;
const _mockAliases = ['Ada Lovelace', 'Grace Hopper', 'Alan Turing', 'Katherine Johnson', 'John Backus'];

@lazySingleton
class HomeMockDataSource implements HomeDataSource {
  const HomeMockDataSource();

  @override
  Future<WalletSummary> getWalletSummary() async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    return const WalletSummary(
      balance: 10000,
      virtualAccount: VirtualAccount(bankName: 'UBA Bank', accountNumber: '0123456789'),
    );
  }

  @override
  Future<TransactionsPage> getTransactions({required int page, required int pageSize}) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    final all = List.generate(_mockTransactionCount, _mockTransactionAt);
    final start = (page - 1) * pageSize;
    if (start >= all.length) return const TransactionsPage(items: [], hasMore: false);
    final end = (start + pageSize).clamp(0, all.length);
    return TransactionsPage(items: all.sublist(start, end), hasMore: end < all.length);
  }

  Transaction _mockTransactionAt(int index) {
    return Transaction(
      id: 'txn_$index',
      alias: _mockAliases[index % _mockAliases.length],
      amount: 500 + (index * 137) % 5000,
      date: DateTime(2025, 5, 21, 16, 1).subtract(Duration(days: index)),
      type: index.isEven ? TransactionType.debit : TransactionType.credit,
    );
  }
}
