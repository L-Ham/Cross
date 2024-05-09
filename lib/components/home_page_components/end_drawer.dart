import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_leading_icon.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_trailing_icon.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/home_page_screen.dart';
import 'package:reddit_bel_ham/screens/settings_screen.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import 'package:reddit_bel_ham/utilities/time_ago.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/components/general_components/reddit_loading_indicator.dart';
class EndDrawer extends StatefulWidget {
  final String username;
  final bool onlineStatusToggle;
  final String onlineStatusString;
  final Color onlineStatusColor;
  final double onlineStatusWidth;
  final Function(bool) toggleOnlineStatus;

  EndDrawer({
    Key? key,
    required this.username,
    required this.onlineStatusToggle,
    required this.onlineStatusString,
    required this.onlineStatusColor,
    required this.onlineStatusWidth,
    required this.toggleOnlineStatus,
  }) : super(key: key);

  @override
  State<EndDrawer> createState() => _EndDrawerState();
}

class _EndDrawerState extends State<EndDrawer> {
  ApiService apiService = ApiService(TokenDecoder.token);

   String avatarImage = '';

   String userName = '';

   String postKarma = '';

   String displayName = '';

   String commentKarma = '';

   String bannerImage = '';

   String created = '';

   bool isLoading=false;
   List<Map<String,dynamic>> socialLinks = [];


   @override
    void initState() {
      super.initState();
      isLoading=false;
    }

  //   Future<void> getUserPersonalInfo() async {
  //   Map<String, dynamic> data =
  //       (await apiService.getUserSelfInfo()) ?? {};
  //   avatarImage = data['user']['avatar'] ?? '';
  //   userName = data['user']['username'] ?? '';
  //   postKarma = data['user']['post_karma'].toString() ?? '0';
  //   displayName = data['user']['display_name'] ?? widget.username;
  //   commentKarma = data['user']['comment_karma'].toString() ?? '0';
  //   bannerImage = data['user']['banner'] ?? '';
  //   created = timeAgo(data['user']['created'].toString()) ?? '';
  //   // isLoading=false;
  //   Navigator.pushNamed(context, 'profile_screen', arguments: {'isMyProfile': true, 'username': userName, 'avatarImage': avatarImage, 'bannerImage': bannerImage, 'postKarma': postKarma, 'commentKarma': commentKarma, 'displayName': displayName, 'created': created});

  // }
  // Future<void> getSocialLinks() async {
  //   Map<String, dynamic> data =
  //       (await apiService.getProfileSettings()) ?? {};
  //   socialLinks = (data['profileSettings']['socialLinks'] as List<dynamic>)
  //   ?.map((item) => item as Map<String, dynamic>)
  //   ?.toList() ?? [];
  // }

  // Future<void> getProfileInfo() async {
  //   await getUserPersonalInfo();
  //   await getSocialLinks();
  //   Navigator.pushNamed(context, 'profile_screen', arguments: {'isMyProfile': true, 'username': userName, 'avatarImage': avatarImage, 'bannerImage': bannerImage, 'postKarma': postKarma, 'commentKarma': commentKarma, 'displayName': displayName, 'created': created, 'socialLinks': socialLinks});
  // }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      child: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50,
                backgroundImage: AssetImage('assets/images/reddit_logo.png'),
                child: Text('P'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return const DrawerBottomSheet();
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'u/${widget.username}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down_rounded),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.toggleOnlineStatus(!widget.onlineStatusToggle);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Container(
                  height: 24,
                  width: widget.onlineStatusWidth * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: widget.onlineStatusColor,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.onlineStatusToggle)
                          Icon(
                            Icons.circle,
                            color: widget.onlineStatusColor,
                            size: 18,
                          ),
                        Text(
                          'Online Status: ${widget.onlineStatusString}',
                          style: TextStyle(
                            color: widget.onlineStatusColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  SettingsTile(
                    leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: Icons.account_circle_outlined),
                    titleText: "Profile",
                    onTap: () {
                      setState(() {
                        Navigator.pushNamed(context, 'profile_screen', arguments: {'isMyProfile': true,});
                      // getProfileInfo();
                      });
                    },
                  ),
                  SettingsTile(
                    leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: Icons.groups_rounded),
                    titleText: "Create a community",
                    onTap: () {
                      Navigator.pushNamed(context, 'create_community_screen');
                    },
                  ),
                  SettingsTile(
                    leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: Icons.bookmarks_outlined),
                    titleText: "Saved",
                    onTap: () {
                      Navigator.pushNamed(context, 'saved_screen');
                    },
                  ),
                  SettingsTile(
                    leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: Icons.access_time_rounded),
                    titleText: "History",
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SettingsTile(
              leadingIcon: const SettingsTileLeadingIcon(
                  leadingIcon: Icons.settings_outlined),
              titleText: "Settings",
              trailingWidget: const SettingsTileTrailingIcon(
                  trailingIcon: Icons.nights_stay_sharp),
              onTap: () {
                Navigator.pushNamed(context, SettingsScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
