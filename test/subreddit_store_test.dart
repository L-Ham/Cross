import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reddit_bel_ham/utilities/subreddit_store.dart';

void main() {
  group('SubredditStore', () {
    late SubredditStore subredditStore;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      subredditStore = SubredditStore();
    });

    test('should add subreddit', () async {
      await subredditStore.addSubreddit('Flutter', 'flutter', 'flutter.png', 1000);

      final subreddits = await subredditStore.getSubreddits();
      expect(subreddits['names'], contains('Flutter'));
      expect(subreddits['ids'], contains('flutter'));
      expect(subreddits['images'], contains('flutter.png'));
      expect(subreddits['members'], contains('1000'));
    });

    test('should update existing subreddit', () async {
      await subredditStore.addSubreddit('Flutter', 'flutter', 'flutter.png', 1000);
      await subredditStore.addSubreddit('Dart', 'dart', 'dart.png', 500);

      final subreddits = await subredditStore.getSubreddits();
      expect(subreddits['names'], contains('Dart'));
      expect(subreddits['ids'], contains('dart'));
      expect(subreddits['images'], contains('dart.png'));
      expect(subreddits['members'], contains('500'));
    });

    test('should limit number of subreddits', () async {
      for (int i = 1; i < 15; i++) {
        await subredditStore.addSubreddit('Subreddit $i', 'subreddit_$i', 'image_$i.png', i * 100);
      }

      final subreddits = await subredditStore.getSubreddits();
      expect(subreddits['names']?.length, equals(10));
      expect(subreddits['ids']?.length, equals(10));
      expect(subreddits['images']?.length, equals(10));
      expect(subreddits['members']?.length, equals(10));
      expect(subreddits['names'], contains('Subreddit 14'));
      expect(subreddits['ids'], contains('subreddit_14'));
      expect(subreddits['images'], contains('image_14.png'));
      expect(subreddits['members'], contains('1400'));
      expect(subreddits['names'], isNot(contains('Subreddit 0')));
      expect(subreddits['ids'], isNot(contains('subreddit_0')));
      expect(subreddits['images'], isNot(contains('image_0.png')));
      expect(subreddits['members'], isNot(contains('0')));
    });

    test('should clear subreddits', () async {
      await subredditStore.addSubreddit('Flutter', 'flutter', 'flutter.png', 1000);
      await subredditStore.addSubreddit('Dart', 'dart', 'dart.png', 500);

      await subredditStore.clearSubreddits();

      final subreddits = await subredditStore.getSubreddits();
      expect(subreddits['names'], isEmpty);
      expect(subreddits['ids'], isEmpty);
      expect(subreddits['images'], isEmpty);
      expect(subreddits['members'], isEmpty);
    });
  });
}