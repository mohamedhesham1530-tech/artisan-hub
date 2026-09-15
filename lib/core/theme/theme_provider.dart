import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDark = false;

  Future<void> loadTheme() async {
    final prefs =
        await SharedPreferences.getInstance();

    isDark =
        prefs.getBool("dark_mode") ?? false;

    notifyListeners();
  }

  Future<void> toggleTheme(bool value) async {
    isDark = value;

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setBool(
      "dark_mode",
      value,
    );

    notifyListeners();
  }
}