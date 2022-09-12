import 'package:crypto_tracker/storage/local_db.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeMode themeMode;

  ThemeProvider(String theme) {
    if (theme == 'light') {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
  }

  toggleTheme() async {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
      await LocalDB.saveTheme('dark');
    } else {
      themeMode = ThemeMode.light;
      await LocalDB.saveTheme('light');
    }
    notifyListeners();
  }
}
