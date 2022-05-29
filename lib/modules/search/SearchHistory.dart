import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeywordItem extends StatelessWidget {
  final String keyword;
  final Function(String k) onTap;
  final Function(String k) onRemove;
  KeywordItem(
      {required this.keyword, required this.onTap, required this.onRemove});
  void _onRemove() {
    this.onRemove(keyword);
  }

  void _onTap() {
    onTap(keyword);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SizedBox(
            width: 12,
          ),
          Expanded(
              child: GestureDetector(
            onTap: _onTap,
            child: Text(keyword),
          )),
          IconButton(onPressed: _onRemove, icon: Icon(Icons.close))
        ],
      ),
    );
  }
}

class SearchHistory extends StatelessWidget {
  final Set<String> keywords;
  final Function(String keyword) onTap;
  final Function(String keyword) onRemove;
  static _dummyFn(String keyowrd) {}
  SearchHistory(
      {required this.keywords, required this.onTap, this.onRemove = _dummyFn});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, int index) {
          final String keyword = keywords.elementAt(index);
          return KeywordItem(
              keyword: keyword, onTap: onTap, onRemove: onRemove);
        },
        itemCount: keywords.length,
      ),
    );
  }
}
