import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/screens/connected_accounts_disconnect_screen.dart';
import 'package:reddit_bel_ham/screens/create_community.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'screens/account_settings_screen.dart';

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
        "connected_accounts_disconnect_screen": (context) => const DisconnectScreen(),
      },
      initialRoute: "account_settings_screen",
    );
  }
}
