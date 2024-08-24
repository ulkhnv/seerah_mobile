import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/constants.dart';
import 'core/providers/providers.dart';
import 'core/utils/utils.dart';
import 'features/home/home.dart';

class SeerahApp extends ConsumerWidget {
  const SeerahApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    final language = ref.watch(languageNotifierProvider);
    return MaterialApp(
      title: "Seerah",
      debugShowCheckedModeBanner: false,
      locale: Locale(language),
      supportedLocales: S.supportedLocales,
      localizationsDelegates: S.localizationDelegates,
      theme: lightTheme,
      home: const HomePage(),
    );
  }
}

ThemeData lightTheme = ThemeData(
  fontFamily: "Rubik",
  useMaterial3: false,
  scaffoldBackgroundColor: lightGrey,
  appBarTheme: const AppBarTheme(centerTitle: true),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
    ),
    bodySmall: TextStyle(
      fontSize: 13,
    ),
  ),
);
