import 'dart:developer';
import 'package:redux/redux.dart';
import 'package:zen_player/redux/actions/theme.dart';
import 'package:zen_player/redux/states/app.dart';

final themeReducer = combineReducers<AppState>([
  TypedReducer(updateThemeMode),
]);
AppState updateThemeMode(AppState state, UpdateThemeModeAction action) {
  state.themeState!.mode = action.themeMode;
  return state;
}
