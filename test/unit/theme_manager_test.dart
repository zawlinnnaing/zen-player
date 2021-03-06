import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zen_player/modules/home/theme_manager.dart';

void main() {
  group("ThemeManager", () {
    late SharedPreferences preferences;
    setUp(() async {
      preferences = await SharedPreferences.getInstance();
      if (preferences.containsKey(ThemeManager.THEME_KEY)) {
        preferences.remove(ThemeManager.THEME_KEY);
      }
    });
    test("ThemeManager.updateTheme", () async {
      try {
        await ThemeManager.updateTheme(ThemeMode.dark);
        print("Theme from pref ${preferences.getInt(ThemeManager.THEME_KEY)}");
        expect(await ThemeManager.getTheme(), ThemeMode.dark);
      } catch (e, stackTrace) {
        print("Execption stacktrace: ${stackTrace.toString()}");
        throw e;
      }
    });
    test("ThemeManager.getTheme", () async {
      ThemeMode actualTheme = ThemeMode.light;
      await ThemeManager.updateTheme(actualTheme);
      ThemeMode? themeModeFromPref = await ThemeManager.getTheme();
      expect(actualTheme, themeModeFromPref);
    });
    test("ThemeManager.removeTheme", () async {
      await ThemeManager.updateTheme(ThemeMode.dark);
      await ThemeManager.removeTheme();
      expect(await ThemeManager.getTheme(), null);
    });
  });
}
