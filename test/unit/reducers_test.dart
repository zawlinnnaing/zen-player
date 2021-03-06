import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zen_player/redux/actions/app.dart';
import 'package:zen_player/redux/actions/theme.dart';
import 'package:zen_player/redux/reducers/app.dart';
import 'package:zen_player/redux/reducers/theme.dart';
import 'package:zen_player/redux/states/app.dart';

void main() {
  AppState appState = AppState();
  setUp(() {
    appState = AppState();
  });
  group("app reducers", () {
    test("updateViewIndex", () {
      final UpdateViewIndexAction action = UpdateViewIndexAction(1);
      updateViewIndex(appState, action);
      expect(appState.currentViewIndex, action.index);
    });
  });
  group("theme reducers", () {
    test("updateThemeMode", () {
      final UpdateThemeModeAction action =
          UpdateThemeModeAction(themeMode: ThemeMode.light);
      updateThemeMode(appState, action);
      expect(appState.themeState!.mode, ThemeMode.light);
    });
  });
  group("search list", () {
    test("appendSearchList", () {
      const String keyword = "hello";
      final AppendSearchListAction action = AppendSearchListAction(keyword);
      appendSearchList(appState, action);
      expect(appState.searchHistory.contains(keyword), true);
    });
    test("appendSearchList length", () {
      const String keyword = "hello";
      final AppendSearchListAction action = AppendSearchListAction(keyword);
      appendSearchList(appState, action);
      expect(appState.searchHistory.length, 1);
    });
    test("removeSearchList", () {
      const String keyword = "hello";
      final AppendSearchListAction addAction = AppendSearchListAction(keyword);
      appendSearchList(appState, addAction);
      final RemoveSearchListAction removeAction =
          RemoveSearchListAction(keyword);
      removeSearchList(appState, removeAction);
      expect(appState.searchHistory.length, 0);
      expect(appState.searchHistory.contains(keyword), false);
    });
    test("setSearchList", () {
      final List<String> mockList = ["hello", "world"];
      setSearchList(appState, SetSearchListAction(mockList));
      expect(appState.searchHistory.toList(), mockList);
    });
  });
}
