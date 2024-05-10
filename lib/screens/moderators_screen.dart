import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import 'package:reddit_bel_ham/components/mod_tools_components/user_tile.dart';
import 'package:reddit_bel_ham/components/mod_tools_components/user_bottom_sheet_tile.dart';
import 'package:reddit_bel_ham/components/general_components/continue_button.dart';
import 'package:reddit_bel_ham/screens/invite_moderator_screen.dart';
import 'package:reddit_bel_ham/utilities/go_to_profile.dart';

class ModeratorsScreen extends StatefulWidget {
  const ModeratorsScreen({super.key});

  static const String id = 'moderators_screen';

  @override
  State<ModeratorsScreen> createState() => _ModeratorsScreenState();
}

class _ModeratorsScreenState extends State<ModeratorsScreen>
    with SingleTickerProviderStateMixin {
  ApiService apiService = ApiService(TokenDecoder.token);
  String communityName = '';
  var moderators = [];
  bool isInvited = false;
  late TabController _tabController;

  void invitedBottomSheet() async {
    await Future.delayed(const Duration(seconds: 2));
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenSizeHandler.screenHeight * 0.01),
                      child: Center(
                        child: Text(
                          'Congrats!',
                          style: TextStyle(
                            fontSize: ScreenSizeHandler.smaller * 0.045,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenSizeHandler.screenHeight * 0.01,
                          horizontal: ScreenSizeHandler.screenWidth * 0.03),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'You are invited to become a moderator!',
                          style: TextStyle(
                            fontSize: ScreenSizeHandler.smaller * 0.03,
                            fontWeight: FontWeight.normal,
                            color: kHintTextColor,
                          ),
                        ),
                      ),
                    ),
                    ContinueButton(
                      onPress: () {
                        Navigator.pop(context);
                      },
                      text: 'Accept',
                      color: Colors.blue[900],
                    ),
                    ContinueButton(
                      onPress: () {
                        Navigator.pop(context);
                      },
                      text: 'Decline',
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
  void didChangeDependencies() {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    communityName = args["communityName"];
    moderators = args["moderators"];
    if (args['isInvited'] != null) {
      isInvited = args['isInvited'];
    }
    if (isInvited) {
      if (mounted) {
        // setState(() {
          invitedBottomSheet();
        // });
      }
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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

  Future<void> removeModerator(String username) async {
    Map<String, dynamic> response =
        await apiService.removeModerator(communityName, username);
    if (response['message'] == "Moderator removed successfully") {
      if (mounted) {
        setState(() {
          showSnackBar('u/ $username was removed as a moderator');
        });
      }
      getModerators();
      Navigator.pop(context);
    } else {
      if (mounted) {
        setState(() {
          showSnackBar('Error: ${response['message']}');
        });
      }
    }
  }

  Future<void> getModerators() async {
    Map<String, dynamic> data =
        (await apiService.getCommunityModerators(communityName)) ?? {};
    if (mounted) {
      if (mounted) {
        setState(() {
          moderators = data['moderators'];
        });
      }
    }
  }

  void userOptions(String username) async {
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
                    if (username != TokenDecoder.username)
                      UserBottomSheetTile(
                        text: 'Edit Permissions',
                        icon: Icon(
                          FontAwesomeIcons.pen,
                          size: ScreenSizeHandler.bigger *
                              kSettingsLeadingIconRatio *
                              0.8,
                          color: Colors.grey,
                        ),
                        onTap: () {},
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
                      text: 'Remove',
                      icon: Icon(
                        FontAwesomeIcons.ban,
                        size: ScreenSizeHandler.bigger *
                            kSettingsLeadingIconRatio *
                            0.8,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        removeModerator(username);
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
          'Moderators',
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
                  Navigator.pushNamed(context, InviteModeratorScreen.id,
                      arguments: {
                        "communityName": communityName,
                      });
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
      body: moderators.isEmpty
          ? Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenSizeHandler.smaller * 0.1),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No moderators',
                      style: TextStyle(
                        fontSize: ScreenSizeHandler.smaller * 0.06,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Moderators of this subreddit will appear here',
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
                Container(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    indicatorColor: Colors.white,
                    labelColor: Colors.white,
                    labelPadding: EdgeInsets.only(
                        right: ScreenSizeHandler.smaller * 0.08),
                    unselectedLabelColor: kHintTextColor,
                    dividerHeight: 0.0,
                    tabs: const [
                      Tab(text: 'All'),
                      Tab(text: 'Editable'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: moderators.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  kSettingsHorizontalPaddingHeightRatio *
                                      ScreenSizeHandler.screenWidth,
                              vertical: 0.01 * ScreenSizeHandler.screenHeight,
                            ),
                            child: Column(
                              children: [
                                UserTile(
                                  titleText:
                                      'u/${moderators[index]['userName']}',
                                  subtitleText: '1 wk ago . Full Permissions',
                                  onTap: () {
                                    goToProfile(
                                        context, moderators[index]['userName']);
                                  },
                                  avatarLink: moderators[index]['avatarImage'],
                                  withIcon: false,
                                  onIconTap: () {},
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: moderators.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  kSettingsHorizontalPaddingHeightRatio *
                                      ScreenSizeHandler.screenWidth,
                            ),
                            child: Column(
                              children: [
                                UserTile(
                                  titleText:
                                      'u/${moderators[index]['userName']}',
                                  subtitleText: '1 wk ago . Full Permissions',
                                  onTap: () {
                                    goToProfile(
                                        context, moderators[index]['userName']);
                                  },
                                  avatarLink: moderators[index]['avatarImage'],
                                  onIconTap: () {
                                    userOptions(moderators[index]['userName']);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
