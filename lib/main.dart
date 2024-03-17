import 'package:flutter/material.dart';
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
        "first_screen": (context) => FirstScreen(),
        "create_community_screen": (context) => const CreateCommunityScreen(),
        "account_settings_screen": (context) => const AccountSettingsScreen(),
        "notification_settings_screen": (context) => const NotificationSettingsScreen(),

      },
      initialRoute: "notification_settings_screen",
    );
  }
}