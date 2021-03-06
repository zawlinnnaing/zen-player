import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zen_player/modules/home/theme_manager.dart';
import 'package:zen_player/modules/search/search_manager.dart';
import 'package:zen_player/redux/actions/app.dart';
import 'package:zen_player/redux/actions/theme.dart';
import 'package:zen_player/redux/middlewares/search_middleware.dart';
import 'package:zen_player/redux/middlewares/theme_middleware.dart';
import 'package:zen_player/redux/reducers/app.dart';
import 'package:zen_player/redux/states/app.dart';

void main() {
  group("ThemeMiddleware", () {
    late AppState appState;
    late Store<AppState> store;
    setUp(() {
      appState = AppState();
      store = Store(appReducer,
          initialState: appState, middleware: [ThemeMiddleware()]);
    });
    late SharedPreferences pref;
    late ThemeMiddleware middleware;
    setUp(() async {
      pref = await SharedPreferences.getInstance();
      if (pref.containsKey(ThemeManager.THEME_KEY)) {
        pref.remove(ThemeManager.THEME_KEY);
      }
      middleware = ThemeMiddleware();
    });
    test("Update theme in preferences when called updateThemeAction", () async {
      ThemeMode themeMode = ThemeMode.light;
      middleware.call(
          store, UpdateThemeModeAction(themeMode: themeMode), (action) {});
      await Future.delayed(Duration(seconds: 3));
      expect(await ThemeManager.getTheme(), themeMode);
    }, timeout: Timeout(Duration(seconds: 500)));
    test("No side effect when called unrelated action", () async {
      UpdateViewIndexAction unrelationAction = UpdateViewIndexAction(0);
      middleware.call(store, unrelationAction, (action) => null);
      await Future.delayed(Duration(seconds: 3));
      expect(await ThemeManager.getTheme(), null);
    });
  });
  group("SearchMiddleware", () {
    late SharedPreferences pref;
    late SearchMiddleware middleware;
    late SearchStorageManager manager;
    late Store<AppState> store;
    setUp(() async {
      pref = await SharedPreferences.getInstance();
      final AppState appState = AppState();
      middleware = SearchMiddleware();
      manager = await SearchStorageManager.create();
      await manager.clearHistory();
      store =
          Store(appReducer, initialState: appState, middleware: [middleware]);
    });
    test("Unrelated action does not side effect", () async {
      UpdateViewIndexAction unrelatedAction = UpdateViewIndexAction(0);
      store.dispatch(unrelatedAction);
      await Future.delayed(Duration(seconds: 3));
      expect(await manager.history, []);
    });
    test("Append search list", () async {
      AppendSearchListAction action = AppendSearchListAction("hello");
      store.dispatch(action);
      await Future.delayed(Duration(seconds: 3));
      expect(await manager.history, ["hello"]);
    });
    test("Remove search list", () async {
      String mockStr = "hello";
      AppendSearchListAction appendAction = AppendSearchListAction(mockStr);
      store.dispatch(appendAction);
      RemoveSearchListAction action = RemoveSearchListAction(mockStr);
      store.dispatch(action);
      await Future.delayed(Duration(seconds: 3));
      expect(await manager.history, []);
    });
  });
}
