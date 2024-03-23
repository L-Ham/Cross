
import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/screens/connected_accounts_disconnect_screen.dart';
import 'package:reddit_bel_ham/screens/update_email_address_screen.dart';
import 'package:reddit_bel_ham/screens/create_community_screen.dart';
import 'screens/account_settings_screen.dart';
import 'utilities/screen_size_handler.dart';
import 'screens/notifications_screen.dart';
import 'screens/first_screen.dart';
import 'package:reddit_bel_ham/screens/signup_screen.dart';
import 'utilities/screen_size_handler.dart';

void main() {
  runApp(const RedditBElham());
}

class RedditBElham extends StatelessWidget {
  const RedditBElham({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "create_community_screen": (context) => const CreateCommunityScreen(),
        "account_settings_screen": (context) => const AccountSettingsScreen(),
        "notification_settings_screen": (context) => NotificationSettingsScreen(),
        "first_screen": (context) => FirstScreen(),

      },
      initialRoute: "first_screen",
    );
  }
}