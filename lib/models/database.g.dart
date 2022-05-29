// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class VideoData extends DataClass implements Insertable<VideoData> {
  final String id;
  final String title;
  final String url;
  final String? description;
  final String? publishedAtStr;
  final DateTime? publishedAt;
  final String? thumbnailUrl;
  final String? uploader;
  final String provider;
  final double? width;
  final double? height;
  final DateTime createdAt;
  final DateTime updatedAt;
  VideoData(
      {required this.id,
      required this.title,
      required this.url,
      this.description,
      this.publishedAtStr,
      this.publishedAt,
      this.thumbnailUrl,
      this.uploader,
      required this.provider,
      this.width,
      this.height,
      required this.createdAt,
      required this.updatedAt});
  factory VideoData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return VideoData(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      url: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}url'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      publishedAtStr: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}published_at_str']),
      publishedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}published_at']),
      thumbnailUrl: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}thumbnail_url']),
      uploader: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}uploader']),
      provider: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}provider'])!,
      width: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}width']),
      height: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}height']),
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['url'] = Variable<String>(url);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String?>(description);
    }
    if (!nullToAbsent || publishedAtStr != null) {
      map['published_at_str'] = Variable<String?>(publishedAtStr);
    }
    if (!nullToAbsent || publishedAt != null) {
      map['published_at'] = Variable<DateTime?>(publishedAt);
    }
    if (!nullToAbsent || thumbnailUrl != null) {
      map['thumbnail_url'] = Variable<String?>(thumbnailUrl);
    }
    if (!nullToAbsent || uploader != null) {
      map['uploader'] = Variable<String?>(uploader);
    }
    map['provider'] = Variable<String>(provider);
    if (!nullToAbsent || width != null) {
      map['width'] = Variable<double?>(width);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<double?>(height);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  VideosCompanion toCompanion(bool nullToAbsent) {
    return VideosCompanion(
      id: Value(id),
      title: Value(title),
      url: Value(url),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      publishedAtStr: publishedAtStr == null && nullToAbsent
          ? const Value.absent()
          : Value(publishedAtStr),
      publishedAt: publishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(publishedAt),
      thumbnailUrl: thumbnailUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnailUrl),
      uploader: uploader == null && nullToAbsent
          ? const Value.absent()
          : Value(uploader),
      provider: Value(provider),
      width:
          width == null && nullToAbsent ? const Value.absent() : Value(width),
      height:
          height == null && nullToAbsent ? const Value.absent() : Value(height),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory VideoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return VideoData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      url: serializer.fromJson<String>(json['url']),
      description: serializer.fromJson<String?>(json['description']),
      publishedAtStr: serializer.fromJson<String?>(json['publishedAtStr']),
      publishedAt: serializer.fromJson<DateTime?>(json['publishedAt']),
      thumbnailUrl: serializer.fromJson<String?>(json['thumbnailUrl']),
      uploader: serializer.fromJson<String?>(json['uploader']),
      provider: serializer.fromJson<String>(json['provider']),
      width: serializer.fromJson<double?>(json['width']),
      height: serializer.fromJson<double?>(json['height']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'url': serializer.toJson<String>(url),
      'description': serializer.toJson<String?>(description),
      'publishedAtStr': serializer.toJson<String?>(publishedAtStr),
      'publishedAt': serializer.toJson<DateTime?>(publishedAt),
      'thumbnailUrl': serializer.toJson<String?>(thumbnailUrl),
      'uploader': serializer.toJson<String?>(uploader),
      'provider': serializer.toJson<String>(provider),
      'width': serializer.toJson<double?>(width),
      'height': serializer.toJson<double?>(height),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  VideoData copyWith(
          {String? id,
          String? title,
          String? url,
          String? description,
          String? publishedAtStr,
          DateTime? publishedAt,
          String? thumbnailUrl,
          String? uploader,
          String? provider,
          double? width,
          double? height,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      VideoData(
        id: id ?? this.id,
        title: title ?? this.title,
        url: url ?? this.url,
        description: description ?? this.description,
        publishedAtStr: publishedAtStr ?? this.publishedAtStr,
        publishedAt: publishedAt ?? this.publishedAt,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
        uploader: uploader ?? this.uploader,
        provider: provider ?? this.provider,
        width: width ?? this.width,
        height: height ?? this.height,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('VideoData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('url: $url, ')
          ..write('description: $description, ')
          ..write('publishedAtStr: $publishedAtStr, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('thumbnailUrl: $thumbnailUrl, ')
          ..write('uploader: $uploader, ')
          ..write('provider: $provider, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      url,
      description,
      publishedAtStr,
      publishedAt,
      thumbnailUrl,
      uploader,
      provider,
      width,
      height,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VideoData &&
          other.id == this.id &&
          other.title == this.title &&
          other.url == this.url &&
          other.description == this.description &&
          other.publishedAtStr == this.publishedAtStr &&
          other.publishedAt == this.publishedAt &&
          other.thumbnailUrl == this.thumbnailUrl &&
          other.uploader == this.uploader &&
          other.provider == this.provider &&
          other.width == this.width &&
          other.height == this.height &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class VideosCompanion extends UpdateCompanion<VideoData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> url;
  final Value<String?> description;
  final Value<String?> publishedAtStr;
  final Value<DateTime?> publishedAt;
  final Value<String?> thumbnailUrl;
  final Value<String?> uploader;
  final Value<String> provider;
  final Value<double?> width;
  final Value<double?> height;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const VideosCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.url = const Value.absent(),
    this.description = const Value.absent(),
    this.publishedAtStr = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.thumbnailUrl = const Value.absent(),
    this.uploader = const Value.absent(),
    this.provider = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  VideosCompanion.insert({
    required String id,
    required String title,
    required String url,
    this.description = const Value.absent(),
    this.publishedAtStr = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.thumbnailUrl = const Value.absent(),
    this.uploader = const Value.absent(),
    this.provider = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        url = Value(url);
  static Insertable<VideoData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? url,
    Expression<String?>? description,
    Expression<String?>? publishedAtStr,
    Expression<DateTime?>? publishedAt,
    Expression<String?>? thumbnailUrl,
    Expression<String?>? uploader,
    Expression<String>? provider,
    Expression<double?>? width,
    Expression<double?>? height,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (url != null) 'url': url,
      if (description != null) 'description': description,
      if (publishedAtStr != null) 'published_at_str': publishedAtStr,
      if (publishedAt != null) 'published_at': publishedAt,
      if (thumbnailUrl != null) 'thumbnail_url': thumbnailUrl,
      if (uploader != null) 'uploader': uploader,
      if (provider != null) 'provider': provider,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  VideosCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? url,
      Value<String?>? description,
      Value<String?>? publishedAtStr,
      Value<DateTime?>? publishedAt,
      Value<String?>? thumbnailUrl,
      Value<String?>? uploader,
      Value<String>? provider,
      Value<double?>? width,
      Value<double?>? height,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return VideosCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      description: description ?? this.description,
      publishedAtStr: publishedAtStr ?? this.publishedAtStr,
      publishedAt: publishedAt ?? this.publishedAt,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      uploader: uploader ?? this.uploader,
      provider: provider ?? this.provider,
      width: width ?? this.width,
      height: height ?? this.height,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (description.present) {
      map['description'] = Variable<String?>(description.value);
    }
    if (publishedAtStr.present) {
      map['published_at_str'] = Variable<String?>(publishedAtStr.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<DateTime?>(publishedAt.value);
    }
    if (thumbnailUrl.present) {
      map['thumbnail_url'] = Variable<String?>(thumbnailUrl.value);
    }
    if (uploader.present) {
      map['uploader'] = Variable<String?>(uploader.value);
    }
    if (provider.present) {
      map['provider'] = Variable<String>(provider.value);
    }
    if (width.present) {
      map['width'] = Variable<double?>(width.value);
    }
    if (height.present) {
      map['height'] = Variable<double?>(height.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VideosCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('url: $url, ')
          ..write('description: $description, ')
          ..write('publishedAtStr: $publishedAtStr, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('thumbnailUrl: $thumbnailUrl, ')
          ..write('uploader: $uploader, ')
          ..write('provider: $provider, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $VideosTable extends Videos with TableInfo<$VideosTable, VideoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VideosTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String?> url = GeneratedColumn<String?>(
      'url', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _publishedAtStrMeta =
      const VerificationMeta('publishedAtStr');
  @override
  late final GeneratedColumn<String?> publishedAtStr = GeneratedColumn<String?>(
      'published_at_str', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _publishedAtMeta =
      const VerificationMeta('publishedAt');
  @override
  late final GeneratedColumn<DateTime?> publishedAt =
      GeneratedColumn<DateTime?>('published_at', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _thumbnailUrlMeta =
      const VerificationMeta('thumbnailUrl');
  @override
  late final GeneratedColumn<String?> thumbnailUrl = GeneratedColumn<String?>(
      'thumbnail_url', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _uploaderMeta = const VerificationMeta('uploader');
  @override
  late final GeneratedColumn<String?> uploader = GeneratedColumn<String?>(
      'uploader', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _providerMeta = const VerificationMeta('provider');
  @override
  late final GeneratedColumn<String?> provider = GeneratedColumn<String?>(
      'provider', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: Constant(AppVideoProvider.YouTube.toString()));
  final VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<double?> width = GeneratedColumn<double?>(
      'width', aliasedName, true,
      type: const RealType(), requiredDuringInsert: false);
  final VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double?> height = GeneratedColumn<double?>(
      'height', aliasedName, true,
      type: const RealType(), requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime?> updatedAt = GeneratedColumn<DateTime?>(
      'updated_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        url,
        description,
        publishedAtStr,
        publishedAt,
        thumbnailUrl,
        uploader,
        provider,
        width,
        height,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? 'videos';
  @override
  String get actualTableName => 'videos';
  @override
  VerificationContext validateIntegrity(Insertable<VideoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('published_at_str')) {
      context.handle(
          _publishedAtStrMeta,
          publishedAtStr.isAcceptableOrUnknown(
              data['published_at_str']!, _publishedAtStrMeta));
    }
    if (data.containsKey('published_at')) {
      context.handle(
          _publishedAtMeta,
          publishedAt.isAcceptableOrUnknown(
              data['published_at']!, _publishedAtMeta));
    }
    if (data.containsKey('thumbnail_url')) {
      context.handle(
          _thumbnailUrlMeta,
          thumbnailUrl.isAcceptableOrUnknown(
              data['thumbnail_url']!, _thumbnailUrlMeta));
    }
    if (data.containsKey('uploader')) {
      context.handle(_uploaderMeta,
          uploader.isAcceptableOrUnknown(data['uploader']!, _uploaderMeta));
    }
    if (data.containsKey('provider')) {
      context.handle(_providerMeta,
          provider.isAcceptableOrUnknown(data['provider']!, _providerMeta));
    }
    if (data.containsKey('width')) {
      context.handle(
          _widthMeta, width.isAcceptableOrUnknown(data['width']!, _widthMeta));
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VideoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return VideoData.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $VideosTable createAlias(String alias) {
    return $VideosTable(attachedDatabase, alias);
  }
}

class PlayListData extends DataClass implements Insertable<PlayListData> {
  final int id;
  final String name;
  final bool isBuiltIn;
  final DateTime createdAt;
  final DateTime updatedAt;
  PlayListData(
      {required this.id,
      required this.name,
      required this.isBuiltIn,
      required this.createdAt,
      required this.updatedAt});
  factory PlayListData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return PlayListData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      isBuiltIn: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_built_in'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['is_built_in'] = Variable<bool>(isBuiltIn);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PlayListsCompanion toCompanion(bool nullToAbsent) {
    return PlayListsCompanion(
      id: Value(id),
      name: Value(name),
      isBuiltIn: Value(isBuiltIn),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PlayListData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return PlayListData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      isBuiltIn: serializer.fromJson<bool>(json['isBuiltIn']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'isBuiltIn': serializer.toJson<bool>(isBuiltIn),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PlayListData copyWith(
          {int? id,
          String? name,
          bool? isBuiltIn,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      PlayListData(
        id: id ?? this.id,
        name: name ?? this.name,
        isBuiltIn: isBuiltIn ?? this.isBuiltIn,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('PlayListData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, isBuiltIn, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayListData &&
          other.id == this.id &&
          other.name == this.name &&
          other.isBuiltIn == this.isBuiltIn &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PlayListsCompanion extends UpdateCompanion<PlayListData> {
  final Value<int> id;
  final Value<String> name;
  final Value<bool> isBuiltIn;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PlayListsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PlayListsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.isBuiltIn = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<PlayListData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<bool>? isBuiltIn,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (isBuiltIn != null) 'is_built_in': isBuiltIn,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PlayListsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<bool>? isBuiltIn,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return PlayListsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isBuiltIn.present) {
      map['is_built_in'] = Variable<bool>(isBuiltIn.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayListsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PlayListsTable extends PlayLists
    with TableInfo<$PlayListsTable, PlayListData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayListsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL UNIQUE');
  final VerificationMeta _isBuiltInMeta = const VerificationMeta('isBuiltIn');
  @override
  late final GeneratedColumn<bool?> isBuiltIn = GeneratedColumn<bool?>(
      'is_built_in', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_built_in IN (0, 1))',
      defaultValue: Constant(false));
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime?> updatedAt = GeneratedColumn<DateTime?>(
      'updated_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, isBuiltIn, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? 'play_lists';
  @override
  String get actualTableName => 'play_lists';
  @override
  VerificationContext validateIntegrity(Insertable<PlayListData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_built_in')) {
      context.handle(
          _isBuiltInMeta,
          isBuiltIn.isAcceptableOrUnknown(
              data['is_built_in']!, _isBuiltInMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlayListData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return PlayListData.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PlayListsTable createAlias(String alias) {
    return $PlayListsTable(attachedDatabase, alias);
  }
}

class VideoPlayList extends DataClass implements Insertable<VideoPlayList> {
  final int id;
  final String videoId;
  final int playListId;
  final DateTime createdAt;
  VideoPlayList(
      {required this.id,
      required this.videoId,
      required this.playListId,
      required this.createdAt});
  factory VideoPlayList.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return VideoPlayList(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      videoId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}video_id'])!,
      playListId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}play_list_id'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['video_id'] = Variable<String>(videoId);
    map['play_list_id'] = Variable<int>(playListId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  VideosPlayListsCompanion toCompanion(bool nullToAbsent) {
    return VideosPlayListsCompanion(
      id: Value(id),
      videoId: Value(videoId),
      playListId: Value(playListId),
      createdAt: Value(createdAt),
    );
  }

  factory VideoPlayList.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return VideoPlayList(
      id: serializer.fromJson<int>(json['id']),
      videoId: serializer.fromJson<String>(json['videoId']),
      playListId: serializer.fromJson<int>(json['playListId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'videoId': serializer.toJson<String>(videoId),
      'playListId': serializer.toJson<int>(playListId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  VideoPlayList copyWith(
          {int? id, String? videoId, int? playListId, DateTime? createdAt}) =>
      VideoPlayList(
        id: id ?? this.id,
        videoId: videoId ?? this.videoId,
        playListId: playListId ?? this.playListId,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('VideoPlayList(')
          ..write('id: $id, ')
          ..write('videoId: $videoId, ')
          ..write('playListId: $playListId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, videoId, playListId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VideoPlayList &&
          other.id == this.id &&
          other.videoId == this.videoId &&
          other.playListId == this.playListId &&
          other.createdAt == this.createdAt);
}

class VideosPlayListsCompanion extends UpdateCompanion<VideoPlayList> {
  final Value<int> id;
  final Value<String> videoId;
  final Value<int> playListId;
  final Value<DateTime> createdAt;
  const VideosPlayListsCompanion({
    this.id = const Value.absent(),
    this.videoId = const Value.absent(),
    this.playListId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  VideosPlayListsCompanion.insert({
    this.id = const Value.absent(),
    required String videoId,
    required int playListId,
    this.createdAt = const Value.absent(),
  })  : videoId = Value(videoId),
        playListId = Value(playListId);
  static Insertable<VideoPlayList> custom({
    Expression<int>? id,
    Expression<String>? videoId,
    Expression<int>? playListId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (videoId != null) 'video_id': videoId,
      if (playListId != null) 'play_list_id': playListId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  VideosPlayListsCompanion copyWith(
      {Value<int>? id,
      Value<String>? videoId,
      Value<int>? playListId,
      Value<DateTime>? createdAt}) {
    return VideosPlayListsCompanion(
      id: id ?? this.id,
      videoId: videoId ?? this.videoId,
      playListId: playListId ?? this.playListId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (videoId.present) {
      map['video_id'] = Variable<String>(videoId.value);
    }
    if (playListId.present) {
      map['play_list_id'] = Variable<int>(playListId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VideosPlayListsCompanion(')
          ..write('id: $id, ')
          ..write('videoId: $videoId, ')
          ..write('playListId: $playListId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $VideosPlayListsTable extends VideosPlayLists
    with TableInfo<$VideosPlayListsTable, VideoPlayList> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VideosPlayListsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _videoIdMeta = const VerificationMeta('videoId');
  @override
  late final GeneratedColumn<String?> videoId = GeneratedColumn<String?>(
      'video_id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES videos (id)');
  final VerificationMeta _playListIdMeta = const VerificationMeta('playListId');
  @override
  late final GeneratedColumn<int?> playListId = GeneratedColumn<int?>(
      'play_list_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES playlists (id)');
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  @override
  List<GeneratedColumn> get $columns => [id, videoId, playListId, createdAt];
  @override
  String get aliasedName => _alias ?? 'videos_play_lists';
  @override
  String get actualTableName => 'videos_play_lists';
  @override
  VerificationContext validateIntegrity(Insertable<VideoPlayList> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('video_id')) {
      context.handle(_videoIdMeta,
          videoId.isAcceptableOrUnknown(data['video_id']!, _videoIdMeta));
    } else if (isInserting) {
      context.missing(_videoIdMeta);
    }
    if (data.containsKey('play_list_id')) {
      context.handle(
          _playListIdMeta,
          playListId.isAcceptableOrUnknown(
              data['play_list_id']!, _playListIdMeta));
    } else if (isInserting) {
      context.missing(_playListIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VideoPlayList map(Map<String, dynamic> data, {String? tablePrefix}) {
    return VideoPlayList.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $VideosPlayListsTable createAlias(String alias) {
    return $VideosPlayListsTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $VideosTable videos = $VideosTable(this);
  late final $PlayListsTable playLists = $PlayListsTable(this);
  late final $VideosPlayListsTable videosPlayLists =
      $VideosPlayListsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [videos, playLists, videosPlayLists];
}
