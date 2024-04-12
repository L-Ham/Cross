import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/components/general_components/continue_button.dart';
import 'package:reddit_bel_ham/screens/forgot_password_screen.dart';

void main() {
  testWidgets('Forget password screen UI test', (WidgetTester tester) async {
    
    await tester.pumpWidget(const MaterialApp(home: ForgotPasswordScreen(username: '',)));

    // Verify that the 'Forgot Password?' text is displayed
    expect(find.text('Forgot Password?'), findsOneWidget);

    // Verify that the 'Email or username' text field is displayed
    expect(find.byKey(const Key('forgot_password_screen_email_or_username_text_field')), findsOneWidget);

    final resetPasswordButton = find.byKey(const Key('forgot_password_screen_reset_Password_button'));
    // Verify that the 'Reset Password' button is disabled
    expect(tester.widget<ContinueButton>(resetPasswordButton).isButtonEnabled,false);

    // Enter invalid text in the 'Email or username' text field
    await tester.enterText(find.byKey(const Key('forgot_password_screen_email_or_username_text_field')), 'nn');
    await tester.pump();

    // Verify that the entered text is displayed in the text field
    expect(find.text('nn'), findsOneWidget);

    // Verify that the 'Reset Password' button is still disabled
    expect(tester.widget<ContinueButton>(resetPasswordButton).isButtonEnabled,false);

    // Enter valid text in the 'Email or username' text field
    await tester.enterText(find.byKey(const Key('forgot_password_screen_email_or_username_text_field')), 'test@example.com');
    await tester.pump();

    // Verify that the entered text is displayed in the text field
    expect(find.text('test@example.com'), findsOneWidget);

    // Verify that the 'Reset password' button is now enabled
    expect(tester.widget<ContinueButton>(resetPasswordButton).isButtonEnabled,true);

    // Tap on the 'Reset password' button
    await tester.tap(resetPasswordButton);
    await tester.pump();

  });
}
