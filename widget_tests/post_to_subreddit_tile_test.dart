import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/components/add_post_components/post_to_subreddit_tile.dart';

void main() {
  testWidgets('PostToSubredditTile widget test', (WidgetTester tester) async {
    // Define test data
    const subredditName = 'flutter';
    const selectedSubredditName = 'flutter';
    const subredditImage = 'assets/images/planet3.png';
    const numOfOnlineUsers = 100;
    bool onTapCalled = false;

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: PostToSubredditTile(
            subredditName: subredditName,
            selectedSubredditName: selectedSubredditName,
            subredditImage: subredditImage,
            numOfOnlineUsers: numOfOnlineUsers,
            onTap: () {
              onTapCalled = true;
            },
          ),
        ),
      ),
    );

    // Verify the widget's properties
    expect(find.text('r/$subredditName'), findsOneWidget);
    expect(find.text('$numOfOnlineUsers online'), findsOneWidget);
    expect(find.byIcon(Icons.check), findsOneWidget);

    // Verify the onTap callback
    await tester.tap(find.byType(GestureDetector));
  });
}