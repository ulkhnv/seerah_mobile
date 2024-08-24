import 'package:shared_preferences/shared_preferences.dart';

const _cachedLanguage = 'cachedLanguage';

class LanguageLocalDataSource {
  final SharedPreferences _sharedPreferences;

  LanguageLocalDataSource(this._sharedPreferences);

  Future<String> getLanguage() {
    final language = _sharedPreferences.getString(_cachedLanguage);
    if (language != null) {
      return Future.value(language);
    }
    return Future.value("kk");
  }

  Future<void> setLanguage(String language) {
    return _sharedPreferences.setString(_cachedLanguage, language);
  }
}
