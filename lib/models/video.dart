import 'package:zen_player/models/database.dart';
import 'package:zen_player/models/model.dart';
import 'package:zen_player/modules/vendors/video.dart';
import 'package:drift/drift.dart';

class VideoModel extends BaseModel implements Model<AppVideo> {
  @override
  late final MyDatabase database;

  VideoModel({required this.database}) : super(database);

  factory VideoModel.getInstance() {
    return VideoModel(database: MyDatabase());
  }

  @override
  Future<AppVideo> insert(Map<String, dynamic> data) async {
    data.addAll({"createdAt": DateTime.now()});
    final VideosCompanion companion = _fromMap(data);
    final VideoData createdData =
        await database.insertReturning<VideoData>(database.videos, companion);
    return _fromData(createdData);
  }

  @override
  Future<AppVideo> findOrCreate(Map<String, dynamic> data) async {
    try {
      final AppVideo video = await findById(data['id']);
      return video;
    } catch (error) {
      if (error is StateError) {
        final AppVideo video = await insert(data);
        return video;
      }
      throw error;
    }
  }

  VideosCompanion _fromMap(Map<String, dynamic> data) {
    return VideosCompanion(
        id: Value(data["id"]),
        createdAt: data["createdAt"] == null
            ? Value.absent()
            : Value(data["createdAt"]),
        updatedAt: Value(DateTime.now()),
        provider: data["provider"] == null
            ? Value.absent()
            : Value(data["provider"].toString()),
        width: data["width"] == null ? Value.absent() : Value(data["width"]),
        height: getCompanionValue("height", data["height"]),
        thumbnailUrl: getCompanionValue("thumbnail", data["thumbnail"]),
        publishedAt: getCompanionValue("publishedAt", data["publishedAt"]),
        uploader: getCompanionValue("uploader", data["uploader"]),
        description: getCompanionValue("description", data["description"]),
        publishedAtStr:
            getCompanionValue("publishedAtStr", data["publishedAtStr"]),
        title: getCompanionValue("title", data["title"]),
        url: getCompanionValue("url", data["url"]));
  }

  VideosCompanion _fromAppVideo(AppVideo video) {
    return VideosCompanion(
        id: Value(video.id),
        title: Value(video.title),
        description: Value(video.description),
        height: Value(video.height),
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
        uploader: Value(video.uploader),
        publishedAt: Value(video.publishedAt),
        publishedAtStr: Value(video.publishedAtStr),
        provider: Value(video.provider.toString()),
        thumbnailUrl: Value(video.thumbnail),
        url: Value(video.url),
        width: Value(video.width));
  }

  AppVideo _fromData(VideoData videoData) {
    return AppVideo(
        provider: getVideoProviderFromString(videoData.provider),
        title: videoData.title,
        url: videoData.url,
        height: videoData.height,
        width: videoData.width,
        publishedAtStr: videoData.publishedAtStr,
        publishedAt: videoData.publishedAt,
        description: videoData.description,
        thumbnail: videoData.thumbnailUrl,
        uploader: videoData.uploader,
        id: videoData.id);
  }

  @override
  Future<AppVideo> findById(id) async {
    final VideoData videoData = await (database.select(database.videos)
          ..where((t) => t.id.equals(id)))
        .getSingle();
    return _fromData(videoData);
  }

  @override
  Future<AppVideo> updateById(id, AppVideo videoToUpdate) async {
    final Map<String, dynamic> videoToUpdateMap = videoToUpdate.toMap();
    videoToUpdateMap.update("id", (value) => id.toString());
    final VideosCompanion updateCompanion = _fromMap(videoToUpdateMap);
    await (database.update(database.videos)
          ..where((tbl) => tbl.id.equals(id.toString())))
        .write(updateCompanion);
    final AppVideo video = await findById(id);
    return video;
  }

  Future<List<AppVideo>> findByIds(List<String> ids) async {
    final List<VideoData> videosData = await (database.select(database.videos)
          ..where((tbl) => tbl.id.isIn(ids)))
        .get();
    return videosData
        .map((VideoData videoData) => _fromData(videoData))
        .toList();
  }

  @override
  Future<void> removeById(id) async {
    await (database.delete(database.videos)
          ..where((tbl) => tbl.id.equals(id.toString())))
        .go();
  }

  Future<void> batchRemove(List<String> idsToRemove) async {
    await (database.delete(database.videos)
          ..where((tbl) => tbl.id.isIn(idsToRemove)))
        .go();
  }
}
