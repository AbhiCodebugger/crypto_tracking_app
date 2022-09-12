import 'package:shared_preferences/shared_preferences.dart';

class LocalDB {
  static Future<bool> saveTheme(String theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.setString('theme', theme);
    return result;
  }

  static Future<String?> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? currentTheme = prefs.getString('theme');
    return currentTheme;
  }
}
