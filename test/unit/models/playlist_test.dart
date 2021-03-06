import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zen_player/models/database.dart';
import 'package:zen_player/models/playlist.dart';
import 'package:zen_player/models/video.dart';
import 'package:zen_player/modules/vendors/video.dart';

void main() {
  late AppPlayList mockPlayList;
  late MyDatabase database;
  late PlayListModel mockModel;
  late AppVideo mockVideo;
  late VideoModel videoModel;
  setUp(() {
    mockPlayList = AppPlayList(id: "1234", name: "Test playlist");
    database = MyDatabase.forTest(NativeDatabase.memory());
    mockModel = PlayListModel(database: database);
    mockVideo = AppVideo(
        title: "Mock video",
        id: "mock-1",
        url: "http://mock.com",
        provider: AppVideoProvider.YouTube);
    videoModel = VideoModel(database: database);
  });
  tearDown(() async {
    await database.close();
  });
  group("PlayListModel", () {
    test("insert and findById", () async {
      await mockModel.insert(mockPlayList.toMap());
      AppPlayList foundPlayList = await mockModel.findById(mockPlayList.id);
      expect(mockPlayList.id == foundPlayList.id, true);
    });
    test("find or create - normal", () async {
      AppPlayList playList = await mockModel.findOrCreate({
        "name": mockPlayList.name,
        "isBuiltIn": mockPlayList.isBuiltIn,
      });
      AppPlayList foundPlayList = await mockModel.findByName(mockPlayList.name);
      expect(playList.id == foundPlayList.id, true);
    });
    test("findOrCreate - without required data", () async {
      expect(mockModel.findOrCreate({}), throwsException);
    });
    test("findByName", () async {
      await mockModel.insert(mockPlayList.toMap());
      AppPlayList foundPlayList = await mockModel.findByName(mockPlayList.name);
      expect(mockPlayList.id == foundPlayList.id, true);
    });
    group("hasVideoInPlaylist", () {
      setUp(() async {
        await mockModel.insert(mockPlayList.toMap());
        await videoModel.insert(mockVideo.toMap());
      });
      test("has video", () async {
        await mockModel.addVideo(int.parse(mockPlayList.id), mockVideo.id);
        bool hasVideoInPlaylist = await mockModel.hasVideoInPlaylist(
            int.parse(mockPlayList.id), mockVideo.id);
        expect(hasVideoInPlaylist, true);
      });
      test("no video", () async {
        bool hasVideoInPlaylist = await mockModel.hasVideoInPlaylist(
            int.parse(mockPlayList.id), mockVideo.id);
        expect(hasVideoInPlaylist, false);
      });
    });
  });
}
