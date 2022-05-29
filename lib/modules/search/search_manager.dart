import 'package:shared_preferences/shared_preferences.dart';

class SearchStorageManager {
  static const String SEARCH_KEY = "app_search_history";
  late SharedPreferences _pref;
  SearchStorageManager._create(SharedPreferences pref) {
    this._pref = pref;
  }
  static Future<SearchStorageManager> create() async {
    return SearchStorageManager._create(await SharedPreferences.getInstance());
  }

  Future<List<String>> get history async {
    if (this._pref.containsKey(SEARCH_KEY)) {
      return this._pref.getStringList(SEARCH_KEY) ?? [];
    }
    return [];
  }

  Future<void> storeHistory(List<String> history) async {
    this._pref.setStringList(SEARCH_KEY, history);
  }

  Future<void> clearHistory() async {
    if (_pref.containsKey(SEARCH_KEY)) {
      this._pref.remove(SEARCH_KEY);
    }
  }
}
