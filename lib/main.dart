// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'screens/first_screen.dart';
import 'utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/screens/create_community_screen.dart';
import 'screens/account_settings_screen.dart';
import 'screens/notifications_screen.dart';

void main() {
  runApp(const RedditBElham());
}

class RedditBElham extends StatelessWidget {
  const RedditBElham({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ScreenSizeHandler.initialize(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "create_community_screen": (context) => const CreateCommunityScreen(),
        "account_settings_screen": (context) => const AccountSettingsScreen(),
        "notification_settings_screen": (context) => NotificationSettingsScreen(),
        
      },
      initialRoute: "account_settings_screen",
    );
  }
}


