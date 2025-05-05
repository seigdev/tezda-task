import 'package:tezda_task/app/shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheData {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    log('SharedPreference Initialized');
  }

  static Future<void> save(String key, dynamic value) async {
    try {
      if (value is String) {
        await _prefs!.setString(key, value);
      } else if (value is int) {
        await _prefs!.setInt(key, value);
      } else if (value is double) {
        await _prefs!.setDouble(key, value);
      } else if (value is bool) {
        await _prefs!.setBool(key, value);
      } else if (value is List<String>) {
        await _prefs!.setStringList(key, value);
      } else {
        throw Exception('unsupported value type.');
      }
    } catch (e) {
      throw Exception('unable to save data.');
    }
  }

  static dynamic remove(String key) {
    try {
      return _prefs!.remove(key);
    } catch (e) {
      log("shared preference - $e");
    }
  }

  static dynamic fetch(String key) {
    try {
      return _prefs!.get(key);
    } catch (e) {
      log("shared preference - $e");
    }
  }

  static dynamic fetchString(String key) {
    try {
      return _prefs!.getString(key);
    } catch (e) {
      log("shared preference - $e");
    }
  }

  static dynamic fetchList(String key) {
    try {
      return _prefs!.getStringList(key);
    } catch (e) {
      log("shared preference - $e");
    }
  }

  static dynamic fetchBool(String key) {
    try {
      return _prefs!.getBool(key);
    } catch (e) {
      log("shared preference - $e");
    }
  }

  static dynamic fetchInt(String key) {
    try {
      return _prefs!.getInt(key);
    } catch (e) {
      log("shared preference - $e");
    }
  }

  static dynamic fetchDouble(String key) {
    try {
      return _prefs!.getDouble(key);
    } catch (e) {
      log("shared preference - $e");
    }
  }

  static clear() {
    _prefs!.clear();
  }
}
