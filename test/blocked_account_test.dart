import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/screens/blocked_accounts.dart';

void main() {
  testWidgets('Blocked Accounts screen UI test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: BlockedAccount()));

    expect(find.text('Block new account'), findsOneWidget);

    expect(find.byKey(const Key('blocked_accounts_screen_text_field')),
        findsOneWidget);

    expect(find.text('TheKey119'), findsOneWidget);

    expect(find.text('Block'), findsOneWidget);

    expect(
        find.byKey(
            const Key('blocked_accounts_screen_text_field_clear_button')),
        findsNothing);

    expect(find.text('Cancel'), findsNothing);

    await tester.enterText(
        find.byKey(const Key('blocked_accounts_screen_text_field')), 'x');
    await tester.pumpAndSettle();

    expect(
        find.byKey(
            const Key('blocked_accounts_screen_text_field_clear_button')),
        findsOneWidget);

    expect(find.text('Cancel'), findsOneWidget);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(
        FocusManager.instance.primaryFocus,
        isNot(equals(
            find.byKey(const Key('blocked_accounts_screen_text_field')))));

    expect(find.text('Cancel'), findsNothing);
  });
}
