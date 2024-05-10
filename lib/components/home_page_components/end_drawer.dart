import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_leading_icon.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_trailing_icon.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/home_page_screen.dart';
import 'package:reddit_bel_ham/screens/settings_screen.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

class EndDrawer extends StatefulWidget {
  final String username;
  final bool onlineStatusToggle;
  final String onlineStatusString;
  final Color onlineStatusColor;
  final double onlineStatusWidth;
  final Function(bool) toggleOnlineStatus;
  final String avatarImage;

  EndDrawer({
    Key? key,
    required this.username,
    required this.onlineStatusToggle,
    required this.onlineStatusString,
    required this.onlineStatusColor,
    required this.onlineStatusWidth,
    required this.toggleOnlineStatus,
    required this.avatarImage,
  }) : super(key: key);

  @override
  State<EndDrawer> createState() => _EndDrawerState();
}

class _EndDrawerState extends State<EndDrawer> {
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
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50,
                backgroundImage:
                    widget.avatarImage == 'assets/images/reddit_logo.png'
                        ? const AssetImage('assets/images/reddit_logo.png')
                        : NetworkImage(
                            widget.avatarImage,
                          ) as ImageProvider,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return DrawerBottomSheet(
                        avatarImage: widget.avatarImage,
                      );
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
                      // goToProfile(context,TokenDecoder.username);
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
                    onTap: () {
                      Navigator.pushNamed(context, 'history_screen');
                    },
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
                Navigator.pushNamed(context, SettingsScreen.id, arguments: {
                  "avatar": widget.avatarImage,
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
