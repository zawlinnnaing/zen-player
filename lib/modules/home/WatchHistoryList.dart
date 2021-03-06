import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:zen_player/managers/watch_history.dart';
import 'package:zen_player/models/playlist.dart';
import 'package:zen_player/modules/common/CommonVideo.dart';
import 'package:zen_player/utils/route_observer.dart';

class WatchHistoryList extends StatefulWidget {
  @override
  State<WatchHistoryList> createState() {
    return _WatchHistoryListState();
  }
}

class _WatchHistoryListState extends State<WatchHistoryList> with RouteAware {
  AppPlayList? watchHistory;
  Future<void> _loadWatchHistory() async {
    final AppPlayList loadedHistory =
        await WatchHistoryManager.fromDefault().getPlayListWithVideos();
    setState(() {
      watchHistory = loadedHistory;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this._loadWatchHistory();
    appRouteObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    super.dispose();
    appRouteObserver.unsubscribe(this);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    this._loadWatchHistory();
  }

  @override
  void initState() {
    super.initState();
  }

  Column renderWatchHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          child: Text(
            "Your watched videos",
          ),
        ),
        Container(
          height: 158,
          child: ListView.builder(
            itemCount: watchHistory == null ? 0 : watchHistory!.videos.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: CommonVideo(
                    height: 120,
                    width: 160,
                    imageHeight: 90,
                    video: watchHistory!.videos.elementAt(index).appVideo),
              );
            },
            scrollDirection: Axis.horizontal,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: watchHistory != null && watchHistory!.videos.length > 0
          ? renderWatchHistory()
          : Center(
              child: Text('Your watch history will show up here.'),
            ),
    );
  }
}
