import 'package:second_hand/core/constants/enums/locale_keys_enum.dart';

abstract class IlocaleManager {
  Future<void> clearAll();
  Future<void> setBoolValue(LocaleCacheKeys key, bool value);
  bool getBoolValue(LocaleCacheKeys key);
  setStringValue(LocaleCacheKeys key, String value);
  getStringValue(LocaleCacheKeys key);
}
