import 'package:drift/drift.dart';
import 'package:zen_player/models/database.dart';
import 'package:zen_player/models/model.dart';
import 'package:zen_player/models/video.dart';
import 'package:zen_player/modules/vendors/video.dart';

class PlayListModel extends BaseModel implements Model<AppPlayList> {
  final MyDatabase database;
  late final VideoModel _videoModel;

  PlayListModel({required this.database})
      : _videoModel = VideoModel(database: database),
        super(database);

  factory PlayListModel.getInstance() {
    return PlayListModel(database: MyDatabase());
  }

  Future<void> addVideo(
    int playListId,
    String videoId,
  ) async {
    final VideosPlayListsCompanion videosPlayListsCompanion =
        VideosPlayListsCompanion(
      playListId: Value(playListId),
      videoId: Value(videoId),
    );
    await _videoModel.findById(videoId);
    await database
        .into(database.videosPlayLists)
        .insert(videosPlayListsCompanion);
  }

  Future<bool> hasVideoInPlaylist(int playlistId, String videoId) async {
    try {
      await (database.select(database.videosPlayLists)
            ..where((tbl) =>
                tbl.playListId.equals(playlistId) &
                tbl.videoId.equals(videoId)))
          .getSingle();
      return true;
    } catch (error) {
      if (error is StateError) {
        return false;
      }
      rethrow;
    }
  }

  Future<List<AppVideoInPlaylist>> findVideos(int playlistId) async {
    final List<VideoPlayList> videosPlayList =
        await (database.select(database.videosPlayLists)
              ..where((tbl) => tbl.playListId.equals(playlistId)))
            .get();
    final List<String> videoIds = videosPlayList.map((e) => e.videoId).toList();
    final List<AppVideo> videos = await _videoModel.findByIds(videoIds);
    return videos.map((video) {
      final VideoPlayList videoPlayList =
          videosPlayList.firstWhere((element) => element.videoId == video.id);
      return AppVideoInPlaylist(
          appVideo: video, createdAt: videoPlayList.createdAt);
    }).toList();
  }

  @override
  Future<AppPlayList> findOrCreate(Map<String, dynamic> data) async {
    final PlayListsCompanion companion = PlayListsCompanion(
      isBuiltIn: Value.ofNullable(data["isBuiltIn"] as bool),
      updatedAt: Value(DateTime.now()),
      createdAt: Value(DateTime.now()),
      name: Value.ofNullable(data["name"] as String),
    );
    try {
      final PlayListData playListData =
          await (database.select(database.playLists)
                ..where((tbl) => tbl.name.equals(data["name"] as String)))
              .getSingle();
      return AppPlayList.fromPlayListData(playListData);
    } catch (error) {
      if (error is StateError) {
        final PlayListData playListData = await database
            .insertReturning<PlayListData>(database.playLists, companion);
        return AppPlayList.fromPlayListData(playListData);
      }
      rethrow;
    }
  }

  PlayListsCompanion fromMap(Map<String, dynamic> data) {
    return PlayListsCompanion(
      id: Value.ofNullable(
          data["id"] == null ? null : int.parse(data["id"].toString())),
      name: Value.ofNullable(data["name"] as String),
      isBuiltIn: Value.ofNullable(data["isBuiltIn"] as bool),
      createdAt:
          Value.ofNullable(data["createdAt"] as DateTime ?? DateTime.now()),
      updatedAt:
          Value.ofNullable(data["updatedAt"] as DateTime ?? DateTime.now()),
    );
  }

  @override
  Future<AppPlayList> insert(Map<String, dynamic> data) async {
    final PlayListsCompanion playListsCompanion = fromMap(
      data,
    );
    final int rowId =
        await database.into(database.playLists).insert(playListsCompanion);
    final PlayListData createdData = await (database.select(database.playLists)
          ..where((tbl) => tbl.rowId.equals(rowId)))
        .getSingle();
    return AppPlayList.fromPlayListData(createdData);
  }

  @override
  Future<AppPlayList> findById(id) async {
    final PlayListData playListData = await (database.select(database.playLists)
          ..where((tbl) => tbl.id.equals(int.parse(id.toString()))))
        .getSingle();
    return AppPlayList.fromPlayListData(playListData);
  }

  Future<List<AppPlayList>> searchByName(String nameToSearch) async {
    final List<PlayListData> playListsFromDB =
        await (database.select(database.playLists)
              ..where((tbl) => tbl.name.contains(nameToSearch)))
            .get();
    return playListsFromDB
        .map((playListData) => AppPlayList.fromPlayListData(playListData))
        .toList();
  }

  Future<AppPlayList> findByName(String name) async {
    final PlayListData playListData = await (database.select(database.playLists)
          ..where((tbl) => tbl.name.equals(name)))
        .getSingle();
    return AppPlayList.fromPlayListData(playListData);
  }

  @override
  Future<AppPlayList> updateById(id, AppPlayList playListToUpdate) {
    // TODO: implement updateById
    throw UnimplementedError();
  }

  @override
  Future<void> removeById(id) async {
    // TODO: implement removeById
    throw UnimplementedError();
  }
}

class AppVideoInPlaylist {
  final AppVideo appVideo;
  final DateTime createdAt;

  AppVideoInPlaylist({required this.appVideo, required this.createdAt});

  @override
  String toString() {
    return "AppVideo: ${appVideo.toString()}, createdAt: ${createdAt.toString()}";
  }
}

class AppPlayList {
  final String id;
  final String name;
  bool isBuiltIn;
  late Set<AppVideoInPlaylist> _videos;

  AppPlayList(
      {required this.id,
      required this.name,
      Set<AppVideoInPlaylist>? videos,
      this.isBuiltIn = false})
      : _videos = videos ?? Set();

  factory AppPlayList.fromPlayListData(PlayListData data) {
    return AppPlayList(
        id: data.id.toString(), name: data.name, isBuiltIn: data.isBuiltIn);
  }

  Set<AppVideoInPlaylist> get videos => _videos;

  set videos(Set<AppVideoInPlaylist> videos) {
    _videos = videos;
  }

  addVideo(AppVideoInPlaylist video) {
    _videos.add(video);
  }

  @override
  String toString() {
    return "Id: ${id}, Name: ${name}, videos: ${videos.toString()}";
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "isBuiltIn": isBuiltIn,
    };
  }
}
