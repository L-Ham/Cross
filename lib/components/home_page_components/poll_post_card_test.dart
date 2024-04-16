import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/components/home_page_components/poll_post_card.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';

void main() {
  testWidgets('PollPost widget test', (WidgetTester tester) async {
    // Create a mock Post object
    final post = Post(
        comments: 0,
        username: '',
        content: '',
        contentTitle: '',
        upvotes: 0,
        image: [],
        link: '',
        type: 'poll',
        video: '');

    // Build the PollPost widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PollPost(post: post),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify that the options are displayed
    expect(find.text('Option 1'), findsOneWidget);
    expect(find.text('Option 2'), findsOneWidget);
    expect(find.text('Option 3'), findsOneWidget);

    // Tap on an option
    await tester.tap(find.byWidgetPredicate(
      (widget) => widget is Radio && widget.value == 'Option 1',
    ));
    await tester.pump();

    // Tap on the Vote button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Vote'));
    await tester.pump();

    // Verify that the selected option is displayed
    expect(find.byIcon(Icons.check_circle), findsOneWidget);

    // Verify that the vote count is updated
    expect(find.text('16'), findsOneWidget);

  });
}
