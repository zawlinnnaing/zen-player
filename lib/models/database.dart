import 'dart:io';import 'package:moor/ffi.dart';import 'package:moor/moor.dart';import 'package:path/path.dart' as path;import 'package:path_provider/path_provider.dart';import 'package:zen_player/modules/vendors/video.dart';part 'database.g.dart';class DBTimestamps {  DateTime? createdAt;  DateTime? updatedAt;  DBTimestamps({this.createdAt, this.updatedAt});}@DataClassName("VideoData")class Videos extends Table {  TextColumn get id => text()();  TextColumn get title => text()();  TextColumn get url => text()();  TextColumn get description => text().nullable()();  TextColumn get publishedAtStr => text().nullable()();  DateTimeColumn get publishedAt => dateTime().nullable()();  TextColumn get thumbnailUrl => text().nullable()();  TextColumn get uploader => text().nullable()();  TextColumn get provider =>      text().withDefault(Constant(AppVideoProvider.YouTube.toString()))();  RealColumn get width => real().nullable()();  RealColumn get height => real().nullable()();  DateTimeColumn get createdAt => dateTime()();  DateTimeColumn get updatedAt => dateTime()();  @override  Set<Column> get primaryKey => {id};}@DataClassName("PlayListData")class PlayLists extends Table {  IntColumn get id => integer().autoIncrement()();  TextColumn get name => text()();  BoolColumn get isBuiltIn => boolean().withDefault(Constant(false))();  DateTimeColumn get createdAt => dateTime()();  DateTimeColumn get updatedAt => dateTime()();}LazyDatabase _openConnection() {  return LazyDatabase(() async {    final dbFolder = await getApplicationDocumentsDirectory();    final file = File(path.join(dbFolder.path, 'zenplayer.sqlite'));    return VmDatabase(file);  });}@UseMoor(tables: [Videos, PlayLists])class MyDatabase extends _$MyDatabase {  // MyDatabase() : super(_openConnection());  static final MyDatabase _instance = MyDatabase._internal();  MyDatabase._internal() : super(_openConnection());  factory MyDatabase() {    return _instance;  }  /// For testing purpose only, don't use in code.  MyDatabase.forTest(QueryExecutor e) : super(e);  @override  int get schemaVersion => 1;}