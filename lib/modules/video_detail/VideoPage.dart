import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zen_player/managers/watch_history.dart';
import 'package:zen_player/models/video.dart';
import 'package:zen_player/modules/common/Loading.dart';
import 'package:zen_player/modules/vendors/factory.dart';
import 'package:zen_player/modules/vendors/video.dart';
import 'package:zen_player/modules/video_detail/DescriptionSection.dart';
import 'package:zen_player/modules/video_detail/players/player_factory.dart';
import 'package:zen_player/modules/video_detail/video_size_manager.dart';
import 'package:zen_player/utils/config.dart';

class VideoDetail extends StatefulWidget {
  final AppVideo? appVideo;
  VideoDetail({required this.appVideo});
  @override
  State<StatefulWidget> createState() {
    return _VideoDetailState();
  }
}

class _VideoDetailState extends State<VideoDetail> {
  AppVideo? video;
  bool loading = true;
  Future<void> _fetchVideo(String id) async {
    try {
      AppVideo? fetchedVideo =
          await VendorFactory.fromVendorType().getVideo(id);
      setState(() {
        video = fetchedVideo;
      });
    } catch (error) {
      log("Fetch Video Error ${error.toString()}");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Unable to load video")));
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this._afterInitialized();
  }

  Future<void> _afterInitialized() async {
    if (widget.appVideo != null) {
      await _fetchVideo(widget.appVideo!.id);
      await WatchHistoryManager.fromDefault().addVideo(widget.appVideo!);
    }
  }

  _orientationHandler(Orientation orientation) {
    if (orientation == Orientation.landscape) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);
    }
  }

  Future<void> _onVideoPlayed(AppVideo video) async {
    await VideoModel.getInstance().insert(video.toMap());
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Video added")));
  }

  @override
  Widget build(BuildContext context) {
    if (!loading && video == null) {
      Navigator.of(context).pop();
      return Container();
    }
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, Orientation orientation) {
          _orientationHandler(orientation);
          return loading
              ? Loading()
              : Column(
                  children: [
                    Container(
                      height: VideoSizeManager.playerHeight(context),
                      child: PlayerFactory.generatePlayer(
                          video: video!, onVideoPlayed: _onVideoPlayed),
                    ),
                    Expanded(
                      child: Container(
                        child: VideoDescriptionSection(video: video!),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}

class VideoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VideoDetail(
      appVideo: ModalRoute.of(context)!.settings.arguments as AppVideo,
    );
  }
}
