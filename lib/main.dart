import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:zen_player/redux/reducers/app.dart';
import 'package:zen_player/redux/states/app.dart';
import 'package:zen_player/utils/routes.dart';

void main() {
  setPathUrlStrategy();
  Store<AppState> store = Store(appReducer, initialState: AppState());
  runApp(MyApp(
    store: store,
  ));
}

class _AppVm {
  ThemeMode themeMode;
  _AppVm({required this.themeMode});

  factory _AppVm.fromStore(Store<AppState> store) {
    return _AppVm(themeMode: store.state.themeState!.mode);
  }
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({required this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: StoreConnector(
          converter: (Store<AppState> store) => _AppVm.fromStore(store),
          builder: (BuildContext context, _AppVm vm) {
            return MaterialApp(
              title: 'Zen Player',
              darkTheme: ThemeData.dark().copyWith(
                  colorScheme:
                      ColorScheme.dark(secondary: Colors.lightBlueAccent)),
              theme: ThemeData.light(),
              themeMode: vm.themeMode,
              routes: Routes.routesMap,
              debugShowCheckedModeBanner: false,
            );
          },
        ));
  }
}