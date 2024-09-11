import 'package:shared_preferences/shared_preferences.dart';

/*
 * shared_preferences 配置
 */
class SPreferences {
  static final SPreferences _instance = SPreferences._();
  factory SPreferences() => _instance;
  SPreferences._();
  static SharedPreferences _prefs;

  static Future<void> init() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  // 设置数字类型
  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  // 设置bool
  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  // 设置String
  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  String getString(String key) {
    return _prefs.getString(key);
  }

  bool getIsLogin() {
    if (_prefs.containsKey("isLogin")) {
      return _prefs.getBool("isLogin");
    }
    return false;
  }

  bool getBool(String key) {
    if (!(_prefs.containsKey(key))) {
      _prefs.setBool(key, true);
      return false;
    }
    return _prefs.getBool(key);
  }
}
