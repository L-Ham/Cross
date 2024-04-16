import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/components/add_post_components/community_rule_tile.dart';

void main() {
  testWidgets('CommunityRuleTile widget test', (WidgetTester tester) async {
    // Build the CommunityRuleTile widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: CommunityRuleTile(
              ruleNum: 1,
              ruleTitle: 'Test Rule',
              ruleDescription: 'This is a test rule.',
            ),
          ),
        ),
      ),
    );

    // Verify that the rule number and title are displayed correctly
    expect(find.text('1. Test Rule'), findsOneWidget);

    // Verify that the rule description is initially hidden
    expect(find.text('This is a test rule.'), findsNothing);

    // Tap on the tile to expand it
    await tester.tap(find.text('1. Test Rule'));

    // Verify that the rule description is hidden again
    expect(find.text('This is a test rule.'), findsNothing);
  });
}