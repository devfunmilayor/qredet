import 'package:equatable/equatable.dart';

enum TransactionType { credit, debit }

class Transaction extends Equatable {
  const Transaction({
    required this.id,
    required this.alias,
    required this.amount,
    required this.date,
    required this.type,
  });

  final String id;
  final String alias;
  final num amount;
  final DateTime date;
  final TransactionType type;

  @override
  List<Object?> get props => [id, alias, amount, date, type];
}
