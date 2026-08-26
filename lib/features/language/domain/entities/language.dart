import 'package:equatable/equatable.dart';

/// One of the 20 languages the app ships UI copy for.
class Language extends Equatable {
  const Language({required this.code, required this.label, required this.flagEmoji});

  /// ISO 639-1 code, matches an `app_<code>.arb` file under `core/l10n/arb`.
  final String code;

  /// Endonym shown in the picker, e.g. "Français" not "French".
  final String label;

  final String flagEmoji;

  @override
  List<Object?> get props => [code, label, flagEmoji];
}
