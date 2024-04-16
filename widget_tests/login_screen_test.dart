import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/components/general_components/continue_button.dart';
import 'package:reddit_bel_ham/screens/login_screen.dart';

void main() {
  testWidgets('Login screen UI test', (WidgetTester tester) async {
    
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    // Verify that the 'Log in' text is displayed
    expect(find.text('Log in'), findsOneWidget);

    // Verify that the 'Continue with Google' button is displayed
    expect(find.text('Continue with Google'), findsOneWidget);

    // Tap on the 'Continue with Google' button
    await tester.tap(find.text('Continue with Google'));
    await tester.pump();

    // Verify that the 'Email or username' text field is displayed
    expect(find.byKey(const Key('login_screen_email_or_username_text_field')), findsOneWidget);

    // Enter text in the 'Email or username' text field
    await tester.enterText(find.byKey(const Key('login_screen_email_or_username_text_field')), 'test@example.com');
    await tester.pump();

    // Verify that the entered text is displayed in the text field
    expect(find.text('test@example.com'), findsOneWidget);
    final continueButton = find.byKey(const Key('login_screen_continue_button'));
    // Verify that the 'Continue' button is disabled
    expect(tester.widget<ContinueButton>( continueButton).isButtonEnabled,false);

    // Verify that the 'Password' text field is displayed
    expect(find.byKey(const Key('login_screen_password_text_field')), findsOneWidget);

    // Enter text in the 'Password' text field
    await tester.enterText(find.byKey(const Key('login_screen_password_text_field')), 'password');
    await tester.pump();

    // Verify that the entered text is displayed in the text field
    expect(find.text('password'), findsOneWidget);
    // Verify that the 'Continue' button is now enabled
    expect(tester.widget<ContinueButton>( continueButton).isButtonEnabled,true);

    // Tap on the 'Continue' button
    await tester.tap(find.byKey(const Key('login_screen_continue_button')));
    await tester.pump();

    // Tap on the 'Forgot your password?' text
    await tester.tap(find.byKey(const Key('login_screen_forgot_password_text_link')));
    await tester.pump();



  });
}
