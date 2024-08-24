import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/errors/errors.dart';

class PrayerTimeRemoteDataSource {
  final Client client;

  PrayerTimeRemoteDataSource(this.client);

  Future<List<String>> getPrayerTimes() => _getPrayerTimesFromUrl("https://seerah-backend.seerah.kz/api/v2/cities/top");

  Future<List<String>> _getPrayerTimesFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMzNhYjFhNzUtZDc4MS00NmM0LWIyMGYtNTkyNTE1NjUzNTk5IiwiZmNtX3Rva2VuIjoic29tZV90b2tlbiIsInR5cCI6IkJlYXJlciIsInN1YiI6IjMzYWIxYTc1LWQ3ODEtNDZjNC1iMjBmLTU5MjUxNTY1MzU5OSIsImlhdCI6MTcyMjA3MjY3OSwiZXhwIjoxNzIyMTU5MDc5fQ.eLeEzKn7sXfwhySuLgtA9MVN7MiqqHru89MvxxrazBM'
      },
    );
    print(response.body);

    if (response.statusCode == 200) {
      final prayerTimes = jsonDecode(response.body);
      return (prayerTimes["result"] as List<String>);
    } else {
      throw ServerException();
    }
  }
}
