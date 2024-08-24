import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/settings/data/models/models.dart';
import '../../features/settings/data/repositories/repositories.dart';
import 'city_provider.dart';

class CityNotifier extends StateNotifier<City> {
  final CityRepository _cityRepository;

  CityNotifier(this._cityRepository)
      : super(const City(name: "Алматы", timezone: "5", slug: "Almaty")) {
    _loadCity();
  }

  Future<void> _loadCity() async {
    final city = await _cityRepository.getCity();
    state = city;
  }

  Future<void> setCity(City city) async {
    await _cityRepository.setCity(city);
    state = city;
  }
}

final cityNotifierProvider =
StateNotifierProvider<CityNotifier, City>((ref) {
  final cityRepository = ref.read(cityRepositoryProvider);
  return CityNotifier(cityRepository);
});
