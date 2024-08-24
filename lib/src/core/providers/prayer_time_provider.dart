import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seerah_mobile/src/core/providers/providers.dart';

import '../../features/faith/data/datasources/datasources.dart';
import '../../features/faith/data/models/prayer_time.dart';
import '../../features/faith/data/repositories/repositories.dart';

final prayerTimeRemoteDataSourceProvider =
    Provider<PrayerTimeRemoteDataSource>((ref) {
  final client = ref.watch(clientProvider);
  return PrayerTimeRemoteDataSource(client);
});

final prayerTimeLocalDataSourceProvider =
    Provider<PrayerTimeLocalDataSource>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return PrayerTimeLocalDataSource(sharedPreferences);
});

final prayerTimeRepositoryProvider = Provider<PrayerTimeRepository>((ref) {
  final prayerTimeRemoteDataSource =
      ref.read(prayerTimeRemoteDataSourceProvider);
  final prayerTimeLocalDataSource = ref.watch(prayerTimeLocalDataSourceProvider);
  final internetConnectionChecker = ref.watch(internetConnectionCheckerProvider);
  return PrayerTimeRepository(prayerTimeRemoteDataSource,
      internetConnectionChecker, prayerTimeLocalDataSource);
});

final prayerTimesProvider = FutureProvider<List<PrayerTime>>((ref) async {
  final prayerTimeRepository = ref.watch(prayerTimeRepositoryProvider);
  return await prayerTimeRepository.getPrayerTimes();
});

