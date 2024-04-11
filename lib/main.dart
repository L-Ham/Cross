import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:reddit_bel_ham/screens/about_you_screen.dart';
import 'package:reddit_bel_ham/screens/change_password_screen.dart';
import 'package:reddit_bel_ham/screens/connected_accounts_disconnect_screen.dart';
import 'package:reddit_bel_ham/screens/settings_screen.dart';
import 'package:reddit_bel_ham/screens/create_username_screen.dart';
import 'package:reddit_bel_ham/screens/update_email_address_screen.dart';
import 'package:reddit_bel_ham/screens/create_community_screen.dart';
import 'screens/account_settings_screen.dart';
import 'utilities/screen_size_handler.dart';
import 'screens/notifications_settings_screen.dart';
import 'screens/first_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/home_page_screen.dart';
import 'screens/blocked_accounts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'services/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
//   await Firebase.initializeApp(
//   options: DefaultFirebaseOptions.currentPlatform,
// );
  runApp(RedditByLham(token: prefs.getString('token')));
  // runApp(RedditByLham(token: 'token'));
}

class RedditByLham extends StatelessWidget {
  final token;
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
        FirstScreen.id: (context) => FirstScreen(),
        CreateCommunityScreen.id: (context) => const CreateCommunityScreen(),
        AccountSettingsScreen.id: (context) => const AccountSettingsScreen(),
        SettingsScreen.id:(context) => const SettingsScreen(),
        NotificationSettingsScreen.id: (context) =>
            const NotificationSettingsScreen(),
        DisconnectScreen.id: (context) => const DisconnectScreen(),
        UpdateEmailAddressScreen.id: (context) =>
            const UpdateEmailAddressScreen(),
        ChangePasswordScreen.id: (context) => const ChangePasswordScreen(),
        SignupScreen.id: (context) => const SignupScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        ForgotPasswordScreen.id: (context) => const ForgotPasswordScreen(),
        HomePageScreen.id: (context) => HomePageScreen(token: token),
        BlockedAccount.id: (context) => const BlockedAccount(),
        CreateUsernameScreen.id: (context) => const CreateUsernameScreen(),
        AboutYouScreen.id: (context) => const AboutYouScreen(),
        //Resolved
        // SearchScreen.id: (context) => SearchScreen(),
      },
      initialRoute: FirstScreen.id//(token==null)?FirstScreen.id: (JwtDecoder.isExpired(token)) ? LoginScreen.id : HomePageScreen.id,
    );
  }
}
