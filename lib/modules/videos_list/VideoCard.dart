import 'package:flutter/material.dart';
import 'package:zen_player/modules/vendors/video.dart';
import 'package:zen_player/modules/video_detail/VideoPage.dart';
import 'package:zen_player/utils/routes.dart';

class VideoCard extends StatelessWidget {
  final Key? key;
  final AppVideo video;

  VideoCard({
    this.key,
    required this.video,
  }) : super(key: key);

  void _onPress(BuildContext context) {
    showModalBottomSheet(
        context: context,
        enableDrag: true,
        isDismissible: true,
        isScrollControlled: true,
        builder: (context) {
          return VideoDetail(appVideo: video);
        }); // Navigator.of(context).pushNamed(Routes.videoDetail, arguments: video);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.videoDetail, arguments: video);
          _onPress(context);
        },
        child: Row(
          children: [
            Image.network(
              video.thumbnail ?? "http://www.google.com",
              width: 140,
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Tooltip(
                    message: video.title,
                    child: Text(
                      video.title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1!,
                      softWrap: true,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Tooltip(
                    message: video.description ?? "No description",
                    child: Text(
                      video.description ?? "No description",
                      maxLines: 2,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    video.publishedAtStr ?? "Unknown",
                    style: Theme.of(context).textTheme.subtitle2,
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
