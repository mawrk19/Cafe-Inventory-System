import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static Future<void> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> saveMultiple(Map<String, String> data) async {
    final prefs = await SharedPreferences.getInstance();
    for (var entry in data.entries) {
      if (prefs.getString(entry.key) == null || prefs.getString(entry.key) != entry.value) {
        await prefs.setString(entry.key, entry.value);
      }
    }
  }

  static Future<Map<String, String>> getMultiple(List<String> keys) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, String> result = {};
    for (var key in keys) {
      result[key] = prefs.getString(key) ?? '';
    }
    return result;
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
