import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zen_player/errors/api_error.dart';
import 'package:zen_player/layout/Default.dart';
import 'package:zen_player/modules/search/SearchButton.dart';
import 'package:zen_player/modules/vendors/base_vendor.dart';
import 'package:zen_player/modules/vendors/factory.dart';
import 'package:zen_player/modules/vendors/video.dart';
import 'package:zen_player/modules/videos_list/VideoError.dart';
import 'package:zen_player/modules/videos_list/video_argument.dart';
import 'package:zen_player/modules/videos_list/VideosList.dart';
import 'package:zen_player/utils/config.dart';

class VideosLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Loading"),
      ),
    );
  }
}

class VideosPage extends StatefulWidget {
  final String? name;
  VideosPage({this.name});
  @override
  State<StatefulWidget> createState() {
    return _VideoPageState();
  }
}

class _VideoPageState extends State<VideosPage> {
  List<AppVideo> _videos = [];
  bool _loading = false;
  String _errorMsg = "";
  BaseVendor _videoVendor = VendorFactory.fromVendorType();
  Future<void> _getVideos() async {
    try {
      setState(() {
        _loading = true;
      });
      List<AppVideo> _res = await _videoVendor.search(widget.name ?? "");
      _res.forEach((element) {
        log("Video: ${element.toString()}");
      });
      setState(() {
        _errorMsg = "";
        _videos = _res;
      });
    } catch (error, stacktrace) {
      log("Fetch videos error: ${error.toString()}: stacktrace: ${stacktrace.toString()}");
      late String _tmpErrMsg;
      if (error is ApiError) {
        _tmpErrMsg =
            error.message ?? "Something went wrong when fetching videos.";
      } else {
        _tmpErrMsg = "Something went wrong when fetching videos.";
      }
      setState(() {
        _errorMsg = _tmpErrMsg;
        _videos = [];
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Widget _renderVideos() {
    if (_loading) {
      return VideosLoading();
    }
    if (_errorMsg.isNotEmpty) {
      return VideoError(
        errorMsg: _errorMsg,
      );
    }
    if (_videos.isEmpty) {
      return Container(
        child: Center(
          child: Text("There is no videos found."),
        ),
      );
    }
    return VideosList(videos: _videos);
  }

  @override
  void initState() {
    super.initState();
    _getVideos();
  }

  @override
  didUpdateWidget(covariant VideosPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    log("Widget updated");
    if (oldWidget.name != widget.name) {
      _getVideos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: appbarHeight,
        title: Text(
          widget.name ?? "No name",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          SearchButton(
            replaceRoute: true,
          )
        ],
      ),
      body: Container(
        child: _renderVideos(),
      ),
    );
  }
}

class _ViewModel {}

class VideosPageContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VideosArgument argument =
        ModalRoute.of(context)!.settings.arguments as VideosArgument;
    return VideosPage(
      name: argument.name,
    );
  }
}
