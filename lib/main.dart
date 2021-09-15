import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:zen_player/redux/middlewares/search_middleware.dart';
import 'package:zen_player/redux/middlewares/theme_middleware.dart';
import 'package:zen_player/redux/reducers/app.dart';
import 'package:zen_player/redux/states/app.dart';
import 'package:zen_player/redux/store.dart';
import 'package:zen_player/utils/config.dart';
import 'package:zen_player/utils/routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  setPathUrlStrategy();
  await dotenv.load().catchError((error) {
    log("DotEnvError", error: error);
  });
  Store<AppState> store = Store(appReducer,
      initialState: AppState(),
      middleware: [ThemeMiddleware(), SearchMiddleware()]);
  populateStore(store);
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
              darkTheme: darkTheme,
              theme: lightTheme,
              themeMode: vm.themeMode,
              routes: Routes.routesMap,
              debugShowCheckedModeBanner: false,
            );
          },
        ));
  }
}
