import 'package:flutter/material.dart';
import 'package:zen_player/models/playlist.dart';

class PlaylistCard extends StatefulWidget {
  final AppPlayList playList;
  PlaylistCard({required this.playList});
  @override
  State<PlaylistCard> createState() {
    return _PlaylistCardState();
  }
}

class _PlaylistCardState extends State<PlaylistCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(widget.playList.name),
      ),
    );
  }
}
