import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:zen_player/models/database.dart';
import 'package:zen_player/models/playlist.dart';
import 'package:zen_player/models/video.dart';
import 'package:zen_player/modules/vendors/video.dart';

void main() {
  late MyDatabase myDatabase;
  late VideoModel videoModel;
  late AppVideo mockVideo;
  late PlayListModel playListModel;
  setUp(() {
    myDatabase = MyDatabase.forTest(NativeDatabase.memory());
    videoModel = VideoModel(database: myDatabase);
    playListModel = PlayListModel(database: myDatabase);
    mockVideo = AppVideo(
        title: "Hello world",
        id: "1245",
        url: "https://exampleurl.com",
        provider: AppVideoProvider.YouTube,
        thumbnail: "https://thumnail");
  });
  tearDown(() async {
    await myDatabase.close();
  });
  group("VideoModel", () {
    test("insert and findById", () async {
      await videoModel.insert(mockVideo.toMap());
      AppVideo foundVideo = await videoModel.findById(mockVideo.id);
      expect(foundVideo == mockVideo, true);
    });
    test("findOrCreate", () async {
      AppVideo video = await videoModel.findOrCreate(mockVideo.toMap());
      expect(video.id == mockVideo.id, true);
    });
    test("update", () async {
      AppVideo createdVideo = await videoModel.insert(mockVideo.toMap());
      AppVideo videoToUpdate = AppVideo(
          title: "New title",
          id: mockVideo.id,
          url: mockVideo.url,
          provider: mockVideo.provider);
      AppVideo updatedVideo =
          await videoModel.updateById(createdVideo.id, videoToUpdate);
      expect(
          updatedVideo.title == videoToUpdate.title &&
              updatedVideo.thumbnail == mockVideo.thumbnail,
          true);
    });
    test("Insert into playlist and find Videos ", () async {
      AppPlayList playList = await playListModel.insert({
        "name": "mock playlist",
        "isBuiltIn": true,
      });
      await videoModel.insert(mockVideo.toMap());
      await playListModel.addVideo(int.parse(playList.id), mockVideo.id);
      final List<AppVideo> playListVideos =
          (await playListModel.findVideos(int.parse(playList.id)))
              .map((e) => e.appVideo)
              .toList();
      expect(playListVideos.contains(mockVideo), true);
    });
    test("Insert into playlist, only one record when calling multiple inserts",
        () async {
      AppPlayList playList = await playListModel
          .insert({"name": "mock playlist", "isBuiltIn": true});
      await videoModel.insert(mockVideo.toMap());
      await playListModel.addVideo(int.parse(playList.id), mockVideo.id);
      await playListModel.addVideo(int.parse(playList.id), mockVideo.id);
      final List<AppVideo> playListVideos =
          (await playListModel.findVideos(int.parse(playList.id)))
              .map((e) => e.appVideo)
              .toList();
      expect(playListVideos.length == 1 && playListVideos.contains(mockVideo),
          true);
    });
  });
  group("AppVideo ==", () {
    test("true case", () {
      AppVideo otherVideo = AppVideo(
          title: mockVideo.title,
          id: mockVideo.id,
          url: mockVideo.url,
          provider: mockVideo.provider,
          thumbnail: mockVideo.thumbnail);
      expect(otherVideo == mockVideo, true);
    });
    test("false case - same class", () {
      AppVideo otherVideo = AppVideo(
          title: "hello",
          id: "12455",
          url: "https://zenplayer.com",
          provider: AppVideoProvider.YouTube);
      expect(otherVideo == mockVideo, false);
    });
    test("false case - different class", () {
      expect(mockVideo == "String", false);
    });
  });
  group("AppVideoProvider getVideoProviderFromString", () {
    test("found case", () {
      AppVideoProvider foundProvider =
          getVideoProviderFromString("AppVideoProvider.YouTube");
      expect(foundProvider == AppVideoProvider.YouTube, true);
    });
    test("Not found case - throw exception", () {
      expect(() => getVideoProviderFromString("hello"), throwsStateError);
    });
  });
}
