import 'package:flutter/material.dart';
import 'package:second_hand/core/constants/enums/app_theme_enum.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      //titleTextStyle: TextStyle(color: Colors.black87),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );

  AppThemes _currenThemeEnum = AppThemes.DARK;

  /// Applicaton theme enum.
  /// Deafult value is [AppThemes.LIGHT]
  AppThemes get currentThemeEnum => _currenThemeEnum;

  ThemeData get currentTheme => _currentTheme;

  void changeTheme() {
    final theme = currentThemeEnum;
    if (theme == AppThemes.LIGHT) {
      _currentTheme = ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          // titleTextStyle: TextStyle(color: Colors.black87),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
      _currenThemeEnum = AppThemes.DARK;
    } else if (theme == AppThemes.DARK) {
      _currentTheme = ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
      _currenThemeEnum = AppThemes.LIGHT;
    } // else if (theme == AppThemes.CUSTOM_DARK) {
    // _currentTheme = ThemeData.dark().copyWith(
    //   appBarTheme: const AppBarTheme(
    //     titleTextStyle: TextStyle(color: Colors.black87),
    //     backgroundColor: Colors.transparent,
    //     elevation: 0,
    //   ),
    //   textSelectionTheme: const TextSelectionThemeData(
    //     cursorColor: Colors.red,
    //   ),
    //   inputDecorationTheme: const InputDecorationTheme(
    //     hintStyle: TextStyle(color: Colors.black),
    //     labelStyle: TextStyle(color: Colors.black),
    //     iconColor: Color.fromARGB(255, 14, 13, 13),
    //   ),
    //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //     backgroundColor: const Color.fromARGB(255, 141, 134, 134),
    //     showUnselectedLabels: true,
    //     selectedIconTheme: IconThemeData(
    //       color: Theme.of(context).errorColor,
    //     ),
    //     selectedLabelStyle: TextStyle(
    //       color: Theme.of(context).errorColor,
    //     ),
    //     unselectedIconTheme: IconThemeData(
    //       color: Theme.of(context).highlightColor,
    //     ),
    //     unselectedLabelStyle: TextStyle(
    //       color: Theme.of(context).errorColor,
    //     ),
    //   ),
    // );
    //}
    notifyListeners();
  }

  // /// Change your app theme with [currenThemeEnum] value.
  // void changeTheme() {
  //   if (_currenThemeEnum == AppThemes.LIGHT) {
  //     _currentTheme = ThemeData.dark();
  //     _currenThemeEnum = AppThemes.DARK;
  //   } else {
  //     _currentTheme = AppThemeLight.instance.theme;
  //     ;
  //     _currenThemeEnum = AppThemes.LIGHT;
  //   }
  //   notifyListeners();
  // }
}
