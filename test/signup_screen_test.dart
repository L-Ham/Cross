import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/screens/signup_screen.dart';
import 'package:reddit_bel_ham/components/continue_button.dart';

void main() {
  testWidgets('Login screen UI test', (WidgetTester tester) async {
    
    await tester.pumpWidget(const MaterialApp(home: SignupScreen()));

    final continueButton = find.byKey(const Key('signup_screen_continue_button'));

    // Verify that the 'Hi new friend' text is displayed
    expect(find.textContaining('Hi new friend'), findsOneWidget);

    // Verify that the Log in text link is displayed
    expect(find.byKey(const Key('signup_screen_logo_text_app_bar_login_button')), findsOneWidget);


    // Verify that the 'Email or username' text field is displayed
    expect(find.byKey(const Key('signup_screen_email_text_field')), findsOneWidget);

    // Enter text in the 'Email or username' text field
 await tester.enterText(find.byKey(const Key('signup_screen_email_text_field')), 'test@exampl');
    await tester.pump();   

    // Verify that the error email message is displayed
    expect(find.byKey(const Key('signup_screen_email_error_text')), findsOneWidget);
    // Verify that the 'Continue' button is disabled
    expect(tester.widget<ContinueButton>(continueButton).isButtonEnabled,false);


    // Enter invalid text in the 'Password' text field
    await tester.enterText(find.byKey(const Key('signup_screen_password_text_field')), 'pass');
    await tester.pump();

    // Verify that the error password message is displayed
    expect(find.byKey(const Key('signup_screen_password_error_text')), findsOneWidget);



  });
}
