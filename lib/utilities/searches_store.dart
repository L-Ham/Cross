import 'package:shared_preferences/shared_preferences.dart';

class SearchStore {
  static const String keySearch = 'recentSearches';
  static const int limit = 3;

  Future<void> addSearch(String search) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> searches = prefs.getStringList(keySearch) ?? [];

    if (searches.contains(search)) {
      int index = searches.indexOf(search);
      searches.insert(0, searches.removeAt(index));
      await prefs.setStringList(keySearch, searches);
      return;
    }

    if (searches.length >= limit) {
      searches.removeAt(0);
    }
    searches.insert(0, search);

    await prefs.setStringList(keySearch, searches);
  }

  Future<List<String>> getSearches() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> searches = prefs.getStringList(keySearch) ?? [];
    return searches;
  }

  Future<void> clearSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keySearch);
  }

  Future<void> deleteSearch(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> searches = prefs.getStringList(keySearch) ?? [];

    if (index < 0 || index >= searches.length) {
      throw RangeError('Index out of range: $index');
    }

    searches.removeAt(index);
    await prefs.setStringList(keySearch, searches);
  }
}
