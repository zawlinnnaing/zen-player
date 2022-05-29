import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:zen_player/modules/home/theme_manager.dart';
import 'package:zen_player/modules/search/search_manager.dart';
import 'package:zen_player/redux/actions/app.dart';
import 'package:zen_player/redux/actions/theme.dart';
import 'package:zen_player/redux/states/app.dart';

Future<void> _populateTheme(Store<AppState> store) async {
  ThemeMode? themeMode = await ThemeManager.getTheme();
  if (themeMode != null) {
    store.dispatch(UpdateThemeModeAction(themeMode: themeMode));
  }
}

Future<void> _populateSearchHistory(Store<AppState> store) async {
  SearchStorageManager manager = await SearchStorageManager.create();
  store.dispatch(SetSearchListAction(await manager.history));
}

Future<void> populateStore(Store<AppState> store) async {
  _populateTheme(store);
  _populateSearchHistory(store);
}
