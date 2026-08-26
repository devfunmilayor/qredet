import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:qredet/features/home/domain/entities/transaction.dart';
import 'package:qredet/features/home/domain/entities/transactions_page.dart';
import 'package:qredet/features/home/domain/entities/virtual_account.dart';
import 'package:qredet/features/home/domain/entities/wallet_summary.dart';
import 'package:qredet/features/home/data/datasources/home_data_source.dart';

@lazySingleton
class HomeHttpDataSource implements HomeDataSource {
  const HomeHttpDataSource(this._dio);

  final Dio _dio;

  @override
  Future<WalletSummary> getWalletSummary() async {
    final response = await _dio.get<Map<String, dynamic>>('/wallet/summary');
    final json = response.data!;
    return WalletSummary(
      balance: json['balance'] as num,
      virtualAccount: VirtualAccount(
        bankName: json['bank_name'] as String,
        accountNumber: json['account_number'] as String,
      ),
    );
  }

  @override
  Future<TransactionsPage> getTransactions({
    required int page,
    required int pageSize,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/wallet/transactions',
      queryParameters: {'page': page, 'page_size': pageSize},
    );
    final json = response.data!;
    final items = (json['items'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(
          (item) => Transaction(
            id: item['id'] as String,
            alias: item['alias'] as String,
            amount: item['amount'] as num,
            date: DateTime.parse(item['date'] as String),
            type: TransactionType.values.byName(item['type'] as String),
          ),
        )
        .toList();
    return TransactionsPage(items: items, hasMore: json['has_more'] as bool);
  }
}
