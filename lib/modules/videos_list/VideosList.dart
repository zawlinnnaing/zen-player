import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zen_player/modules/vendors/video.dart';
import 'package:zen_player/modules/videos_list/VideoCard.dart';

class VideosList extends StatefulWidget {
  final List<AppVideo> videos;
  VideosList({required this.videos});
  @override
  State<StatefulWidget> createState() {
    return _VideosListState();
  }
}

class _VideosListState extends State<VideosList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, int idx) {
          if (idx == widget.videos.length) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "If this list does not contain what you looking for, try narrowing the search or use video URL.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            );
          }
          AppVideo video = widget.videos[idx];
          return Container(
            child: VideoCard(
              video: video,
            ),
          );
        },
        itemCount: widget.videos.length + 1,
      ),
    );
  }
}
