import 'dart:developer';import 'package:flutter/cupertino.dart';import 'package:flutter/material.dart';import 'package:zen_player/modules/search/SearchButton.dart';import 'package:zen_player/modules/vendors/base_vendor.dart';import 'package:zen_player/modules/vendors/factory.dart';import 'package:zen_player/modules/vendors/video.dart';import 'package:zen_player/modules/videos_list/VideosArgument.dart';import 'package:zen_player/modules/videos_list/VideosList.dart';class VideosLoading extends StatelessWidget {  @override  Widget build(BuildContext context) {    return Container(      child: Center(        child: Text("Loading"),      ),    );  }}class VideosPage extends StatefulWidget {  final String? name;  VideosPage({this.name});  @override  State<StatefulWidget> createState() {    return _VideoPageState();  }}class _VideoPageState extends State<VideosPage> {  List<Video> _videos = [];  bool _loading = false;  BaseVendor _videoVendor = VendorFactory.fromVendorType();  Future<void> _getVideos() async {    log("Getting videos");    setState(() {      _loading = true;    });    List<Video> _res = await _videoVendor.search(widget.name ?? "");    _res.forEach((element) {      log("Video: ${element.toString()}");    });    setState(() {      _loading = false;      _videos = _res;    });  }  @override  void initState() {    super.initState();    _getVideos();  }  @override  didUpdateWidget(covariant VideosPage oldWidget) {    super.didUpdateWidget(oldWidget);    log("Widget updated");    if (oldWidget.name != widget.name) {      _getVideos();    }  }  @override  Widget build(BuildContext context) {    return Scaffold(      appBar: AppBar(        title: Text(          widget.name ?? "No name",          style: Theme.of(context).textTheme.headline6,        ),        actions: [          SearchButton(            replaceRoute: true,          )        ],      ),      body: Container(        child: _loading            ? VideosLoading()            : VideosList(                videos: _videos,              ),      ),    );  }}class _ViewModel {}class VideosPageContainer extends StatelessWidget {  @override  Widget build(BuildContext context) {    VideosArgument argument =        ModalRoute.of(context)!.settings.arguments as VideosArgument;    return VideosPage(      name: argument.name,    );  }}