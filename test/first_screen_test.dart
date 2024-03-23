import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/screens/first_screen.dart';

void main() {
  testWidgets('FirstScreen Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: FirstScreen()));

    //Verify that logo image is displayed
    expect(find.byKey(const Key('first_screen_logo_image')), findsOneWidget);

    // Verify that the "Reddit byLham" text is displayed
    expect(find.text('Reddit byLham\n والهم مش راضي بينا'), findsOneWidget);




    // Verify that the "Continue with Google" button is displayed
    expect(find.text('Continue with Google'), findsOneWidget);

    // Verify that the "Continue with Email" button is displayed
    expect(find.text('Continue with Email'), findsOneWidget);

    // Verify that the "Already a redditor?" text is displayed
    expect(find.text('Already a redditor?'), findsOneWidget);

    // Verify that tapping on the "Continue with Email" button navigates to the SignupScreen
    await tester.tap(find.text('Continue with Email'));
    await tester.pumpAndSettle();

    // Verify that tapping on the "Log in" text navigates to the LoginScreen
    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();
  });
}
