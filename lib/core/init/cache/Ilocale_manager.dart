// ignore_for_file: file_names

import 'package:second_hand/core/constants/enums/locale_keys_enum.dart';

abstract class IlocaleManager {
  Future<void> clearAll();
  Future<void> setBoolValue(LocaleCacheKeys key, {required bool value});
  bool getBoolValue(LocaleCacheKeys key);
  void setStringValue(LocaleCacheKeys key, String value);
  void getStringValue(LocaleCacheKeys key);
}
