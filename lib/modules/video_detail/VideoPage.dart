import 'dart:developer';import 'package:flutter/cupertino.dart';import 'package:flutter/material.dart';import 'package:zen_player/modules/common/Loading.dart';import 'package:zen_player/modules/vendors/factory.dart';import 'package:zen_player/modules/vendors/video.dart';import 'package:zen_player/modules/video_detail/DescriptionSection.dart';import 'package:zen_player/modules/video_detail/players/player_factory.dart';import 'package:zen_player/utils/config.dart';class VideoPage extends StatefulWidget {  final AppVideo? appVideo;  VideoPage({required this.appVideo});  @override  State<StatefulWidget> createState() {    return _VideoPageState();  }}class _VideoPageState extends State<VideoPage> {  AppVideo? video;  bool loading = true;  Future<void> _fetchVideo(String id) async {    try {      AppVideo? fetchedVideo =          await VendorFactory.fromVendorType().getVideo(id);      setState(() {        video = fetchedVideo;      });    } catch (error) {      log("Fetch Video Error ${error.toString()}");      ScaffoldMessenger.of(context)          .showSnackBar(SnackBar(content: Text("Unable to load video")));    } finally {      setState(() {        loading = false;      });    }  }  @override  void initState() {    super.initState();    if (widget.appVideo != null) {      _fetchVideo(widget.appVideo!.id);    }  }  @override  Widget build(BuildContext context) {    if (!loading && video == null) {      Navigator.of(context).pop();      return Container();    }    return Scaffold(      resizeToAvoidBottomInset: false,      appBar: MediaQuery.of(context).orientation == Orientation.landscape          ? null          : AppBar(              toolbarHeight: appbarHeight,              title: Text(                video?.title ?? "No video",                style: Theme.of(context).textTheme.headline6!,              ),            ),      body: loading          ? Loading()          : LayoutBuilder(              builder: (context, BoxConstraints constraints) {                return ListView(                  children: [                    ConstrainedBox(                      constraints:                          BoxConstraints(maxHeight: constraints.maxHeight),                      child: PlayerFactory.generatePlayer(video: video!),                    ),                    Expanded(                        child: Container(                      child: VideoDescriptionSection(video: video!),                      margin: EdgeInsets.symmetric(vertical: 12),                    )),                  ],                );              },            ),    );  }}class VideoPageContainer extends StatelessWidget {  @override  Widget build(BuildContext context) {    return VideoPage(      appVideo: ModalRoute.of(context)!.settings.arguments as AppVideo,    );  }}