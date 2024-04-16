import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/components/add_post_components/poll_days_bottom_sheet.dart';

void main() {
  testWidgets('Poll days bottom sheet UI test', (WidgetTester tester) async {
    // Create a ValueNotifier to track the selected value
    final groupValueNotifier = ValueNotifier<String?>('');

    // Build the widget under test
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return PollDaysBottomSheet(
                        groupValueNotifier: groupValueNotifier,
                      );
                    },
                  );
                },
                child: const Text('Open Bottom Sheet'),
              );
            },
          ),
        ),
      ),
    );

    // Tap the button to open the bottom sheet
    await tester.tap(find.text('Open Bottom Sheet'));
    await tester.pumpAndSettle();

    // Verify that the bottom sheet is displayed
    expect(find.byType(PollDaysBottomSheet), findsOneWidget);

    // Verify that the radio buttons are displayed
    for (int i = 7; i > 0; i--) {
      expect(find.text('$i days'), findsOneWidget);
    }

    // Tap on a radio button
    await tester.tap(find.text('7 days'));
    await tester.pumpAndSettle();

    // Tap the 'Close' button
    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();

  });
}