import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/screens/change_password_screen.dart';
import 'package:reddit_bel_ham/screens/connected_accounts_disconnect_screen.dart';
import 'package:reddit_bel_ham/screens/update_email_address_screen.dart';
import 'package:reddit_bel_ham/screens/create_community_screen.dart';
import 'screens/account_settings_screen.dart';
import 'utilities/screen_size_handler.dart';
import 'screens/notifications_screen.dart';
import 'screens/first_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/home_page_screen.dart';
void main() {
  runApp(const RedditByLham());
}

class RedditByLham extends StatelessWidget {
  const RedditByLham({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
      ScreenSizeHandler.initialize(
      MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
      
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      routes: {
        FirstScreen.id: (context) => FirstScreen(),
        CreateCommunityScreen.id: (context) => const CreateCommunityScreen(),
        AccountSettingsScreen.id: (context) => const AccountSettingsScreen(),
        NotificationSettingsScreen.id: (context) => const NotificationSettingsScreen(),
        DisconnectScreen.id: (context) => const DisconnectScreen(),
        UpdateEmailAddressScreen.id: (context) => const UpdateEmailAddressScreen(),
        ChangePasswordScreen.id: (context) => const ChangePasswordScreen(),
        SignupScreen.id: (context) => const SignupScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        ForgotPasswordScreen.id: (context) => const ForgotPasswordScreen(),
        HomePageScreen.id: (context) => HomePageScreen(),
        //Resolved
        // SearchScreen.id: (context) => SearchScreen(),
      },
      initialRoute: FirstScreen.id,
    );
  }
}