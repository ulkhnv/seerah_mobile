import 'package:http/http.dart';

import '../models/models.dart';

class CityRemoteDataSource {
  final Client _client;

  final List<City> cities = [
    const City(name: "Алматы", timezone: "5", slug: "Almaty"),
    const City(name: "Астана", timezone: "5", slug: "Astana"),
    const City(name: "Шымкент", timezone: "5", slug: "Shymkent"),
  ];

  CityRemoteDataSource(this._client);

  Future<List<City>> getCities() =>
      _getCitiesFromUrl("https://seerah.kz/backend/api/salah/cities?limit=200");

  Future<List<City>> _getCitiesFromUrl(String url) async {
    /*
    final response = await _client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    if (response.statusCode == 200) {
      final cities = jsonDecode(response.body);
      return (cities["result"] as List)
          .map((city) => City.fromJson(city as Map<String, dynamic>))
          .toList();
    } else {
      return [];
    }
     */
    return Future.delayed(const Duration(milliseconds: 1000), () {
      return Future.value(cities);
    });
  }
}
