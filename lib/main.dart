import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/screens/add_post_screen.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:reddit_bel_ham/screens/about_you_screen.dart';
import 'package:reddit_bel_ham/screens/change_password_screen.dart';
import 'package:reddit_bel_ham/screens/community_rules_screen.dart';
import 'package:reddit_bel_ham/screens/connected_accounts_disconnect_screen.dart';
import 'package:reddit_bel_ham/screens/post_to_screen.dart';
import 'package:reddit_bel_ham/screens/settings_screen.dart';
import 'package:reddit_bel_ham/screens/create_username_screen.dart';
import 'package:reddit_bel_ham/screens/update_email_address_screen.dart';
import 'package:reddit_bel_ham/screens/create_community_screen.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import 'screens/account_settings_screen.dart';
import 'utilities/screen_size_handler.dart';
import 'screens/notifications_settings_screen.dart';
import 'screens/first_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/home_page_screen.dart';
import 'screens/blocked_accounts.dart';

import 'screens/subreddit_screen.dart';
import 'screens/subreddit_search_screen.dart';




import 'package:shared_preferences/shared_preferences.dart';
import 'package:reddit_bel_ham/screens/inbox_messages.dart';

import 'services/google_sign_in.dart';
import 'screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  if (token != null) {
    TokenDecoder.updateToken(token);
  }
  runApp(RedditByLham(token: token));
}

class RedditByLham extends StatelessWidget {
  final String? token;
  const RedditByLham({@required this.token, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenSizeHandler.initialize(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    return MaterialApp(
      title: 'HTTP',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      routes: {
        FirstScreen.id: (context) => const FirstScreen(),
        CreateCommunityScreen.id: (context) => const CreateCommunityScreen(),
        AccountSettingsScreen.id: (context) => const AccountSettingsScreen(),
        SettingsScreen.id: (context) => const SettingsScreen(),
        NotificationSettingsScreen.id: (context) =>
            const NotificationSettingsScreen(),
        DisconnectScreen.id: (context) => const DisconnectScreen(),
        UpdateEmailAddressScreen.id: (context) =>
            const UpdateEmailAddressScreen(),
        ChangePasswordScreen.id: (context) => const ChangePasswordScreen(),
        SignupScreen.id: (context) => const SignupScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        ForgotPasswordScreen.id: (context) =>
            const ForgotPasswordScreen(username: ''),
        HomePageScreen.id: (context) => HomePageScreen(),
        BlockedAccount.id: (context) => const BlockedAccount(),
        SubredditScreen.id: (context) => const SubredditScreen(),
        //Resolved
        // SearchScreen.id: (context) => SearchScreen(),
        SubredditSearchScreen.id: (context) => const SubredditSearchScreen(),

        AddPostScreen.id: (context) => const AddPostScreen(),
        CreateUsernameScreen.id: (context) => const CreateUsernameScreen(),
        AboutYouScreen.id: (context) => const AboutYouScreen(),
        CommunityRulesScreen.id: (context) => const CommunityRulesScreen(),
        PostToScreen.id: (context) => const PostToScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
      },
      // initialRoute: (token == null)
      //     ? FirstScreen.id
      //     : (JwtDecoder.isExpired(token))
      //         ? LoginScreen.id
      //         : HomePageScreen.id,
      initialRoute: FirstScreen.id,
    );
  }
}
