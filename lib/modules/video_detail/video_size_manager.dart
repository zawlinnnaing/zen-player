import 'package:flutter/cupertino.dart';

class VideoSizeManager {
  static double playerHeight(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape
        ? MediaQuery.of(context).size.height * 1
        : MediaQuery.of(context).size.height * 0.3;
  }

  static double descriptionHeight(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape
        ? 0
        : MediaQuery.of(context).size.height * 0.7;
  }
}
