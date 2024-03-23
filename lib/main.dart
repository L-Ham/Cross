import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/screens/change_password_screen.dart';
import 'package:reddit_bel_ham/screens/connected_accounts_disconnect_screen.dart';
import 'package:reddit_bel_ham/screens/update_email_address_screen.dart';
import 'package:reddit_bel_ham/screens/create_community_screen.dart';
import 'screens/account_settings_screen.dart';
import 'utilities/screen_size_handler.dart';
import 'screens/notifications_screen.dart';
import 'screens/first_screen.dart';


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
      },
      initialRoute: AccountSettingsScreen.id,
    );
  }
}