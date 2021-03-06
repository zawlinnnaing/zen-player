class AppUtility {
  static bool isUrl(String string) {
    RegExp urlRegex = RegExp(
        r"[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)",
        caseSensitive: false,
        multiLine: false);
    return urlRegex.hasMatch(string);
  }

  static String printDuration(Duration duration) {
    String hourText = "";
    if (duration.inHours > 0) {
      hourText += "${duration.inHours.toString()}:";
    }
    return "$hourText${duration.inMinutes.remainder(60).toString().padLeft(2, "0")}:${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}";
  }
}
