import 'package:equatable/equatable.dart';

class Language extends Equatable {
  const Language({
    required this.code,
    required this.label,
    required this.flagEmoji,
  });

  final String code;

  final String label;

  final String flagEmoji;

  @override
  List<Object?> get props => [code, label, flagEmoji];
}
