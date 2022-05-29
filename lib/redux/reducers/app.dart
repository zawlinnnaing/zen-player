import 'package:redux/redux.dart';
import 'package:zen_player/redux/actions/app.dart';
import 'package:zen_player/redux/reducers/theme.dart';
import 'package:zen_player/redux/states/app.dart';

final appReducer = combineReducers<AppState>([
  TypedReducer(updateViewIndex),
  TypedReducer(appendSearchList),
  TypedReducer(removeSearchList),
  TypedReducer(setSearchList),
  themeReducer,
]);
AppState updateViewIndex(AppState state, UpdateViewIndexAction action) {
  state.currentViewIndex = action.index;
  return state;
}

AppState appendSearchList(AppState state, AppendSearchListAction action) {
  state.searchHistory.add(action.keyword);
  return state;
}

AppState removeSearchList(AppState state, RemoveSearchListAction action) {
  state.searchHistory.remove(action.keyword);
  return state;
}

AppState setSearchList(AppState state, SetSearchListAction action) {
  state.searchHistory = Set.from(action.history);
  return state;
}
