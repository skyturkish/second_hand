import 'package:flutter/material.dart';
import 'package:second_hand/core/init/theme/app_theme.dart';

class LightTheme implements AppTheme {
  static final LightTheme instance = LightTheme._internal();

  factory LightTheme() {
    return instance;
  }

  LightTheme._internal();
  @override
  ThemeData? theme = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}
