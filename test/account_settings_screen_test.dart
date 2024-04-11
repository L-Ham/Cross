import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/screens/account_settings_screen.dart';
import 'package:reddit_bel_ham/screens/update_email_address_screen.dart';

void main() {
  testWidgets('Find widgets by key in AccountSettingsScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: AccountSettingsScreen(),
    ));

    expect(find.byKey(const Key('account_settings_update_email_address_tile')), findsOneWidget);
    expect(find.byKey(const Key('account_settings_change_password_tile')), findsOneWidget);
    expect(find.byKey(const Key('account_settings_change_gender_tile')), findsOneWidget);
    expect(find.byKey(const Key('account_settings_location_customization_tile')), findsOneWidget);
    expect(find.byKey(const Key('account_settings_manage_notifications_tile')), findsOneWidget);
    expect(find.byKey(const Key('account_settings_manage_blocked_accounts_tile')), findsOneWidget);
  });

  testWidgets('Tap update_email_address_tile redirects to UpdateEmailAddressScreen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AccountSettingsScreen(),
      routes: {
        UpdateEmailAddressScreen.id: (context) => UpdateEmailAddressScreen(),
      },
    ));

    await tester.tap(find.byKey(Key('account_settings_update_email_address_tile')));
    await tester.pumpAndSettle();

    expect(find.byType(UpdateEmailAddressScreen), findsOneWidget);
  });
}

