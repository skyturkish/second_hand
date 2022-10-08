import 'package:flutter/material.dart';
import 'package:second_hand/core/constants/enums/app_theme_enum.dart';
import 'package:second_hand/core/constants/enums/locale_keys_enum.dart';
import 'package:second_hand/core/init/cache/locale_manager.dart';
import 'package:second_hand/core/init/theme/dark_theme.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = AvailableThemes.instance.darkTheme;

  AppThemes _currenThemeEnum = AppThemes.DARK;

  AppThemes get currentThemeEnum => _currenThemeEnum;

  ThemeData get currentTheme => _currentTheme;

  void initTheme() {
    final theme = LocaleManager.instance.getStringValue(LocaleCacheKeys.THEME);

    theme == 'LIGHT' ? setLightTheme() : setDarkTheme();
  }

  void setDarkTheme() {
    _currentTheme = AvailableThemes.instance.darkTheme;

    _currenThemeEnum = AppThemes.DARK;

    LocaleManager.instance.setStringValue(LocaleCacheKeys.THEME, 'DARK');
  }

  void setLightTheme() {
    _currentTheme = AvailableThemes.instance.lighTheme;

    _currenThemeEnum = AppThemes.LIGHT;

    LocaleManager.instance.setStringValue(LocaleCacheKeys.THEME, 'LIGHT');
  }

  void changeTheme() {
    final theme = currentThemeEnum;

    if (theme == AppThemes.LIGHT) {
      setDarkTheme();
    } else if (theme == AppThemes.DARK) {
      setLightTheme();
    }
    notifyListeners();
  }
}
