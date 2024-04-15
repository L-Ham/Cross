import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/components/add_post_components/image_deletion_bottom_sheet.dart';

void main() {
  testWidgets('ImageDeletionBottomSheet UI test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ImageDeletionBottomSheet(),
      ),
    ));

    // Verify that the "Delete current Image" button is displayed
    expect(find.text('Delete current Image'), findsOneWidget);

    // Verify that the "Delete all Images" button is displayed
    expect(find.text('Delete all Images'), findsOneWidget);

    // Verify that the "Cancel" button is displayed
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('ImageDeletionBottomSheet onTap test', (WidgetTester tester) async {
    String? result;

    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (BuildContext context) {
          return ElevatedButton(
            onPressed: () async {
              result = await showModalBottomSheet<String>(
                context: context,
                builder: (BuildContext context) {
                  return ImageDeletionBottomSheet();
                },
              );
            },
            child: const Text('Show Bottom Sheet'),
          );
        },
      ),
    ));

    // Tap the button to show the bottom sheet
    await tester.tap(find.text('Show Bottom Sheet'));
    await tester.pumpAndSettle();

    // Tap the "Delete current Image" button
    await tester.tap(find.text('Delete current Image'));
    await tester.pumpAndSettle();

    // Verify that the result is "current"
    expect(result, 'current');

    // Tap the "Delete all Images" button
    await tester.tap(find.text('Delete all Images'));
    await tester.pumpAndSettle();

    // Verify that the result is "all"
    expect(result, 'all');

    // Tap the "Cancel" button
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    // Verify that the result is null
    expect(result, null);
  });
}