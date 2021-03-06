import 'package:flutter_test/flutter_test.dart';
import 'package:zen_player/utils/util.dart';

void main() {
  group("AppUtility.isUrl", () {
    test("Full URL with protocol", () {
      expect(AppUtility.isUrl("http://www.zenplayer.com"), true);
    });
    test("Full URL without protocol", () {
      expect(AppUtility.isUrl("www.zenplayer.com"), true);
    });
    test("URL without subdomain", () {
      expect(AppUtility.isUrl("zenplayer.com"), true);
    });
    test("URL with path", () {
      expect(AppUtility.isUrl("zenplayer.com/videos/player"), true);
    });
    test("Not a url", () {
      expect(AppUtility.isUrl("zen palyer"), false);
    });
  });
  group("AppUtility.printDuration", () {
    test("HH:mm:ss", () {
      Duration duration = Duration(hours: 1, minutes: 20, seconds: 59);
      expect(AppUtility.printDuration(duration), "1:20:59");
    });
    test("mm:ss", () {
      Duration duration = Duration(minutes: 30, seconds: 59);
      expect(AppUtility.printDuration(duration), "30:59");
    });
    test("mm:ss with 0 min", () {
      Duration duration = Duration(seconds: 59);
      expect(AppUtility.printDuration(duration), "00:59");
    });
  });
}
