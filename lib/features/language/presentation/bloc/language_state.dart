import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qredet/features/language/domain/entities/language.dart';

part 'language_state.freezed.dart';

@freezed
sealed class LanguageState with _$LanguageState {
  const factory LanguageState.initial() = LanguageInitial;
  const factory LanguageState.loaded({
    required List<Language> languages,
    required Language selected,
  }) = LanguageLoaded;
}
