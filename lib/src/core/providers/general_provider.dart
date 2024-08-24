import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());

final internetConnectionCheckerProvider =
    Provider<InternetConnectionChecker>((ref) => InternetConnectionChecker());

final clientProvider = Provider<Client>((ref) => Client());
