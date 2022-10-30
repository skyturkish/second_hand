import 'package:second_hand/core/constants/enums/locale_keys_enum.dart';
import 'package:second_hand/core/init/cache/Ilocale_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleManager implements IlocaleManager {
  LocaleManager._init() {
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
    });
  }
  static final LocaleManager _instance = LocaleManager._init();

  SharedPreferences? _preferences;

  static LocaleManager get instance => _instance;

  static Future<void> preferencesInit() async {
    instance._preferences ??= await SharedPreferences.getInstance();
  }

  @override
  Future<void> clearAll() async {
    await _preferences!.clear();
  }

  @override
  Future<void> setBoolValue(LocaleCacheKeys key, {required bool value}) async {
    await _preferences!.setBool(key.toString(), value);
  }

  @override
  bool getBoolValue(LocaleCacheKeys key) => _preferences!.getBool(key.toString()) ?? false;

  @override
  Future<void> setStringValue(LocaleCacheKeys key, String value) async {
    await _preferences!.setString(key.toString(), value);
  }

  @override
  String getStringValue(LocaleCacheKeys key) => _preferences?.getString(key.toString()) ?? '';
}
