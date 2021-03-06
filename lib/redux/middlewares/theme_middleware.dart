import 'package:redux/redux.dart';
import 'package:zen_player/modules/home/theme_manager.dart';
import 'package:zen_player/redux/actions/theme.dart';
import 'package:zen_player/redux/states/app.dart';

class ThemeMiddleware implements MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, NextDispatcher next) {
    if (action is UpdateThemeModeAction) {
      ThemeManager.updateTheme(action.themeMode).then((value) => null);
    }
    next(action);
  }
}
