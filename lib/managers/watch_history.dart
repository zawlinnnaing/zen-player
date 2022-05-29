import 'dart:developer';
import 'package:zen_player/models/playlist.dart';
import 'package:zen_player/models/video.dart';
import 'package:zen_player/modules/vendors/video.dart';

class WatchHistoryManager {
  final PlayListModel playListModel;
  final VideoModel videoModel;
  static const String DEFAULT_PLAYLIST_NAME = "Watch History";
  static const int MAX_VIDEOS = 30;
  WatchHistoryManager({
    required this.playListModel,
    required this.videoModel,
  });
  factory WatchHistoryManager.fromDefault() {
    return WatchHistoryManager(
        playListModel: PlayListModel.getInstance(),
        videoModel: VideoModel.getInstance());
  }
  Future<AppPlayList> create() async {
    const Map<String, dynamic> WATCH_HISTORY_DATA = {
      "name": WatchHistoryManager.DEFAULT_PLAYLIST_NAME,
      "isBuiltIn": true
    };
    return (await this.playListModel.findOrCreate(WATCH_HISTORY_DATA));
  }

  Future<AppPlayList> getPlayListWithVideos() async {
    AppPlayList watchHistory = await this
        .playListModel
        .findByName(WatchHistoryManager.DEFAULT_PLAYLIST_NAME);
    List<AppVideoInPlaylist> watchedVideos =
        await this.playListModel.findVideos(int.parse(watchHistory.id));
    watchedVideos
        .sort((videoA, videoB) => videoB.createdAt.compareTo(videoA.createdAt));
    watchHistory.videos = watchedVideos.toSet();
    return watchHistory;
  }

  Future<void> _handleOverLimitVideos(
      List<AppVideoInPlaylist> videosInPlaylist) async {
    if (videosInPlaylist.length <= WatchHistoryManager.MAX_VIDEOS) {
      return;
    }
    List<AppVideoInPlaylist> clonedVideosInPlaylist =
        List.from(videosInPlaylist);
    clonedVideosInPlaylist
        .sort((videoA, videoB) => videoA.createdAt.compareTo(videoB.createdAt));
    int numberOfOverLimitVideos =
        clonedVideosInPlaylist.length - WatchHistoryManager.MAX_VIDEOS;
    List<AppVideoInPlaylist> videosToRemove =
        clonedVideosInPlaylist.sublist(0, numberOfOverLimitVideos);
    await this
        .videoModel
        .batchRemove(videosToRemove.map((e) => e.appVideo.id).toList());
  }

  Future<void> addVideo(AppVideo video) async {
    await videoModel.findOrCreate(video.toMap());
    AppPlayList watchedHistory = await this.getPlayListWithVideos();
    await this.playListModel.addVideo(int.parse(watchedHistory.id), video.id);
    watchedHistory.addVideo(
        AppVideoInPlaylist(appVideo: video, createdAt: DateTime.now()));
    await this._handleOverLimitVideos(watchedHistory.videos.toList());
  }
}
