import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zen_player/modules/search/search_manager.dart';

void main() {
  group("Search manager", () {
    late SearchStorageManager searchManager;
    final List<String> mockHistory = ["hello", "world"];
    setUp(() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (pref.containsKey(SearchStorageManager.SEARCH_KEY)) {
        pref.remove(SearchStorageManager.SEARCH_KEY);
      }
      searchManager = await SearchStorageManager.create();
    });
    test("SearchManager - history default empty", () async {
      expect(await searchManager.history, []);
    });
    test("SearchManager - store history", () async {
      await searchManager.storeHistory(mockHistory);
      expect(await searchManager.history, mockHistory);
    });
    test("SearchManager - clear history", () async {
      await searchManager.storeHistory(mockHistory);
      await searchManager.clearHistory();
      expect(await searchManager.history, []);
    });
    test("SearchManager - clear history works correctly when no key", () async {
      await searchManager.clearHistory();
      expect(await searchManager.history, []);
    });
  });
}
