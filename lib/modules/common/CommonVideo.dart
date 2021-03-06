import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:zen_player/modules/vendors/video.dart';
import 'package:zen_player/modules/video_detail/VideoPage.dart';

class CommonVideo extends StatelessWidget {
  final AppVideo video;
  late final double height;
  late final double width;
  late final double imageHeight;
  CommonVideo(
      {required this.video,
      double? height,
      double? width,
      double? imageHeight}) {
    this.height = height ?? 100;
    this.width = width ?? 150;
    this.imageHeight = imageHeight ?? 80;
    log("height: ${this.height}, width: ${this.width}, imageHeight: ${this.imageHeight}");
  }
  _onTapVideo(context) {
    showModalBottomSheet(
        context: context,
        enableDrag: true,
        isDismissible: true,
        isScrollControlled: true,
        builder: (context) {
          return VideoDetail(appVideo: video);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: this.height,
        width: this.width,
        child: InkWell(
          onTap: () {
            this._onTapVideo(context);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: this.imageHeight,
                  width: this.width,
                  child: video.thumbnail == null
                      ? Image.asset(
                          "assets/gray.png",
                          fit: BoxFit.fitHeight,
                        )
                      : Image.network(
                          video.thumbnail!,
                          fit: BoxFit.cover,
                        )),
              Expanded(
                  child: Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  video.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )),
            ],
          ),
        ));
  }
}
