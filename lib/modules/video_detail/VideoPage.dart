import 'package:flutter/cupertino.dart';import 'package:flutter/material.dart';import 'package:zen_player/modules/vendors/video.dart';import 'package:zen_player/modules/video_detail/players/player_factory.dart';class VideoPage extends StatefulWidget {  @override  State<StatefulWidget> createState() {    return _VideoPageState();  }}class _VideoPageState extends State<VideoPage> {  @override  Widget build(BuildContext context) {    final AppVideo? video =        ModalRoute.of(context)!.settings.arguments as AppVideo;    if (video == null) {      Navigator.pop(context);      return Container();    }    return Scaffold(      appBar: AppBar(        title: Text(          video.title,          style: Theme.of(context).textTheme.headline6!,        ),      ),      body: Container(        child: Row(          children: [PlayerFactory.generatePlayer(video)],        ),      ),    );  }}class VideoPageContainer extends StatelessWidget {  @override  Widget build(BuildContext context) {    return VideoPage();  }}