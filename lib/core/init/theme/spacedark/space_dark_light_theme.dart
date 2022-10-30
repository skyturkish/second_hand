import 'package:flutter/material.dart';
import 'package:second_hand/core/init/theme/app_theme.dart';

class SpaceDarkTheme implements AppTheme {
  static final SpaceDarkTheme instance = SpaceDarkTheme._internal();

  factory SpaceDarkTheme() {
    return instance;
  }

  SpaceDarkTheme._internal();

  @override
  ThemeData? get theme => ThemeData.dark().copyWith(
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(133, 83, 92, 145),
          elevation: 10,
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: const Color.fromARGB(133, 94, 106, 175),
          onPrimary: Colors.white,
          secondary: const Color.fromARGB(133, 83, 92, 145),
          onSecondary: Colors.black,
          error: const Color.fromARGB(255, 214, 98, 90),
          onError: Colors.black87,
          background: Colors.grey,
          onBackground: Colors.black.withAlpha(150),
          surface: const Color.fromARGB(255, 90, 87, 87),
          onSurface: const Color.fromARGB(255, 212, 206, 206),
        ),
      );
}
