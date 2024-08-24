import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';

const _cachedCity = "cachedCity";
const _cachedCities = "cachedCities";

class CityLocalDataSource {
  final SharedPreferences _sharedPreferences;

  CityLocalDataSource(this._sharedPreferences);

  Future<City> getCity() {
    final jsonCity = _sharedPreferences.getString(_cachedCity);
    if (jsonCity != null) {
      return Future.value(
          City.fromJson(jsonDecode(jsonCity) as Map<String, dynamic>));
    }
    return Future.value(
        const City(name: "Алматы, Казакстан", timezone: "5", slug: "Almaty"));
  }

  Future<void> setCity(City city) {
    return _sharedPreferences.setString(_cachedCity, jsonEncode(city));
  }

  Future<List<City>> getCities() {
    final jsonCities = _sharedPreferences.getStringList(_cachedCities);
    if (jsonCities!.isNotEmpty) {
      return Future.value(jsonCities
          .map(
              (city) => City.fromJson(jsonDecode(city) as Map<String, dynamic>))
          .toList());
    }
    return Future.value([]);
  }

  Future<void> setCities(List<City> cities) {
    List<String> jsonCities = cities.map((city) => jsonEncode(city)).toList();
    return _sharedPreferences.setStringList(_cachedCities, jsonCities);
  }
}
