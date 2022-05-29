import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:zen_player/modules/vendors/video.dart';
import 'package:zen_player/modules/video_detail/players/youtube/IframePlayer.dart';

enum _PLAYER_PLATFORM { web, mobile, windows }

class PlayerFactory {
  static Widget generatePlayer(
      {required AppVideo video,
      Function(AppVideo playedVideo)? onVideoPlayed}) {
    switch (video.provider) {
      case AppVideoProvider.YouTube:
        if (Platform.isAndroid || Platform.isIOS) {
          return YouTubeIframePlayer(
            video: video,
            onVideoPlayed: onVideoPlayed,
          );
        }
        return YouTubeIframePlayer(video: video);
      default:
        throw Exception("Unknown video provider");
    }
  }
}
