import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import 'package:reddit_bel_ham/components/mod_tools_components/user_tile.dart';
import 'package:reddit_bel_ham/components/mod_tools_components/user_bottom_sheet_tile.dart';
import 'package:reddit_bel_ham/components/general_components/continue_button.dart';
import 'package:reddit_bel_ham/screens/ban_user_screen.dart';
import 'package:reddit_bel_ham/screens/ban_details_screen.dart';
import '../utilities/time_ago.dart';
import '../utilities/go_to_profile.dart';

class BannedUsersScreen extends StatefulWidget {
  const BannedUsersScreen({super.key});

  static const String id = 'banned_users_screen';

  @override
  State<BannedUsersScreen> createState() => _BannedUsersScreenState();
}

class _BannedUsersScreenState extends State<BannedUsersScreen> {
  ApiService apiService = ApiService(TokenDecoder.token);
  List<dynamic> bannedUsers = [];
  String communityName = '';

  @override
  void didChangeDependencies() {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    communityName = args["communityName"];
    super.didChangeDependencies();
    getBannedUsers();
  }

  void showSnackBar(String snackBarText) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(snackBarText),
          backgroundColor: Colors.white,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            left: ScreenSizeHandler.screenWidth * kButtonWidthRatio,
            right: ScreenSizeHandler.screenWidth * kButtonWidthRatio,
            bottom: ScreenSizeHandler.screenHeight * 0.09,
          ),
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      );
    });
  }

  Future<void> getBannedUsers() async {
    Map<String, dynamic> response =
        await apiService.getBannedUsers(communityName);
    if (response['message'] ==
        "Retrieved subreddit Banned Users Successfully") {
      if (mounted) {
        setState(() {
          bannedUsers = response['bannedUsers'];
        });
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('$communityName: ${response['message']}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> unbanUser(String userName) async {
    Map<String, dynamic> response =
        await apiService.unbanUser(communityName, userName);
    if (response['message'] == "User unbanned successfully") {
      if (mounted) {
        setState(() {
          showSnackBar('u/$userName was unbanned');
        });
      }
      Navigator.pop(context);
    } else {
      if (mounted) {
        setState(() {
          showSnackBar('Error: ${response['message']}');
        });
      }
    }
  }

  void userOptions(String username, String ruleBroken, String modNote) async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
            child: Container(
              padding: EdgeInsets.only(
                  bottom: ScreenSizeHandler.screenHeight * 0.025),
              color: Colors.grey[900],
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    UserBottomSheetTile(
                      text: 'See details',
                      icon: Icon(
                        FontAwesomeIcons.pen,
                        size: ScreenSizeHandler.bigger *
                            kSettingsLeadingIconRatio *
                            0.8,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, BanDetailsScreen.id,
                            arguments: {
                              'ruleBroken': ruleBroken,
                              'modNote': modNote,
                              'userName': username,
                              'communityName': communityName,
                            });
                      },
                    ),
                    UserBottomSheetTile(
                      text: 'View profile',
                      icon: Icon(
                        FontAwesomeIcons.circleUser,
                        size: ScreenSizeHandler.bigger *
                            kSettingsLeadingIconRatio *
                            0.8,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        goToProfile(context, username);
                      },
                    ),
                    UserBottomSheetTile(
                      text: 'Unban',
                      icon: Icon(
                        FontAwesomeIcons.hammer,
                        size: ScreenSizeHandler.bigger *
                            kSettingsLeadingIconRatio *
                            0.8,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        unbanUser(username);
                      },
                    ),
                    ContinueButton(
                      onPress: () {
                        Navigator.pop(context);
                      },
                      text: 'Cancel',
                      color: Colors.grey[800],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
    setState(
      () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Banned users',
          style: TextStyle(
            fontSize: ScreenSizeHandler.bigger * 0.025,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: kBackgroundColor,
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                iconSize: ScreenSizeHandler.smaller * 0.07,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, BanUserScreen.id,
                      arguments: {'communityName': communityName});
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                iconSize: ScreenSizeHandler.smaller * 0.07,
              ),
            ],
          )
        ],
      ),
      body: bannedUsers.isEmpty
          ? Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenSizeHandler.smaller * 0.1),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No banned users',
                      style: TextStyle(
                        fontSize: ScreenSizeHandler.smaller * 0.06,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Users banned from the subreddit will appear here',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: ScreenSizeHandler.smaller * 0.04,
                        fontWeight: FontWeight.normal,
                        color: kHintTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: bannedUsers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: kSettingsHorizontalPaddingHeightRatio *
                                ScreenSizeHandler.screenWidth,
                          ),
                          child: Column(
                            children: [
                              UserTile(
                                titleText:
                                    'u/${bannedUsers[index]['userName']}',
                                subtitleText:
                                    "${bannedUsers[index]['bannedAt'] != null ? timeAgo(bannedUsers[index]['bannedAt']) : '1 wk ago'} . ${bannedUsers[index]['reasonForBan'] ?? 'No reason provided'}",
                                onTap: () {
                                  goToProfile(
                                      context, bannedUsers[index]['userName']);
                                },
                                avatarLink: bannedUsers[index]['avatarImage'],
                                onIconTap: () {
                                  userOptions(
                                      bannedUsers[index]['userName'],
                                      bannedUsers[index]['reasonForBan'],
                                      bannedUsers[index]['modNote']);
                                },
                              ),
                            ],
                          ));
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
