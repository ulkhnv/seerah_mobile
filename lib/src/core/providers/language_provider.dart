import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/settings/data/datasources/datasources.dart';
import 'general_provider.dart';

final languageLocalDataSourceProvider = Provider<LanguageLocalDataSource>((ref) {
  final sharedPreferences = ref.read(sharedPreferencesProvider);
  return LanguageLocalDataSource(sharedPreferences);
});

class LanguageNotifier extends StateNotifier<String> {
  final LanguageLocalDataSource _languageLocalDataSource;

  LanguageNotifier(this._languageLocalDataSource) : super("kk") {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final languageCode = await _languageLocalDataSource.getLanguage();
    state = languageCode;
  }

  Future<void> setLanguage(String languageCode) async {
    await _languageLocalDataSource.setLanguage(languageCode);
    state = languageCode;
  }
}

final languageNotifierProvider = StateNotifierProvider<LanguageNotifier, String>((ref) {
  final languageLocalDataSource = ref.read(languageLocalDataSourceProvider);
  return LanguageNotifier(languageLocalDataSource);
});