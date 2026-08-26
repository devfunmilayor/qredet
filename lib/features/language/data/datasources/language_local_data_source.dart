import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/language.dart';
import 'language_catalog.dart';

const _settingsKey = 'selected_language_code';

@lazySingleton
class LanguageLocalDataSource {
  const LanguageLocalDataSource(this._settingsBox);

  final Box<String> _settingsBox;

  List<Language> getLanguages() => supportedLanguages;

  Language getSelectedLanguage() {
    final code = _settingsBox.get(_settingsKey);
    return supportedLanguages.firstWhere(
      (language) => language.code == code,
      orElse: () => supportedLanguages.first,
    );
  }

  Future<Language> setLanguage(Language language) async {
    await _settingsBox.put(_settingsKey, language.code);
    return language;
  }
}
