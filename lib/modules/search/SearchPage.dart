import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:zen_player/layout/Default.dart';
import 'package:zen_player/modules/search/SearchHistory.dart';
import 'package:zen_player/modules/videos_list/video_argument.dart';
import 'package:zen_player/redux/actions/app.dart';
import 'package:zen_player/redux/states/app.dart';
import 'package:zen_player/utils/routes.dart';

class SearchPage extends StatefulWidget {
  final Function(String keyword) appendSearchHistory;
  final Set<String> searchHistory;
  final Function(String keyword) removeKeyword;

  SearchPage(
      {required this.appendSearchHistory,
      required this.searchHistory,
      required this.removeKeyword});

  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  String searchStr = "";

  void _onStrChanged(String str) {
    setState(() {
      searchStr = str;
    });
  }

  void _onTap(String str, BuildContext context) {
    widget.appendSearchHistory(str);
    Navigator.of(context)
        .pushReplacementNamed(Routes.videos, arguments: VideosArgument(str));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextField(
            cursorColor: Theme.of(context).colorScheme.secondary,
            onChanged: _onStrChanged,
            onSubmitted: (String str) {
              _onTap(str, context);
            },
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
            autofocus: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8),
              filled: true,
              isDense: true,
              focusColor: Theme.of(context).colorScheme.secondary,
              constraints: BoxConstraints(maxHeight: 36),
              hintText: "Search by video names or urls",
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: SearchHistory(
            onTap: (keyword) {
              _onTap(keyword, context);
            },
            keywords: widget.searchHistory,
            onRemove: widget.removeKeyword,
          ),
        ));
  }
}

class _ContainerVm {
  Function(String keyword) appendList;
  final Set<String> searchHistory;
  final Function(String keyword) removeKeyword;

  _ContainerVm(
      {required this.appendList,
      required this.searchHistory,
      required this.removeKeyword});

  factory _ContainerVm.fromStore(Store<AppState> store) {
    return _ContainerVm(
        appendList: (String keyword) {
          store.dispatch(AppendSearchListAction(keyword));
        },
        removeKeyword: (String keyword) {
          store.dispatch(RemoveSearchListAction(keyword));
        },
        searchHistory: store.state.searchHistory);
  }
}

class SearchPageContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
        builder: (context, _ContainerVm vm) {
          return SearchPage(
            appendSearchHistory: vm.appendList,
            searchHistory: vm.searchHistory,
            removeKeyword: vm.removeKeyword,
          );
        },
        converter: (Store<AppState> store) => _ContainerVm.fromStore(store));
  }
}
