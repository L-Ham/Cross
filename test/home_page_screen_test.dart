import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/screens/home_page_screen.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';

void main() {
  testWidgets('HomePage widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: HomePageScreen()));

     // Scroll to the end of the list
    

    // Verify the AppBar is on screen.
    expect(find.byType(AppBar), findsOneWidget);

    // Verify the AppBar contains the correct elements.
    expect(find.byIcon(Icons.menu), findsOneWidget);
    expect(find.text('Home'), findsOneWidget); 
    expect(find.byIcon(Icons.arrow_drop_down), findsOneWidget);

    // Verify the ListView.builder is present and correctly displays PostCard widgets.
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(PostCard), findsNWidgets(2)); // Change 2 to the expected number of posts

    final Finder firstPostCard = find.byType(PostCard).first;

    // Add scenario for voting buttons
    // Find the upvote button of the first PostCard
    Finder upvoteButton = find.descendant(of: firstPostCard, matching: find.byIcon(Icons.arrow_upward)).first;

    // Find the downvote button of the first PostCard
    Finder downvoteButton = find.descendant(of: firstPostCard, matching: find.byIcon(Icons.arrow_downward)).first;

    // Find the text widget that displays the vote count
    Finder voteCountText = find.descendant(
      of: firstPostCard,
      matching: find.byWidgetPredicate(
        (Widget widget) =>
            widget is Text &&
            int.tryParse(widget.data ?? '') != null, // Ensure the Text widget contains a number
      ),
    ).first;

    String? initialVoteCount = tester.widget<Text>(voteCountText).data ?? '0';

    // Tap the upvote button
    await tester.tap(upvoteButton);
    await tester.pump();

    // Find the text widget that displays the vote count again
    String? newVoteCount = tester.widget<Text>(voteCountText).data ?? '0';

    // Check that the new vote count is one more than the initial vote count
    expect(int.parse(newVoteCount), equals(int.parse(initialVoteCount) + 1));

    // Tap the downvote button
    await tester.tap(downvoteButton);
    await tester.pump();

    // Find the text widget that displays the vote count again
    String? newVoteCountAfterDownvote = tester.widget<Text>(voteCountText).data ?? '0';

    // Check that the new vote count is one less than the vote count after upvoting
    expect(int.parse(newVoteCountAfterDownvote), equals(int.parse(initialVoteCount) - 1));
  });
}