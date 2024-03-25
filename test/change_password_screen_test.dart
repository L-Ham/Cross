import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/components/general_components/gradient_button.dart';
import 'package:reddit_bel_ham/screens/change_password_screen.dart';

void main() {
  testWidgets('Change password screen UI test', (WidgetTester tester) async {
    
    await tester.pumpWidget(const MaterialApp(home: ChangePasswordScreen()));

    // Verify that the 'Reset Password' text is displayed
    expect(find.text('Reset Password'), findsOneWidget);

    // Verify that the 'user info' card is displayed
    expect(find.byKey(const Key('change_password_screen_user_info_card')), findsOneWidget);

    // Verify that the 'Current Password' text field is displayed
    expect(find.byKey(const Key('change_password_screen_current_password_text_field')), findsOneWidget);

    // Verify that the 'Forgot Password' text link is displayed
    expect(find.byKey(const Key('change_password_screen_forgot_password_text_link')), findsOneWidget);

    // Enter old password in the 'Current Password' text field
    await tester.enterText(find.byKey(const Key('change_password_screen_current_password_text_field')), 'old_password');
    await tester.pump();

    final saveButton = find.byKey(const Key('change_password_screen_save_button'));
    // Verify that the 'save' button is disabled
    expect(tester.widget<GradientButton>(saveButton).isPassFocused,false);

    // Verify that the 'New Password' text field is displayed
    expect(find.byKey(const Key('change_password_screen_new_password_text_field')), findsOneWidget);

    // Enter new password in the 'New Password' text field
    await tester.enterText(find.byKey(const Key('change_password_screen_new_password_text_field')), 'new_password');
    await tester.pump();

    // Verify that the 'save' button is still disabled
    expect(tester.widget<GradientButton>(saveButton).isPassFocused,false);

    // Verify that the 'Confirm Password' text field is displayed
    expect(find.byKey(const Key('change_password_screen_confirm_password_text_field')), findsOneWidget);

    // Enter wrong new password in the 'Confirm Password' text field
    await tester.enterText(find.byKey(const Key('change_password_screen_confirm_password_text_field')), 'password_new');
    await tester.pump();

    // Verify that the 'save' button is still disabled
    expect(tester.widget<GradientButton>(saveButton).isPassFocused,false);

    // Enter correct new password in the 'Confirm Password' text field
    await tester.enterText(find.byKey(const Key('change_password_screen_confirm_password_text_field')), 'new_password');
    await tester.pump();

    // Verify that the 'save' button is now enabled
    expect(tester.widget<GradientButton>(saveButton).isPassFocused,true);

  });
}
