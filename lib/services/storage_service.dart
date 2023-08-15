import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants/storage.dart';

class StorageService {
  late final SharedPreferences _preferences;
  Future<StorageService> init() async {
    _preferences = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setBool(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  Future<bool> remove(String key) async {
    return await _preferences.remove(key);
  }

  bool getDeviceFirstTime() {
    return _preferences
            .getBool(StorageConstants.STORAGE_DEVICE_OPEN_FIRST_TIME) ??
        false;
  }

  bool getIsLoggedIn() {
    return _preferences.getString(StorageConstants.STORAGE_USER_TOKEN_KEY) ==
            null
        ? false
        : true;
  }
}
