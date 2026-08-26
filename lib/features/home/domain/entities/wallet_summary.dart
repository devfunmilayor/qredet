import 'package:equatable/equatable.dart';
import 'package:qredet/features/home/domain/entities/virtual_account.dart';

class WalletSummary extends Equatable {
  const WalletSummary({required this.balance, required this.virtualAccount});

  final num balance;
  final VirtualAccount virtualAccount;

  @override
  List<Object?> get props => [balance, virtualAccount];
}
