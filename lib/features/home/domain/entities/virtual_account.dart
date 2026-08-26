import 'package:equatable/equatable.dart';

class VirtualAccount extends Equatable {
  const VirtualAccount({required this.bankName, required this.accountNumber});

  final String bankName;
  final String accountNumber;

  @override
  List<Object?> get props => [bankName, accountNumber];
}
