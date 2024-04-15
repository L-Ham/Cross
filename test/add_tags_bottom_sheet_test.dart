import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/components/add_post_components/add_tags_bottom_sheet.dart';

void main() {
  testWidgets('AddTagsBottomSheet UI test', (WidgetTester tester) async {
    // Build the AddTagsBottomSheet widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AddTagsBottomSheet(
            isSpoiler: false,
            isBrandAffiliate: false,
            setIsSpoiler: (bool value) {},
            setIsBrandAffiliate: (bool value) {},
          ),
        ),
      ),
    );

    // Verify that the 'Add tags' text is displayed
    expect(find.text('Add tags'), findsOneWidget);

    // Verify that the 'Clear' button is displayed
    expect(find.byIcon(Icons.clear), findsOneWidget);

    // Verify that the 'Universal tags' text is displayed
    expect(find.text('Universal tags'), findsOneWidget);

    // Verify that the 'Spoiler' tile is displayed
    expect(find.text('Spoiler'), findsOneWidget);
    expect(find.text('Tag posts that may ruin a surprise'), findsOneWidget);

    // Verify that the 'Brand affiliate' tile is displayed
    expect(find.text('Brand affiliate'), findsOneWidget);
    expect(find.text('Made for a brand or business'), findsOneWidget);
  });

  testWidgets('AddTagsBottomSheet state test', (WidgetTester tester) async {
    // Define variables to hold the state values
    bool isSpoiler = false;
    bool isBrandAffiliate = false;

    // Build the AddTagsBottomSheet widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AddTagsBottomSheet(
            isSpoiler: isSpoiler,
            isBrandAffiliate: isBrandAffiliate,
            setIsSpoiler: (bool value) {
              isSpoiler = value;
            },
            setIsBrandAffiliate: (bool value) {
              isBrandAffiliate = value;
            },
          ),
        ),
      ),
    );

    // Verify the initial state values
    expect(isSpoiler, false);
    expect(isBrandAffiliate, false);

    // Tap on the 'Spoiler' switch
    await tester.tap(find.byKey(const Key('spoiler_switch')));
    await tester.pump();

    // Verify that the state value has changed
    expect(isSpoiler, true);

    // Tap on the 'Brand affiliate' switch
    await tester.tap(find.byKey(const Key('brand_affiliate_switch')));
    await tester.pump();

    // Verify that the state value has changed
    expect(isBrandAffiliate, true);
  });
}