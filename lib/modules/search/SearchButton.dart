import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zen_player/utils/routes.dart';

class SearchButton extends StatelessWidget {
  final bool replaceRoute;
  SearchButton({this.replaceRoute = false});
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.search),
        color: Theme.of(context).iconTheme.color,
        onPressed: () {
          if (replaceRoute) {
            Navigator.pushReplacementNamed(context, Routes.search);
          } else {
            Navigator.pushNamed(context, Routes.search);
          }
        });
  }
}
