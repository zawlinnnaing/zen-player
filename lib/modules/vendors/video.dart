import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:zen_player/models/database.dart';
import 'package:zen_player/models/video.dart';

enum AppVideoProvider { YouTube }

AppVideoProvider getVideoProviderFromString(String value) {
  return AppVideoProvider.values.firstWhere((element) {
    return element.toString() == value;
  });
}

class AppVideo {
  final String id;
  final String title;
  final String url;
  final String? uploader;
  final String? thumbnail;
  final DateTime? publishedAt;
  String? publishedAtStr;
  final String? description;
  final AppVideoProvider provider;
  double? width;
  double? height;
  bool? isVertical;
  AppVideo(
      {required this.title,
      required this.id,
      required this.url,
      this.uploader,
      this.thumbnail,
      this.publishedAt,
      this.publishedAtStr,
      required this.provider,
      this.width,
      this.height,
      this.description}) {
    if (this.publishedAtStr == null || this.publishedAtStr == "Unknown") {
      if (this.publishedAt != null) {
        this.publishedAtStr = DateFormat.yMMMd().format(this.publishedAt!);
      }
    }
    if (this.width != null && this.height != null) {
      this.isVertical = this.height! >= this.width!;
    }
  }
  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "title": this.title,
      "description": this.description,
      "publishedAtStr": this.publishedAtStr,
      "thumbnail": this.thumbnail,
      "url": this.url,
      "width": this.width,
      "height": this.height,
      "provider": this.provider,
    };
  }

  @override
  bool operator ==(Object other) {
    if (!(other is AppVideo)) {
      return false;
    }
    return other.id == this.id &&
        other.title == this.title &&
        other.description == this.description &&
        other.url == this.url &&
        other.publishedAtStr == this.publishedAtStr &&
        other.publishedAt == this.publishedAt &&
        other.width == this.width &&
        other.height == this.height &&
        other.thumbnail == this.thumbnail &&
        other.provider == this.provider;
  }

  @override
  String toString() {
    return 'ID: $id , Title: $title, Uploader: $uploader, Published At: $publishedAtStr, width: ${this.width.toString()} and height: ${this.height.toString()}';
  }

  @override
  int get hashCode => super.hashCode;
}
