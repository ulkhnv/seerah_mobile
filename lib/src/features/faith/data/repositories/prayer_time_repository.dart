import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../datasources/datasources.dart';
import '../models/prayer_time.dart';

class PrayerTimeRepository {
  final PrayerTimeRemoteDataSource _prayerTimeRemoteDataSource;
  final PrayerTimeLocalDataSource _prayerTimeLocalDataSource;
  final InternetConnectionChecker _internetConnectionChecker;

  PrayerTimeRepository(this._prayerTimeRemoteDataSource,
      this._internetConnectionChecker, this._prayerTimeLocalDataSource);

  Future<List<PrayerTime>> getPrayerTimes() async {
    if (await _internetConnectionChecker.hasConnection) {
      final prayerTimes = await _prayerTimeRemoteDataSource.getPrayerTimes();
      _prayerTimeLocalDataSource.setPrayerTimes(prayerTimes);
      return _getPrayerTimes(prayerTimes);
    }
    return _getPrayerTimes(await _prayerTimeLocalDataSource.getPrayerTimes());
  }
}

List<PrayerTime> _getPrayerTimes(List<String> prayerTimes) {
  final current = _getCurrentPrayerTime(prayerTimes);
  List<PrayerTime> result = [];
  for (var i = 0; i < 6; i++) {
    String time = prayerTimes[i];
    if (i == current) {
      result.add(PrayerTime(time, true, true));
    } else if (i > current) {
      result.add(PrayerTime(time, true, false));
    } else {
      result.add(PrayerTime(time, false, false));
    }
  }
  return result;
}

int _getCurrentPrayerTime(List<String> prayerTimes) {
  final currentTime = TimeOfDay.now();

  for (int i = 5; i >= 0; i--) {
    final parsedTime = TimeOfDay(
      hour: int.parse(prayerTimes[i].split(":")[0]),
      minute: int.parse(prayerTimes[i].split(":")[1]),
    );

    if (currentTime.hour > parsedTime.hour ||
        (currentTime.hour == parsedTime.hour &&
            currentTime.minute >= parsedTime.minute)) {
      return i;
    }
  }
  return 5;
}
