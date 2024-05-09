
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reddit_bel_ham/components/home_page_components/mark_all_as_read.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/TrendingTopCommunitiesScreen.dart';
import 'package:reddit_bel_ham/screens/activity_screen.dart';
import 'package:reddit_bel_ham/screens/add_comment_screen.dart';
import 'package:reddit_bel_ham/screens/add_post_screen.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:reddit_bel_ham/screens/about_you_screen.dart';
import 'package:reddit_bel_ham/screens/change_password_screen.dart';
import 'package:reddit_bel_ham/screens/comments_screen.dart';
import 'package:reddit_bel_ham/screens/communities_screen.dart';
import 'package:reddit_bel_ham/screens/community_rules_screen.dart';
import 'package:reddit_bel_ham/screens/connected_accounts_disconnect_screen.dart';
import 'package:reddit_bel_ham/screens/edit_post_screen.dart';
import 'package:reddit_bel_ham/screens/message_reply_screen.dart';
import 'package:reddit_bel_ham/screens/messages_screen.dart';
import 'package:reddit_bel_ham/screens/new_message_screen.dart';
import 'package:reddit_bel_ham/screens/post_to_screen.dart';
import 'package:reddit_bel_ham/screens/searching_in_subreddit_screen.dart';
import 'package:reddit_bel_ham/screens/searching_screen.dart';
import 'package:reddit_bel_ham/screens/saved_screen.dart';
import 'package:reddit_bel_ham/screens/settings_screen.dart';
import 'package:reddit_bel_ham/screens/create_username_screen.dart';
import 'package:reddit_bel_ham/screens/update_email_address_screen.dart';
import 'package:reddit_bel_ham/screens/create_community_screen.dart';

import 'package:reddit_bel_ham/screens/mod_tools_screen.dart';
import 'package:reddit_bel_ham/screens/describe_your_community_screen.dart';
import 'package:reddit_bel_ham/screens/community_type_screen.dart';
import 'package:reddit_bel_ham/screens/approved_users_screen.dart';
import 'package:reddit_bel_ham/screens/add_approved_user_screen.dart';
import 'package:reddit_bel_ham/screens/banned_users_screen.dart';
import 'package:reddit_bel_ham/screens/ban_user_screen.dart';
import 'package:reddit_bel_ham/screens/moderators_screen.dart';
import 'package:reddit_bel_ham/screens/invite_moderator_screen.dart';

import 'package:reddit_bel_ham/utilities/subreddit_store.dart';
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
import 'screens/inside_chat_screen.dart';
import 'screens/chatting_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:reddit_bel_ham/screens/inbox_messages.dart';
import 'screens/profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:reddit_bel_ham/screens/edit_profile_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
  } catch (e) {
    print(e);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('elham_final_logo');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.getToken().then((String? token) {
    if (token != null) {
      print('FCM Token: $token');
    }
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification?.title,
          notification?.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'reddit_bel_ham',
              'reddit_bel_ham channel',
              icon: 'elham_final_logo',
              playSound: true,
              enableVibration: true,
              priority: Priority.high,
              importance: Importance.max,
            ),
          ));
    }

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
  });

  String? token = prefs.getString('token');
  if (token != null) {
    TokenDecoder.updateToken(token);
  }
  runApp(
    ChangeNotifierProvider(
      create: (context) => MarkAllAsRead(),
      child: RedditByLham(token: token),
    ),
  );
}

class RedditByLham extends StatelessWidget {
  final String? token;
  const RedditByLham({@required this.token, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.instance.getToken().then((value) {
      print("VALUE IS $value");
      
    });
    ScreenSizeHandler.initialize(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    return MaterialApp(
      title: 'HTTP',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kBackgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: kBackgroundColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        FirstScreen.id: (context) => const FirstScreen(),
        CreateCommunityScreen.id: (context) => const CreateCommunityScreen(),
        AccountSettingsScreen.id: (context) => const AccountSettingsScreen(),
        SettingsScreen.id: (context) => SettingsScreen(),
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
        HomePageScreen.id: (context) => const HomePageScreen(),
        BlockedAccount.id: (context) => const BlockedAccount(),
        SavedScreen.id: (context) => const SavedScreen(),
        SubredditScreen.id: (context) => const SubredditScreen(),
        AddPostScreen.id: (context) => const AddPostScreen(),
        CreateUsernameScreen.id: (context) => const CreateUsernameScreen(),
        AboutYouScreen.id: (context) => const AboutYouScreen(),
        CommunityRulesScreen.id: (context) => const CommunityRulesScreen(),
        PostToScreen.id: (context) => const PostToScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        CommentsScreen.id: (context) => const CommentsScreen(),
        AddCommentScreen.id: (context) => const AddCommentScreen(),
        CommunitiesScreen.id: (context) => const CommunitiesScreen(),
        TrendingTopCommunitiesScreen.id: (context) =>
            const TrendingTopCommunitiesScreen(),
        InboxMessagesScreen.id: (context) => const InboxMessagesScreen(),
        MessagesScreen.id: (context) => const MessagesScreen(),
        MessageReplyScreen.id: (context) => const MessageReplyScreen(),
        NewMessageScreen.id: (context) => const NewMessageScreen(),
        SearchingScreen.id: (context) => const SearchingScreen(),
        SearchingInSubreddit.id: (context) => const SearchingInSubreddit(),
        EditPostScreen.id: (context) => const EditPostScreen(),
        EditProfileScreen.id: (context) => const EditProfileScreen(),
        ModToolsScreen.id: (context) => const ModToolsScreen(),
        DescribeCommunityScreen.id: (context) =>
            const DescribeCommunityScreen(),
        CommunityTypeScreen.id: (context) => const CommunityTypeScreen(),
        ApprovedUsersScreen.id: (context) => const ApprovedUsersScreen(),
        AddApprovedUserScreen.id: (context) => const AddApprovedUserScreen(),
        BannedUsersScreen.id: (context) => const BannedUsersScreen(),
        BanUserScreen.id: (context) => const BanUserScreen(),
        ChattingScreen.id: (context) => ChattingScreen(),
        ActivityScreen.id: (context) => const ActivityScreen(),
        ModeratorsScreen.id: (context) => const ModeratorsScreen(),
        InviteModeratorScreen.id: (context) => const InviteModeratorScreen(),
      },
      initialRoute: (token == null)
          ? FirstScreen.id
          : (JwtDecoder.isExpired(TokenDecoder.token))
              ? LoginScreen.id
              : HomePageScreen.id,
    );
  }
}
