import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../datasources/datasources.dart';
import '../models/models.dart';

class CityRepository {
  final CityRemoteDataSource _cityRemoteDataSource;
  final CityLocalDataSource _cityLocalDataSource;
  final InternetConnectionChecker _internetConnectionChecker;

  CityRepository(this._cityRemoteDataSource, this._internetConnectionChecker,
      this._cityLocalDataSource);

  Future<City> getCity() {
    return _cityLocalDataSource.getCity();
  }

  Future<void> setCity(City city) {
    return _cityLocalDataSource.setCity(city);
  }

  Future<List<City>> getCities() async {
    if (await _internetConnectionChecker.hasConnection) {
      final cities = await _cityRemoteDataSource.getCities();
      _cityLocalDataSource.setCities(cities);
      return cities;
    }
    return _cityLocalDataSource.getCities();
  }
}
