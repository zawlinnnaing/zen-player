import 'package:flutter/cupertino.dart';import 'package:zen_player/modules/home/Home.dart';import 'package:zen_player/modules/search/SearchPage.dart';import 'package:zen_player/modules/setting/Setting.dart';import 'package:zen_player/modules/videos_list/VideosPage.dart';typedef RouteFunction = Widget Function(BuildContext a);class Routes {  Routes() {    throw UnimplementedError(        "RoutesMap does not allow creating object. Just use static variables");  }  static const String home = "/";  static const String settings = "/settings";  static const String search = "/search";  static const String videos = "/videos";  static List<String> toList() {    return [home, settings];  }  static Map<String, WidgetBuilder> routesMap = {    home: (_) => Home(),    settings: (_) => Setting(),    search: (_) => SearchPageContainer(),    videos: (_) => VideosPageContainer()  };  static void changeRouteWithoutAnimation(    Widget page,    BuildContext context,  ) {    Navigator.push(        context,        PageRouteBuilder(          pageBuilder: (context, animation, secondaryAnimation) {            return page;          },          transitionDuration: Duration.zero,        ));  }}