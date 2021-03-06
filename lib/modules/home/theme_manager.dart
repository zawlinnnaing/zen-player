import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager {
  static const THEME_KEY = "app_theme";
  static Future updateTheme(ThemeMode themeMode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(THEME_KEY, themeMode.index);
  }

  static Future<ThemeMode?> getTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? themeIdx = preferences.getInt(THEME_KEY);
    return themeIdx == null ? null : ThemeMode.values[themeIdx];
  }

  static Future<void> removeTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(THEME_KEY);
  }
}
