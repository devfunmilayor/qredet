import 'package:equatable/equatable.dart';

class UpgradeTier extends Equatable {
  const UpgradeTier({required this.name, required this.price, required this.limitDescription});

  final String name;
  final String price;
  final String limitDescription;

  @override
  List<Object?> get props => [name, price, limitDescription];
}
