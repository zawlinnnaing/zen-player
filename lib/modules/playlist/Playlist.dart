import 'package:flutter/material.dart';
import 'package:zen_player/models/playlist.dart';

class Playlist extends StatefulWidget {
  final AppPlayList playList;
  Playlist({required this.playList});
  @override
  State<StatefulWidget> createState() {
    return _PlaylistState();
  }
}

class _PlaylistState extends State<Playlist> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build throw UnimplementedError();
  }
}
