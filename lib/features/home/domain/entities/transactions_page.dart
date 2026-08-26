import 'package:equatable/equatable.dart';
import 'package:qredet/features/home/domain/entities/transaction.dart';

class TransactionsPage extends Equatable {
  const TransactionsPage({required this.items, required this.hasMore});

  final List<Transaction> items;
  final bool hasMore;

  @override
  List<Object?> get props => [items, hasMore];
}
