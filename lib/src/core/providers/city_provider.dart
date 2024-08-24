import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seerah_mobile/src/core/providers/general_provider.dart';

import '../../features/settings/data/datasources/datasources.dart';
import '../../features/settings/data/models/models.dart';
import '../../features/settings/data/repositories/repositories.dart';

final cityRemoteDataSourceProvider = Provider<CityRemoteDataSource>((ref) {
  final client = ref.watch(clientProvider);
  return CityRemoteDataSource(client);
});

final cityLocalDataSourceProvider = Provider<CityLocalDataSource>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return CityLocalDataSource(sharedPreferences);
});

final cityRepositoryProvider = Provider<CityRepository>(
  (ref) {
    final cityRemoteDataSource = ref.watch(cityRemoteDataSourceProvider);
    final cityLocalDataSource = ref.watch(cityLocalDataSourceProvider);
    final internetConnectionChecker =
        ref.read(internetConnectionCheckerProvider);

    return CityRepository(
        cityRemoteDataSource, internetConnectionChecker, cityLocalDataSource);
  },
);

final cityListProvider = FutureProvider<List<City>>((ref) async {
  final cityRepository = ref.watch(cityRepositoryProvider);
  return await cityRepository.getCities();
});