import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import 'package:reddit_bel_ham/components/mod_tools_components/user_tile.dart';
import 'package:reddit_bel_ham/components/mod_tools_components/user_bottom_sheet_tile.dart';
import 'package:reddit_bel_ham/components/general_components/continue_button.dart';
import 'package:reddit_bel_ham/screens/new_message_screen.dart';
import 'package:reddit_bel_ham/screens/invite_moderator_screen.dart';

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
  late TabController _tabController;

  @override
  void didChangeDependencies() {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    communityName = args["communityName"];
    moderators = args["moderators"];
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    // if (isMyProfile) {
    //   if (mounted) {
    //     setState(() {
    //       getProfileInfo();
    //       isLoading = true;
    //     });
    //   }
    // }
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
                    UserBottomSheetTile(
                      text: 'View profile',
                      icon: Icon(
                        FontAwesomeIcons.circleUser,
                        size: ScreenSizeHandler.bigger *
                            kSettingsLeadingIconRatio *
                            0.8,
                        color: Colors.grey,
                      ),
                      onTap: () {},
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
                        // removeApprovedUser(username);
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
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              labelPadding:
                  EdgeInsets.only(right: ScreenSizeHandler.smaller * 0.08),
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
                  itemCount: 
                  moderators.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: kSettingsHorizontalPaddingHeightRatio *
                            ScreenSizeHandler.screenWidth,
                        vertical: 0.01 * ScreenSizeHandler.screenHeight,
                      ),
                      child: Column(
                        children: [
                          UserTile(
                            titleText: 
                            'u/${moderators[index]['userName']}',
                            subtitleText: '1 wk ago . Full Permissions',
                            onTap: () {},
                            avatarLink:
                                 moderators[index]['avatarImage'],
                            withIcon: false,
                            onIconTap: () {
                              // userOptions(approvedUsers[index]['userName']);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 
                  moderators.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: kSettingsHorizontalPaddingHeightRatio *
                            ScreenSizeHandler.screenWidth,
                        // vertical: 0.01 * ScreenSizeHandler.screenHeight,
                      ),
                      child: Column(
                        children: [
                          UserTile(
                            titleText:
                               'u/${moderators[index]['userName']}',
                            subtitleText: '1 wk ago . Full Permissions',
                            onTap: () {},
                            avatarLink:
                                moderators[index]['avatarImage'],
                            onIconTap: () {
                              userOptions(moderators[index]['userName']);
                              // userOptions('test');
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
