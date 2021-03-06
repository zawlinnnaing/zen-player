import 'package:redux/redux.dart';
import 'package:zen_player/modules/search/search_manager.dart';
import 'package:zen_player/redux/actions/app.dart';
import 'package:zen_player/redux/states/app.dart';

class SearchMiddleware implements MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, next) {
    next(action);
    if (action is SearchAction) {
      SearchStorageManager.create().then((SearchStorageManager manager) {
        manager.storeHistory(store.state.searchHistory.toList());
      });
    }
  }
}
