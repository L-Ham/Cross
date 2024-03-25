import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_leading_icon.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_trailing_icon.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class TempHomeScreen extends StatefulWidget {
  const TempHomeScreen({Key? key}) : super(key: key);

  @override
  TempHomeScreenState createState() => TempHomeScreenState();
}

class TempHomeScreenState extends State<TempHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String username = "peter_ashraf";
  String onlineStatusString = "On";
  bool onlineStatusToggle = true;
  Color onlineStatusColor = kOnlineStatusColor;
  double onlineStatusWidth = ScreenSizeHandler.smaller * 0.42;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Temp Home Screen'),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
              child: const CircleAvatar(
                backgroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(),
      drawer: Drawer(
          //TODO: Add the left drawer here
          ),
      endDrawer: Drawer(
        backgroundColor: kBackgroundColor,
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: ScreenSizeHandler.bigger*kSideBarCloseIconSizeRatio,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: ScreenSizeHandler.screenHeight * 0.02),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text('A'),
                  radius: ScreenSizeHandler.bigger * kSideBarCircleAvatarRadiusRatio,
                  foregroundImage: AssetImage('assets/images/reddit_logo.png'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: ScreenSizeHandler.screenHeight * 0.015),
                child: Text('u/$username',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenSizeHandler.bigger * 0.026,
                        fontWeight: FontWeight.bold)),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    onlineStatusToggle = !onlineStatusToggle;
                    if (onlineStatusToggle) {
                      onlineStatusString = "On";
                      onlineStatusColor = Color.fromARGB(255, 0, 204, 120);
                      onlineStatusWidth = ScreenSizeHandler.smaller * 0.42;
                    } else {
                      onlineStatusString = "Off";
                      onlineStatusColor = Colors.grey;
                      onlineStatusWidth = ScreenSizeHandler.screenWidth * 0.38;
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    height: ScreenSizeHandler.bigger * 0.04,
                    width: onlineStatusWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), // adjust the radius as needed
                      border: Border.all(
                        color: onlineStatusColor, // set border color
                        width: ScreenSizeHandler.smaller*0.006, // set border width
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (onlineStatusToggle)
                            Icon(
                              Icons.circle,
                              color: onlineStatusColor,
                              size: kOnlineStatusIconSize,
                            ),
                          Text(
                            'Online Status: $onlineStatusString',
                            style: TextStyle(
                                color: onlineStatusColor,
                                fontSize: ScreenSizeHandler.smaller * kOnlineStatusFontSizeRatio,
                                fontWeight: FontWeight.bold),
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
                        leadingIcon: Icons.account_circle_outlined,
                      ),
                      titleText: "Profile",
                      onTap: () {},
                    ),
                    SettingsTile(
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: Icons.groups_rounded,
                      ),
                      titleText: "Create a community",
                      onTap: () {
                        Navigator.pushNamed(context, 'create_community_screen');
                      },
                    ),
                    SettingsTile(
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: Icons.bookmarks_outlined,
                      ),
                      titleText: "Saved",
                      onTap: () {},
                    ),
                    SettingsTile(
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: Icons.access_time_rounded,
                      ),
                      titleText: "History",
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SettingsTile(
                leadingIcon: const SettingsTileLeadingIcon(
                  leadingIcon: Icons.settings_outlined,
                ),
                titleText: "Settings",
                trailingWidget: Icon(Icons.nights_stay_sharp, size: 25),
                onTap: () {
                  Navigator.pushNamed(context, 'account_settings_screen');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
