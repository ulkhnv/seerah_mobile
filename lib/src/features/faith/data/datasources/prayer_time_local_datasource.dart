import 'package:shared_preferences/shared_preferences.dart';

const _cachedPrayerTimes = 'cachedPrayerTimes';

class PrayerTimeLocalDataSource {
  final SharedPreferences sharedPreferences;

  PrayerTimeLocalDataSource(this.sharedPreferences);

  Future<List<String>> getPrayerTimes() {
    final prayerTimes = sharedPreferences.getStringList(_cachedPrayerTimes);
    if (prayerTimes!.isNotEmpty) {
      return Future.value(prayerTimes);
    }
    return Future.value([]);
  }

  Future<void> setPrayerTimes(List<String> prayerTimes) {
    return sharedPreferences.setStringList(_cachedPrayerTimes, prayerTimes);
  }
}
