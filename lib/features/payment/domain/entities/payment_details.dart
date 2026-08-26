import 'package:equatable/equatable.dart';

class PaymentDetails extends Equatable {
  const PaymentDetails({
    required this.recipientName,
    required this.bankName,
    required this.accountNumber,
    required this.amount,
  });

  final String recipientName;
  final String bankName;
  final String accountNumber;
  final num amount;

  @override
  List<Object?> get props => [recipientName, bankName, accountNumber, amount];
}
