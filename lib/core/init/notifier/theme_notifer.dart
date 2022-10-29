import 'package:flutter/material.dart';
import 'package:second_hand/core/constants/enums/app_theme_enum.dart';
import 'package:second_hand/core/constants/enums/locale_keys_enum.dart';
import 'package:second_hand/core/init/cache/locale_manager.dart';
import 'package:second_hand/core/init/theme/spacedark/space_dark_light_theme.dart';
import 'package:second_hand/core/init/theme/light/ligh_theme.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = SpaceDarkTheme.instance.theme!;

  AppThemes _currenThemeEnum = AppThemes.SPACE_DARK;

  AppThemes get currentThemeEnum => _currenThemeEnum;

  ThemeData get currentTheme => _currentTheme;

  void initTheme() {
    final theme = LocaleManager.instance.getStringValue(LocaleCacheKeys.THEME);

    theme == AppThemes.LIGHT.name ? setLightTheme() : setDarkTheme();
  }

  void setDarkTheme() {
    _currentTheme = SpaceDarkTheme.instance.theme!;

    _currenThemeEnum = AppThemes.SPACE_DARK;

    LocaleManager.instance.setStringValue(LocaleCacheKeys.THEME, AppThemes.SPACE_DARK.name);
  }

  void setLightTheme() {
    _currentTheme = LightTheme.instance.theme!;

    _currenThemeEnum = AppThemes.LIGHT;

    LocaleManager.instance.setStringValue(LocaleCacheKeys.THEME, AppThemes.LIGHT.name);
  }

  void changeTheme() {
    final theme = currentThemeEnum;

    if (theme == AppThemes.LIGHT) {
      setDarkTheme();
    } else if (theme == AppThemes.SPACE_DARK) {
      setLightTheme();
    }
    notifyListeners();
  }
}
