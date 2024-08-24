import 'dart:convert';

import 'package:seerah_mobile/src/features/tasbih/data/models/tasbih.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _cachedTasbih = "cachedTasbih";

class TasbihLocalDataSource {
  final SharedPreferences _sharedPreferences;

  TasbihLocalDataSource({required SharedPreferences sharedPreferences}) : _sharedPreferences = sharedPreferences;

  Future<Tasbih> getTasbih() {
    final jsonTasbih = _sharedPreferences.getString(_cachedTasbih);
    if (jsonTasbih != null) {
      return Future.value(
          Tasbih.fromJson(jsonDecode(jsonTasbih) as Map<String, dynamic>));
    }
    return Future.value(Tasbih(aim: 33, dhikr: 0));
  }

  Future<void> setTasbih(Tasbih tasbih) {
    print("SET TASBIH");
    return _sharedPreferences.setString(
        _cachedTasbih, jsonEncode(tasbih.toJson()));
  }
}
