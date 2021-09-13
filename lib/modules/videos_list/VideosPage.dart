import 'package:flutter/cupertino.dart';import 'package:flutter/material.dart';import 'package:zen_player/modules/search/SearchButton.dart';import 'package:zen_player/modules/videos_list/VideosArgument.dart';class VideosPage extends StatelessWidget {  final String? name;  VideosPage({this.name});  @override  Widget build(BuildContext context) {    return Scaffold(      appBar: AppBar(        title: Text(name ?? "No name"),        actions: [          SearchButton(            replaceRoute: true,          )        ],      ),    );  }}class _ViewModel {}class VideosPageContainer extends StatelessWidget {  @override  Widget build(BuildContext context) {    VideosArgument argument =        ModalRoute.of(context)!.settings.arguments as VideosArgument;    return VideosPage(      name: argument.name,    );  }}