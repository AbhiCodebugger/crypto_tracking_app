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

  static Future<bool> setFavourites(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favourites = prefs.getStringList("favourite") ?? [];
    favourites.add(id);
    return await prefs.setStringList('favourite', favourites);
  }

  static Future<bool> removeFavourites(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favourites = prefs.getStringList("favourite") ?? [];
    favourites.remove(id);
    return await prefs.setStringList('favourite', favourites);
  }

  static Future<List<String>> getFavourite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favourite') ?? [];
  }
}
