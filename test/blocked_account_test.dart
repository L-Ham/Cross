import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/screens/blocked_accounts.dart';

void main() {
  testWidgets('Blocked Accounts screen UI test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: BlockedAccount()));

    // Verify that the 'Block new account' text is displayed
    expect(find.text('Block new account'), findsOneWidget);

    // Verify that the text field is displayed
    expect(find.byKey(const Key('blocked_accounts_screen_text_field')),
        findsOneWidget);

    // Verify that the username 'TheKey119' is displayed
    expect(find.text('TheKey119'), findsOneWidget);

    // Verify that the clear button is not initially displayed
    expect(find.byKey(const Key('blocked_accounts_screen_clear_button')),
        findsNothing);

    // Enter text into the text field
    await tester.enterText(
        find.byKey(const Key('blocked_accounts_screen_text_field')), 'zzzz');
    await tester.pumpAndSettle();

    // Verify that the clear button is displayed after text entry
    expect(find.byKey(const Key('blocked_accounts_screen_clear_button')),
        findsOneWidget);

    // Tap the clear button
    await tester
        .tap(find.byKey(const Key('blocked_accounts_screen_clear_button')));
    await tester.pumpAndSettle();

    // Check if the text field is empty after tapping the clear button
    expect(find.text('zzzz'), findsNothing);
  });
}
