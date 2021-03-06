import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zen_player/managers/watch_history.dart';
import 'package:zen_player/models/database.dart';
import 'package:zen_player/models/playlist.dart';
import 'package:zen_player/models/video.dart';
import 'package:zen_player/modules/vendors/video.dart';

void main() {
  late MyDatabase myDatabase;
  late VideoModel videoModel;
  late PlayListModel playListModel;
  late WatchHistoryManager watchHistoryManager;
  setUp(() {
    myDatabase = MyDatabase.forTest(NativeDatabase.memory());
    videoModel = VideoModel(database: myDatabase);
    playListModel = PlayListModel(database: myDatabase);
    watchHistoryManager = WatchHistoryManager(
        playListModel: playListModel, videoModel: videoModel);
  });
  tearDown(() async {
    print("Running tear down...");
    await myDatabase.deleteAll();
    await myDatabase.close();
  });
  group("WatchHistoryManager Class", () {
    setUp(() async {
      final Map sqliteVersion = (await myDatabase
              .customSelect('select sqlite_version() as r;')
              .getSingle())
          .data;
      print('sqlite version, ${sqliteVersion.toString()}');
      print("Path variables: ${Platform.environment['PATH'].toString()}");
      await watchHistoryManager.create();
    });
    test("create", () async {
      AppPlayList watchHistoryPlayList = await watchHistoryManager.create();
      expect(
          watchHistoryPlayList.name, WatchHistoryManager.DEFAULT_PLAYLIST_NAME);
    });
    test("create only one record, even though called multiple times.",
        () async {
      await watchHistoryManager.create();
      await watchHistoryManager.create();
      List<AppPlayList> playlists = await playListModel
          .searchByName(WatchHistoryManager.DEFAULT_PLAYLIST_NAME);
      expect(playlists.length, 1);
    });
    group("addVideo", () {
      late AppVideo mockVideo;
      setUp(() async {
        mockVideo = AppVideo(
            title: "Mock Video",
            id: "ABCDEFG",
            url: "http://mockurl.com",
            provider: AppVideoProvider.YouTube);
      });
      test("normal flow", () async {
        await videoModel.findOrCreate(mockVideo.toMap());
        await watchHistoryManager.addVideo(mockVideo);
        AppPlayList watchHistory = await playListModel
            .findByName(WatchHistoryManager.DEFAULT_PLAYLIST_NAME);
        List<AppVideo> watchedVideos =
            (await playListModel.findVideos(int.parse(watchHistory.id)))
                .map((e) => e.appVideo)
                .toList();
        expect(watchedVideos.length, 1);
        expect(watchedVideos.contains(mockVideo), true);
      });
      test("over limit predefined videos", () async {
        const int OVER_LIMIT_COUNT = 4; // chosen arbitrarily
        List<AppVideoInPlaylist> insertedVideos = [];
        for (int i = 0;
            i < WatchHistoryManager.MAX_VIDEOS + OVER_LIMIT_COUNT;
            i++) {
          AppVideo appVideo = AppVideo(
              title: "Mock video $i",
              id: "Mock-$i",
              url: "http://example.com/$i",
              provider: AppVideoProvider.YouTube);
          insertedVideos.add(AppVideoInPlaylist(
              appVideo: appVideo, createdAt: DateTime.now()));
          await videoModel.insert(appVideo.toMap());
          await watchHistoryManager.addVideo(appVideo);
          await Future.delayed(Duration(milliseconds: 100));
        }
        AppPlayList watchHistory =
            await watchHistoryManager.getPlayListWithVideos();
        List<AppVideoInPlaylist> watchHistoryVideos =
            watchHistory.videos.toList();
        insertedVideos.sort(
            (videoA, videoB) => videoA.createdAt.compareTo(videoB.createdAt));
        List<AppVideoInPlaylist> videosToRemove =
            insertedVideos.sublist(0, OVER_LIMIT_COUNT - 1);
        List<String> idsOfVideosToRemove =
            videosToRemove.map((e) => e.appVideo.id).toList();
        List<AppVideoInPlaylist> videosToRemoveInWatchHistory =
            watchHistoryVideos
                .where((element) =>
                    idsOfVideosToRemove.contains(element.appVideo.id))
                .toList();
        expect(watchHistory.videos.length, WatchHistoryManager.MAX_VIDEOS);
        expect(videosToRemoveInWatchHistory.length, 0);
      });
      test("adding two same videos", () async {
        await watchHistoryManager.addVideo(mockVideo);
        await watchHistoryManager.addVideo(mockVideo);
        AppPlayList watchHistory =
            await watchHistoryManager.getPlayListWithVideos();
        expect(watchHistory.videos.length, 1);
      });
      test("adding two different videos but adding one video twice", () async {
        await watchHistoryManager.addVideo(mockVideo);
        AppVideo newVideo = AppVideo(
            title: "New mock video",
            id: "new-mock",
            url: "https://new-mock.com",
            provider: AppVideoProvider.YouTube);
        await watchHistoryManager.addVideo(newVideo);
        await watchHistoryManager.addVideo(mockVideo);
        AppPlayList watchHistory =
            await watchHistoryManager.getPlayListWithVideos();
        expect(watchHistory.videos.length, 2);
        expect(
            watchHistory.videos
                .where((element) => element.appVideo.id == mockVideo.id)
                .toList()
                .length,
            1);
        expect(
            watchHistory.videos
                .where((element) => element.appVideo.id == newVideo.id)
                .toList()
                .length,
            1);
      });
    });
  });
}
