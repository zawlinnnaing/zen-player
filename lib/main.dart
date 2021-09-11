import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:zen_player/modules/home/Home.dart';
import 'package:zen_player/modules/setting/Setting.dart';
import 'package:zen_player/utils/routes.dart';

void main() {
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zen Player',
      darkTheme: ThemeData.dark().copyWith(accentColor: Colors.blueAccent),
      themeMode: ThemeMode.dark,
      routes: {
        Navigator.defaultRouteName: (context) => Home(),
        Routes.settings: (context) => Setting(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
