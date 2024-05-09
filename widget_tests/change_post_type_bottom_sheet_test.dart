import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/components/add_post_components/red_button_bottom_sheet.dart';

void main() {
  testWidgets('ChangePostTypeBottomSheet UI test', (WidgetTester tester) async {
    // Build the widget
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
                      return RedButtonBottomSheet();
                    },
                  );
                },
                child: const Text('Show Bottom Sheet'),
              );
            },
          ),
        ),
      ),
    );

    // Tap the button to show the bottom sheet
    await tester.tap(find.text('Show Bottom Sheet'));
    await tester.pumpAndSettle();

    // Verify that the title text is displayed
    expect(find.text('Change Post Type'), findsOneWidget);

    // Verify that the body text is displayed
    expect(find.text('Some of your post will be deleted if you continue.'),
        findsOneWidget);

    // Verify that the left button text is displayed
    expect(find.text('Cancel'), findsOneWidget);

    // Verify that the right button text is displayed
    expect(find.text('Continue'), findsOneWidget);

    // Tap the left button
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    // Tap the right button
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

  });
}
