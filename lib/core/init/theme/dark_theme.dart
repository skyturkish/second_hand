import 'package:flutter/material.dart';

class AvailableThemes {
  static final AvailableThemes instance = AvailableThemes._internal();

  factory AvailableThemes() {
    return instance;
  }

  AvailableThemes._internal();

  final ThemeData darkTheme = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      //titleTextStyle: TextStyle(color: Colors.black87),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );

  final ThemeData lighTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.grey,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}
