import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:zen_player/modules/vendors/video.dart';

part 'database.g.dart';

class DBTimestamps {
  DateTime? createdAt;
  DateTime? updatedAt;

  DBTimestamps({this.createdAt, this.updatedAt});
}

@DataClassName("VideoData")
class Videos extends Table {
  TextColumn get id => text()();

  TextColumn get title => text()();

  TextColumn get url => text()();

  TextColumn get description => text().nullable()();

  TextColumn get publishedAtStr => text().nullable()();

  DateTimeColumn get publishedAt => dateTime().nullable()();

  TextColumn get thumbnailUrl => text().nullable()();

  TextColumn get uploader => text().nullable()();

  TextColumn get provider =>
      text().withDefault(Constant(AppVideoProvider.YouTube.toString()))();

  RealColumn get width => real().nullable()();

  RealColumn get height => real().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();

  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now())();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName("VideoPlayList")
class VideosPlayLists extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get videoId =>
      text().customConstraint("NOT NULL REFERENCES videos (id)")();

  IntColumn get playListId =>
      integer().customConstraint("NOT NULL REFERENCES playlists (id)")();

  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();

  @override
  List<String> get customConstraints =>
      ["UNIQUE (video_id, play_list_id) ON CONFLICT REPLACE"];
}

@DataClassName("PlayListData")
class PlayLists extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().customConstraint("NOT NULL UNIQUE")();

  BoolColumn get isBuiltIn => boolean().withDefault(Constant(false))();

  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();

  DateTimeColumn get updatedAt =>
      dateTime().clientDefault(() => DateTime.now())();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'zenplayer.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Videos, PlayLists, VideosPlayLists])
class MyDatabase extends _$MyDatabase {
  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (Migrator m) {
        return m.createAll();
      }, onUpgrade:
          (Migrator m, int schemaVersionFrom, int schemaVersionTo) async {
        if (schemaVersionFrom == 1) {
          await m.createTable(videosPlayLists);
        }
      });

  static final MyDatabase _instance = MyDatabase._internal();

  factory MyDatabase() {
    return _instance;
  }

  MyDatabase._internal() : super(_openConnection());

  Future<void> deleteAll() async {
    if (Platform.environment.containsKey("FLUTTER_TEST")) {
      return transaction(() async {
        for (final table in allTables) {
          await delete(table).go();
        }
      });
    }
  }

  /// For testing purpose only, don't use in code.
  MyDatabase.forTest(QueryExecutor e) : super(e);
}
