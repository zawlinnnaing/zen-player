import 'package:drift/drift.dart';
import 'package:zen_player/models/database.dart';
import 'package:zen_player/models/model.dart';
import 'package:zen_player/models/video.dart';
import 'package:zen_player/modules/vendors/video.dart';

class PlayListModel extends BaseModel implements Model<AppPlayList> {
  final MyDatabase database;
  late final VideoModel _videoModel;

  PlayListModel({required this.database})
      : this._videoModel = VideoModel(database: database),
        super(database);

  factory PlayListModel.getInstance() {
    return PlayListModel(database: MyDatabase());
  }

  Future<void> addVideo(
    int playListId,
    String videoId,
  ) async {
    VideosPlayListsCompanion videosPlayListsCompanion =
        VideosPlayListsCompanion(
      playListId: Value(playListId),
      videoId: Value(videoId),
    );
    await this._videoModel.findById(videoId);
    await this
        .database
        .into(database.videosPlayLists)
        .insert(videosPlayListsCompanion);
  }

  Future<bool> hasVideoInPlaylist(int playlistId, String videoId) async {
    try {
      await (this.database.select(this.database.videosPlayLists)
            ..where((tbl) =>
                tbl.playListId.equals(playlistId) &
                tbl.videoId.equals(videoId)))
          .getSingle();
      return true;
    } catch (error) {
      if (error is StateError) {
        return false;
      }
      throw error;
    }
  }

  Future<List<AppVideoInPlaylist>> findVideos(int playlistId) async {
    final List<VideoPlayList> videosPlayList =
        await (this.database.select(this.database.videosPlayLists)
              ..where((tbl) => tbl.playListId.equals(playlistId)))
            .get();
    final List<String> videoIds = videosPlayList.map((e) => e.videoId).toList();
    final List<AppVideo> videos = await this._videoModel.findByIds(videoIds);
    return videos.map((video) {
      VideoPlayList videoPlayList =
          videosPlayList.firstWhere((element) => element.videoId == video.id);
      return AppVideoInPlaylist(
          appVideo: video, createdAt: videoPlayList.createdAt);
    }).toList();
  }

  @override
  Future<AppPlayList> findOrCreate(Map<String, dynamic> data) async {
    PlayListsCompanion companion = PlayListsCompanion(
      isBuiltIn: Value.ofNullable(data["isBuiltIn"]),
      updatedAt: Value(DateTime.now()),
      createdAt: Value(DateTime.now()),
      name: Value.ofNullable(data["name"]),
    );
    try {
      PlayListData playListData =
          await (this.database.select(this.database.playLists)
                ..where((tbl) => tbl.name.equals(data["name"])))
              .getSingle();
      return AppPlayList.fromPlayListData(playListData);
    } catch (error) {
      if (error is StateError) {
        PlayListData playListData = await this
            .database
            .into(this.database.playLists)
            .insertReturning(companion);
        return AppPlayList.fromPlayListData(playListData);
      }
      throw error;
    }
  }

  PlayListsCompanion fromMap(Map<String, dynamic> data) {
    return PlayListsCompanion(
      id: Value.ofNullable(data["id"] == null ? null : int.parse(data["id"])),
      name: Value.ofNullable(data["name"]),
      isBuiltIn: Value.ofNullable(data["isBuiltIn"]),
      createdAt: Value.ofNullable(data["createdAt"] ?? DateTime.now()),
      updatedAt: Value.ofNullable(data["updatedAt"] ?? DateTime.now()),
    );
  }

  @override
  Future<AppPlayList> insert(Map<String, dynamic> data) async {
    PlayListsCompanion playListsCompanion = this.fromMap(
      data,
    );
    PlayListData createdData = await this
        .database
        .into(this.database.playLists)
        .insertReturning(playListsCompanion);
    return AppPlayList.fromPlayListData(createdData);
  }

  @override
  Future<AppPlayList> findById(id) async {
    PlayListData playListData =
        await (this.database.select(this.database.playLists)
              ..where((tbl) => tbl.id.equals(int.parse(id))))
            .getSingle();
    return AppPlayList.fromPlayListData(playListData);
  }

  Future<List<AppPlayList>> searchByName(String nameToSearch) async {
    List<PlayListData> playListsFromDB =
        await (this.database.select(this.database.playLists)
              ..where((tbl) => tbl.name.contains(nameToSearch)))
            .get();
    return playListsFromDB
        .map((playListData) => AppPlayList.fromPlayListData(playListData))
        .toList();
  }

  Future<AppPlayList> findByName(String name) async {
    PlayListData playListData =
        await (this.database.select(this.database.playLists)
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
    return "AppVideo: ${this.appVideo.toString()}, createdAt: ${this.createdAt.toString()}";
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
      : this._videos = videos ?? Set();

  factory AppPlayList.fromPlayListData(PlayListData data) {
    return AppPlayList(
        id: data.id.toString(), name: data.name, isBuiltIn: data.isBuiltIn);
  }

  Set<AppVideoInPlaylist> get videos => this._videos;

  set videos(Set<AppVideoInPlaylist> videos) {
    this._videos = videos;
  }

  addVideo(AppVideoInPlaylist video) {
    this._videos.add(video);
  }

  @override
  String toString() {
    return "Id: ${this.id}, Name: ${this.name}, videos: ${this.videos.toString()}";
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "name": this.name,
      "isBuiltIn": this.isBuiltIn,
    };
  }
}
