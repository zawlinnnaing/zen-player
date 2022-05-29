import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:zen_player/modules/vendors/video.dart';
import 'javascript_fragments.dart';

class YouTubeIframePlayer extends StatefulWidget {
  final AppVideo video;
  final Function(AppVideo playedVideo)? onVideoPlayed;
  YouTubeIframePlayer({required this.video, this.onVideoPlayed});
  @override
  State<StatefulWidget> createState() {
    return _YouTubeIframePlayerState();
  }
}

class _YouTubeIframePlayerState extends State<YouTubeIframePlayer> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    _controller = YoutubePlayerController(
        initialVideoId: widget.video.id,
        params: YoutubePlayerParams(
            desktopMode:
                Platform.isLinux || Platform.isWindows || Platform.isMacOS,
            playsInline: true,
            showFullscreenButton: true,
            useHybridComposition: false,
            strictRelatedVideos: true,
            autoPlay: true,
            enableJavaScript: true,
            showControls: true));
    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    };
    _controller.onExitFullscreen = () {
      SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    };
    _controller.hidePauseOverlay();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.playVideoAt(0);
      widget.onVideoPlayed!(widget.video);
      _showInitialDialog(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }

  Future<void> _showInitialDialog(BuildContext context) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    const String PREF_KEY = "ytp-init-dialog";
    if (_pref.containsKey(PREF_KEY)) {
      return;
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Notice"),
            content: SingleChildScrollView(
              child: RichText(
                  text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                    TextSpan(text: "Due to YouTube's limitations, "),
                    TextSpan(
                        text: "more videos section ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: "will be shown when playing video in "),
                    TextSpan(
                        text: "full screen mode.",
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ])),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    _pref.setInt(PREF_KEY, 1);
                    Navigator.pop(context, "cancel");
                  },
                  child: Text("Ok, got it"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final YoutubePlayerIFrame player = YoutubePlayerIFrame(
      aspectRatio: 16 / 9, controller: _controller,
      gestureRecognizers: Set(), // To enable swiping down from player.
    );
    return player;
  }
}
