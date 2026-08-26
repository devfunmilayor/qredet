import 'package:equatable/equatable.dart';

enum UpgradeTierType { basic, standard, premium }

class UpgradeTier extends Equatable {
  const UpgradeTier({required this.type});

  final UpgradeTierType type;

  @override
  List<Object?> get props => [type];
}
