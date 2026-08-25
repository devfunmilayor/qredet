import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/language.dart';

part 'language_event.freezed.dart';

@freezed
sealed class LanguageEvent with _$LanguageEvent {
  const factory LanguageEvent.started() = LanguageStarted;
  const factory LanguageEvent.changed(Language language) = LanguageChanged;
}
