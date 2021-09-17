import 'dart:convert';import 'dart:developer';import 'package:html/dom.dart';import 'package:html/parser.dart' show parse;import 'package:dio/dio.dart';import 'package:zen_player/errors/api_error.dart';import 'package:zen_player/modules/vendors/video.dart';final Dio _client = Dio(BaseOptions(baseUrl: "https://youtube.com"));class YouTubeParser {  static List _extractVideosListFromRaw(Map<String, dynamic> data) {    return (data['contents']['twoColumnSearchResultsRenderer']                ['primaryContents']['sectionListRenderer']['contents'][0]            ['itemSectionRenderer']['contents'] as List)        .map((e) => e['videoRenderer'])        .toList();  }  static Future<List> search(keyword) async {    try {      final String searchPattern = "ytInitialData = ";      Response? res = await _client.get("/results",          queryParameters: {"search_query": keyword, "hl": "en"});      Document document = parse(res.data.toString());      // log("parser document original ${res.data.toString()}");      List<Element> _scripts = document.getElementsByTagName('script');      List _scriptsOfInterest = _scripts.where((_script) {        String _scriptStr = _script.innerHtml;        return _scriptStr.split(searchPattern).length > 1;      }).toList();      if (_scriptsOfInterest.isEmpty) {        throw Exception("Can't parse youtube search result.");      }      Element _dataElement = _scriptsOfInterest.first;      String rawDataStr = _dataElement.innerHtml.split(searchPattern).last;      // log("raw data str $rawDataStr");      Map<String, dynamic> rawData = jsonDecode(rawDataStr.endsWith(";")          ? rawDataStr.substring(0, rawDataStr.length - 1)          : rawDataStr);      return _extractVideosListFromRaw(rawData);    } catch (error) {      if (error is DioError) {        if (error.response == null) {          throw new ApiError(              statusCode: "503",              message:                  "Host not reachable. You may not be connected to the internet.");        }      }      throw error;    }  }  static Video? fromJson(Map json) {    try {      final List thumbnails = json['thumbnail']['thumbnails'] as List;      final String title = (json['title']['runs'] as List).first['text'];      final String uploader = (json['ownerText']['runs'] as List).first['text'];      final String publishTimeStr =          json['publishedTimeText']['simpleText'] ?? "Unknown";      final List descArr = (json['detailedMetadataSnippets'] as List)          .first['snippetText']['runs'];      final String desc = descArr.map((e) => e['text']).join("");      return Video(          title: title,          id: json['videoId'],          thumbnail: thumbnails.last['url'],          publishedAtStr: publishTimeStr,          description: desc,          uploader: uploader);    } catch (e) {      log("Convert JSON to Video Error: ${e.toString()}");      return null;    }  }}