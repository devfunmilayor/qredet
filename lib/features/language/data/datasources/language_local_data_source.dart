import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/language.dart';

const _prefsKey = 'selected_language_code';

const supportedLanguages = <Language>[
  Language(code: 'en', label: 'English', flagEmoji: '🇬🇧'),
  Language(code: 'zh', label: '中文', flagEmoji: '🇨🇳'),
  Language(code: 'hi', label: 'हिन्दी', flagEmoji: '🇮🇳'),
  Language(code: 'es', label: 'Español', flagEmoji: '🇪🇸'),
  Language(code: 'fr', label: 'Français', flagEmoji: '🇫🇷'),
  Language(code: 'ar', label: 'العربية', flagEmoji: '🇸🇦'),
  Language(code: 'bn', label: 'বাংলা', flagEmoji: '🇧🇩'),
  Language(code: 'pt', label: 'Português', flagEmoji: '🇵🇹'),
  Language(code: 'ru', label: 'Русский', flagEmoji: '🇷🇺'),
  Language(code: 'ur', label: 'اردو', flagEmoji: '🇵🇰'),
  Language(code: 'id', label: 'Bahasa Indonesia', flagEmoji: '🇮🇩'),
  Language(code: 'de', label: 'Deutsch', flagEmoji: '🇩🇪'),
  Language(code: 'ja', label: '日本語', flagEmoji: '🇯🇵'),
  Language(code: 'sw', label: 'Kiswahili', flagEmoji: '🇹🇿'),
  Language(code: 'mr', label: 'मराठी', flagEmoji: '🇮🇳'),
  Language(code: 'te', label: 'తెలుగు', flagEmoji: '🇮🇳'),
  Language(code: 'tr', label: 'Türkçe', flagEmoji: '🇹🇷'),
  Language(code: 'ta', label: 'தமிழ்', flagEmoji: '🇮🇳'),
  Language(code: 'vi', label: 'Tiếng Việt', flagEmoji: '🇻🇳'),
  Language(code: 'ko', label: '한국어', flagEmoji: '🇰🇷'),
];

@lazySingleton
class LanguageLocalDataSource {
  const LanguageLocalDataSource(this._prefs);

  final SharedPreferences _prefs;

  List<Language> getLanguages() => supportedLanguages;

  Language getSelectedLanguage() {
    final code = _prefs.getString(_prefsKey);
    return supportedLanguages.firstWhere(
      (language) => language.code == code,
      orElse: () => supportedLanguages.first,
    );
  }

  Future<Language> setLanguage(Language language) async {
    await _prefs.setString(_prefsKey, language.code);
    return language;
  }
}
