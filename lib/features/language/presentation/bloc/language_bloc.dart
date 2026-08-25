import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/get_languages.dart';
import '../../domain/usecases/get_selected_language.dart';
import '../../domain/usecases/set_language.dart';
import 'language_event.dart';
import 'language_state.dart';

@injectable
class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc(this._getLanguages, this._getSelectedLanguage, this._setLanguage) : super(const LanguageState.initial()) {
    on<LanguageStarted>(_onStarted);
    on<LanguageChanged>(_onChanged);
  }

  final GetLanguages _getLanguages;
  final GetSelectedLanguage _getSelectedLanguage;
  final SetLanguage _setLanguage;

  Future<void> _onStarted(LanguageStarted event, Emitter<LanguageState> emit) async {
    final languagesResult = await _getLanguages(const NoParams());
    final selectedResult = await _getSelectedLanguage(const NoParams());

    languagesResult.match(
      (_) {},
      (languages) => selectedResult.match(
        (_) {},
        (selected) => emit(LanguageState.loaded(languages: languages, selected: selected)),
      ),
    );
  }

  Future<void> _onChanged(LanguageChanged event, Emitter<LanguageState> emit) async {
    final current = state;
    if (current is! LanguageLoaded) return;

    final result = await _setLanguage(event.language);
    result.match(
      (_) {},
      (selected) => emit(current.copyWith(selected: selected)),
    );
  }
}
