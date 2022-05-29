import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zen_player/layout/Default.dart';
import 'package:zen_player/managers/watch_history.dart';
import 'package:zen_player/models/playlist.dart';
import 'package:zen_player/modules/home/WatchHistoryList.dart';
import 'package:zen_player/modules/playlists/Playlists.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  static const String appTitle = "Zen Player";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        child: Container(
            child: Column(
      children: [
        WatchHistoryList(),
        Expanded(
            child: Center(
          child: Text("Coming soon"),
        ))
      ],
    )));
  }
}
