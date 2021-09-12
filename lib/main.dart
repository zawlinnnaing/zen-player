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

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({required this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          title: 'Zen Player',
          darkTheme:
              ThemeData.dark().copyWith(accentColor: Colors.lightBlueAccent),
          theme:
              ThemeData.light().copyWith(accentColor: Colors.lightBlueAccent),
          themeMode: store.state.themeState!.mode,
          routes: Routes.routesMap,
          debugShowCheckedModeBanner: false,
        ));
  }
}
