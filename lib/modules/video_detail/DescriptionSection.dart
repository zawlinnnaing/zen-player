import 'dart:developer' as Developer;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zen_player/modules/vendors/video.dart';
import 'package:zen_player/modules/video_detail/video_size_manager.dart';

class _DescriptionBottomSheet extends StatelessWidget {
  final AppVideo video;
  _DescriptionBottomSheet({required this.video});
  _closeBottomSheet(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: VideoSizeManager.descriptionHeight(context),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(child: Text("Description")),
              IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    _closeBottomSheet(context);
                  })
            ],
          ),
          Expanded(
              child: ListView(
            children: [
              Text(
                video.title,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Divider(
                thickness: 1,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Linkify(
                onOpen: (LinkableElement link) async {
                  try {
                    if (await canLaunch(link.url)) {
                      await launch(link.url);
                    }
                  } catch (error) {
                    Developer.log("OpenLinkError: ${error.toString()}");
                  }
                },
                text: video.description ??
                    "No description", // linkStyle: TextStyle(color: ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}

class _UploaderSection extends StatelessWidget {
  final AppVideo video;
  _UploaderSection({required this.video});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.person),
          SizedBox(
            width: 12,
          ),
          Expanded(child: Text(video.uploader ?? "No uploader"))
        ],
      ),
    );
  }
}

class _TitleSection extends StatelessWidget {
  final String title;
  _TitleSection({
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        )),
        Icon(Icons.arrow_drop_down)
      ],
    );
  }
}

class VideoDescriptionSection extends StatefulWidget {
  final AppVideo video;
  VideoDescriptionSection({required this.video});
  @override
  State<StatefulWidget> createState() {
    return _VideoDescriptionState();
  }
}

class _VideoDescriptionState extends State<VideoDescriptionSection> {
  bool isExpanded = false;
  _openBottomSheet(BuildContext context) {
    showBottomSheet(
        builder: (BuildContext context) {
          return _DescriptionBottomSheet(video: widget.video);
        },
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              _openBottomSheet(context);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TitleSection(
                  title: widget.video.title,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  widget.video.publishedAtStr ?? "No published date",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
          Divider(
            color: Theme.of(context).colorScheme.secondary,
          ),
          _UploaderSection(video: widget.video),
          Divider(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
    );
  }
}
