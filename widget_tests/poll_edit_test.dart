import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/components/add_post_components/poll_edit.dart';
import 'package:reddit_bel_ham/constants.dart';

void main() {
  testWidgets('PollEdit widget test', (WidgetTester tester) async {
    // Build the PollEdit widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PollEdit(
            removePoll: () {},
            updateNumOfDays: (String days) {},
            updatePollOptions: (int numOfOptions, List<TextEditingController> controllers) {},
          ),
        ),
      ),
    );

    // Verify that the PollEdit widget is rendered
    expect(find.byType(PollEdit), findsOneWidget);

    // Verify that the 'Poll ends in' text is displayed
    expect(find.text('Poll ends in  '), findsOneWidget);

    // Verify that the 'Poll ends in' text has the correct style
    final pollEndsInText = tester.widget<Text>(
      find.descendant(
        of: find.byType(PollEdit),
        matching: find.text('Poll ends in  '),
      ),
    );
    expect(pollEndsInText.style?.color, kGreenGrayColor);
    expect(pollEndsInText.style?.fontWeight, FontWeight.w500);

    // Verify that the 'Poll ends in' text is tappable
    await tester.tap(find.text('Poll ends in  '));
    await tester.pumpAndSettle();

    // Verify that the PollDaysBottomSheet is displayed
    //expect(find.byType(PollDaysBottomSheet), findsOneWidget);

  });
}