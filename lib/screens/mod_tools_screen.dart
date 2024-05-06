import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/components/general_components/custom_switch.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/account_settings_screen.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_segment_tile.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_leading_icon.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_trailing_icon.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

class ModToolsScreen extends StatefulWidget {
  const ModToolsScreen({super.key});

  static const String id = 'mod_tools_screen';

  @override
  State<ModToolsScreen> createState() => _ModToolsScreenState();
}

class _ModToolsScreenState extends State<ModToolsScreen> {
  String username = TokenDecoder.username;
  bool isBananaEnabled = false;
  bool isMuted = false;
  bool recentCommunities = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        toolbarHeight: ScreenSizeHandler.bigger * 0.055,
        leading: IconButton(
            key: const Key("mod_tools_screen_back_button"),
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Mod tools",
          style: kPageTitleStyle.copyWith(
              fontSize:
                  ScreenSizeHandler.smaller * kAppBarTitleSmallerFontRatio),
        ),
        centerTitle: true,
      ),
      backgroundColor: kSettingsBackGroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenSizeHandler.screenHeight * 0.03),
                      child: const SettingsSegmentTitle(titleText: "GENERAL"),
                    ),
                    SettingsTile(
                      key: const Key("mod_tools_screen_insights_tile"),
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: FontAwesomeIcons.chartLine,
                      ),
                      titleText: "Insights",
                      trailingWidget: const SettingsTileTrailingIcon(
                        trailingIcon: Icons.arrow_forward,
                      ),
                      onTap: () {},
                    ),
                    SettingsTile(
                      key: const Key("mod_tools_screen_mod_log_tile"),
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: Icons.list_rounded,
                      ),
                      titleText: "Mod Log",
                      trailingWidget: const SettingsTileTrailingIcon(
                        trailingIcon: Icons.arrow_forward,
                      ),
                      onTap: () {},
                    ),
                    SettingsTile(
                      key: const Key("mod_tools_screen_description_tile"),
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: FontAwesomeIcons.pen,
                      ),
                      titleText: "Description",
                      trailingWidget: const SettingsTileTrailingIcon(
                        trailingIcon: Icons.arrow_forward,
                      ),
                      onTap: () {},
                    ),
                   SettingsTile(
                      key: const Key("mod_tools_screen_community_type_tile"),
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: FontAwesomeIcons.lock,
                      ),
                      titleText: "Community type",
                      trailingWidget: const SettingsTileTrailingIcon(
                        trailingIcon: Icons.arrow_forward,
                      ),
                      onTap: () {},
                    ),
                    SettingsTile(
                      key: const Key("mod_tools_screen_post_types_tile"),
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: FontAwesomeIcons.rectangleList,
                      ),
                      titleText: "Post types",
                      trailingWidget: const SettingsTileTrailingIcon(
                        trailingIcon: Icons.arrow_forward,
                      ),
                      onTap: () {},
                    ),
                     Padding(
                      padding: EdgeInsets.only(
                          top: ScreenSizeHandler.screenHeight * 0.03),
                      child: const SettingsSegmentTitle(titleText: "USER MANAGEMENT"),
                    ),
                    SettingsTile(
                      key: const Key("mod_tools_screen_moderators_tile"),
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: Icons.shield_outlined,
                      ),
                      titleText: "Moderators",
                      trailingWidget: const SettingsTileTrailingIcon(
                        trailingIcon: Icons.arrow_forward,
                      ),
                      onTap: () {},
                    ),
                      SettingsTile(
                      key: const Key("mod_tools_screen_approved_users_tile"),
                      leadingIcon:  ImageIcon(
                          const AssetImage('assets/images/approved_user_icon.png'),
                          color: Colors.grey,
                          size: ScreenSizeHandler.bigger * 0.05),
                      titleText: "Approved users",
                      trailingWidget: const SettingsTileTrailingIcon(
                        trailingIcon: Icons.arrow_forward,
                      ),
                      onTap: () {},
                    ),
                    SettingsTile(
                      key: const Key("mod_tools_screen_banned_users_tile"),
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: FontAwesomeIcons.hammer,
                      ),
                      titleText: "Banned users",
                      trailingWidget: const SettingsTileTrailingIcon(
                        trailingIcon: Icons.arrow_forward,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
