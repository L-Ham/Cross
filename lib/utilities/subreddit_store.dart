import 'package:shared_preferences/shared_preferences.dart';

class SubredditStore {
  static const String keyName = 'subredditNames';
  static const String keyId = 'subredditIds';
  static const String keyImage = 'subredditImages';
  static const String keyMembers = 'subredditMembers';
  static const int limit = 10;

  Future<void> addSubreddit(
      String name, String id, String image, int numberOfMembers) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> names = prefs.getStringList(keyName) ?? [];
    List<String> ids = prefs.getStringList(keyId) ?? [];
    List<String> images = prefs.getStringList(keyImage) ?? [];
    List<String> members = prefs.getStringList(keyMembers) ?? [];

    if (names.contains(name)) {
      int index = names.indexOf(name);
      ids.insert(0, ids.removeAt(index));
      images.insert(0, images.removeAt(index));
      members.insert(0, members.removeAt(index));
      names.insert(0, names.removeAt(index));
      await prefs.setStringList(keyName, names);
      await prefs.setStringList(keyId, ids);
      await prefs.setStringList(keyImage, images);
      await prefs.setStringList(keyMembers, members);
      return;
    }

    if (names.length >= limit) {
      names.removeAt(0); // Remove the oldest one
      ids.removeAt(0);
      images.removeAt(0);
      members.removeAt(0);
    }
    names.insert(0, name); // Add the new one at the beginning
    ids.insert(0, id);
    images.insert(0, image);
    members.insert(0, numberOfMembers.toString());

    await prefs.setStringList(keyName, names);
    await prefs.setStringList(keyId, ids);
    await prefs.setStringList(keyImage, images);
    await prefs.setStringList(keyMembers, members);
  }

  Future<Map<String, List<String>>> getSubreddits() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> names = prefs.getStringList(keyName) ?? [];
    List<String> ids = prefs.getStringList(keyId) ?? [];
    List<String> images = prefs.getStringList(keyImage) ?? [];
    List<String> members = prefs.getStringList(keyMembers) ?? [];

    return {
      'names': names,
      'ids': ids,
      'images': images,
      'members': members,
    };
  }

  Future<void> clearSubreddits() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyName);
    await prefs.remove(keyId);
    await prefs.remove(keyImage);
    await prefs.remove(keyMembers);
  }
}
