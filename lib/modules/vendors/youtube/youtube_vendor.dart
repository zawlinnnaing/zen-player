import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:zen_player/errors/api_error.dart';
import 'package:zen_player/modules/vendors/video.dart';
import 'package:zen_player/modules/vendors/base_vendor.dart';
import 'package:zen_player/modules/vendors/youtube/youtube_parser.dart';
import 'package:zen_player/utils/util.dart';

class YouTubeVendor implements BaseVendor {
  final String secret;
  late Dio _client;
  final int _maxResult = 30;

  YouTubeVendor(this.secret) {
    if (this.secret.isEmpty) {
      throw ArgumentError("Must provide api key for YouTube. Arg: Secret");
    }
    _client = Dio(BaseOptions(
        baseUrl: "https://www.googleapis.com/youtube/v3",
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json"
        },
        queryParameters: {
          "key": this.secret
        }));
  }

  @override
  Future<AppVideo?> getVideo(String videoId) async {
    Response response = await this._client.get("/videos",
        queryParameters: {"part": "snippet", "hl": "en", "id": videoId});
    if (response.data == null || (response.data['items'] as List).isEmpty) {
      return null;
    }
    Map<String, dynamic> videoJson = response.data['items'][0]['snippet'];
    Map<String, dynamic> thumbnailJson = videoJson["thumbnails"]["standard"] ??
        videoJson["thumbnails"]["default"];
    log("video detail: ${videoId.toString()}");
    return AppVideo(
        title: videoJson['title'],
        id: videoId,
        provider: AppVideoProvider.YouTube,
        url: "https://www.youtube.com/watch?v=$videoId",
        thumbnail: thumbnailJson['url'],
        width: (thumbnailJson['width'] as int).toDouble(),
        height: (thumbnailJson['height'] as int).toDouble(),
        publishedAt: DateTime.parse(videoJson['publishedAt']),
        uploader: videoJson['channelTitle'],
        description: videoJson['description']);
  }

  Future<AppVideo?> _fromUrl(String url) async {
    try {
      Uri videoUri = Uri.parse(url);
      String? videoId = videoUri.queryParameters['v'] ??
          (videoUri.pathSegments.isNotEmpty
              ? videoUri.pathSegments.last
              : null); // does not have youtube video id.
      if (videoId == null || videoId.isEmpty) {
        return null;
      }
      return this.getVideo(videoId);
    } catch (error) {
      if (error is DioError && error.response == null) {
        throw ApiError(
            statusCode: "503",
            message:
                "Host not reachable. You may not be connected to internet");
      }
      throw error;
    }
  }

  @override
  Future<List<AppVideo>> search(String keyword) async {
    log("Sending api: $keyword");
    if (keyword.isEmpty) {
      return [];
    }
    if (AppUtility.isUrl(keyword)) {
      AppVideo? video = await this._fromUrl(keyword);
      return video == null ? [] : [video];
    }
    final List videos = await YouTubeParser.search(keyword);
    videos.forEach((element) {
      log("Element: ${element.toString()}");
    });
    return videos
        .where((element) => element != null)
        .map((e) => YouTubeParser.fromJson(e))
        .where((element) => element != null)
        .map((e) => e!)
        .toList();
  }
}
