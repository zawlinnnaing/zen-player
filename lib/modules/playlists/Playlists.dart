import 'package:flutter/cupertino.dart';
import 'package:zen_player/models/playlist.dart';
import 'package:zen_player/modules/playlists/PlaylistCard.dart';

class Playlists extends StatefulWidget {
  final List<AppPlayList> playlists;
  Playlists({required this.playlists});
  @override
  State<Playlists> createState() {
    return _PlaylistsState();
  }
}

class _PlaylistsState extends State<Playlists> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.playlists.length,
        itemBuilder: (context, index) {
          return Container(
            child: PlaylistCard(
              playList: widget.playlists[index],
            ),
          );
        });
  }
}
