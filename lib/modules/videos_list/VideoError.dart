import 'package:flutter/material.dart';
import 'package:zen_player/utils/config.dart';

class VideoError extends StatelessWidget {
  final String errorMsg;
  VideoError({this.errorMsg = "Something went wrong."});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              size: 48,
              color: warningColor,
            ),
            SizedBox(
              height: 8,
            ),
            Text(errorMsg)
          ],
        ),
      ),
    );
  }
}
