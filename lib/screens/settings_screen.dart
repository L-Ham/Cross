import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_screen';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String username = TokenDecoder.username;
  bool isBananaEnabled = false;
  bool isMuted = false;
  bool recentCommunities = false;
  String avatarImage = "";

  @override
  void didChangeDependencies() {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    avatarImage = args["avatar"];

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        toolbarHeight: ScreenSizeHandler.bigger * 0.055,
        leading: IconButton(
            key: const Key("settings_screen_back_button"),
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Settings",
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
                      child: const SettingsSegmentTitle(
                          titleText: "ACCOUNT SETTINGS"),
                    ),
                    Semantics(
                      identifier: 'settings_screen_account_settings_tile',
                      child: SettingsTile(
                        key: const Key("settings_screen_account_settings_tile"),
                        leadingIcon: Padding(
                          padding: EdgeInsets.only(
                            right: ScreenSizeHandler.screenWidth * 0.04,
                          ),
                          child: CircleAvatar(
                            radius: ScreenSizeHandler.bigger * 0.015,
                            backgroundImage:
                                avatarImage != 'assets/images/reddit_logo.png'
                                    ? NetworkImage(avatarImage)
                                    : const AssetImage(
                                            'assets/images/reddit_logo.png')
                                        as ImageProvider,
                          ),
                        ),
                        titleText: 'u/$username',
                        trailingWidget: const SettingsTileTrailingIcon(
                          trailingIcon: Icons.arrow_forward,
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AccountSettingsScreen.id,
                          );
                        },
                      ),
                    ),
                    const SettingsSegmentTitle(
                      titleText: "REDDIT PREMIUM",
                    ),
                    SettingsTile(
                      key: const Key("settings_screen_get_premium_tile"),
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: Icons.star_border_outlined,
                      ),
                      titleText: "Get Premium",
                      trailingWidget: const SettingsTileTrailingIcon(
                        trailingIcon: Icons.arrow_forward,
                      ),
                      onTap: () {
                        // Navigator.pushNamed(
                        //   context,
                        //   ChangePasswordScreen.id,
                        //   arguments: {
                        //     'email': connectedEmailAddress,
                        //     'username': username,
                        //   },
                        // );
                      },
                    ),
                    SettingsTile(
                      key: const Key("settings_screen_change_app_icon_tile"),
                      leadingIcon: Padding(
                        padding: EdgeInsets.only(
                          right: ScreenSizeHandler.screenWidth * 0.04,
                        ),
                        child: Image(
                          image:
                              const AssetImage('assets/images/reddit_logo.png'),
                          height: ScreenSizeHandler.screenHeight * 0.05,
                          width: ScreenSizeHandler.screenWidth * 0.05,
                        ),
                      ),
                      titleText: "Change app icon",
                      trailingWidget: const SettingsTileTrailingIcon(
                        trailingIcon: Icons.arrow_forward,
                      ),
                      onTap: () {},
                    ),
                    SettingsTile(
                      key: const Key("settings_screen_style_avatar_tile"),
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: FontAwesomeIcons.shirt,
                      ),
                      titleText: "Style Avatar",
                      trailingWidget: const SettingsTileTrailingIcon(
                        trailingIcon: Icons.arrow_forward,
                      ),
                      onTap: () {},
                    ),
                    const SettingsSegmentTitle(
                      titleText: "FEED OPTIONS",
                    ),
                    SettingsTile(
                      leadingIcon: ImageIcon(
                          const AssetImage('assets/images/banana_icon.png'),
                          color: Colors.grey,
                          size: ScreenSizeHandler.bigger * 0.05),
                      titleText: "Banana Counter",
                      trailingWidget: CustomSwitch(
                        key: const Key("settings_screen_banana_counter_switch"),
                        isSwitched: isBananaEnabled,
                        onChanged: (value) {
                          setState(() {
                            isBananaEnabled = !isBananaEnabled;
                          });
                        },
                      ),
                      onTap: () {},
                    ),
                    const SettingsSegmentTitle(
                      titleText: "Language",
                    ),
                    SettingsTile(
                      key: const Key("settings_screen_display_language_tile"),
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: FontAwesomeIcons.language,
                      ),
                      titleText: "Display Language",
                      trailingWidget: const SettingsTileTrailingIcon(
                        trailingIcon: Icons.arrow_forward,
                      ),
                      onTap: () {
                        //   Navigator.pushNamed(
                        //       context, NotificationSettingsScreen.id,
                        //       arguments: notificationsSwitchStates);
                      },
                    ),
                    SettingsTile(
                      key: const Key("settings_screen_content_language_tile"),
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: FontAwesomeIcons.language,
                      ),
                      titleText: "Content Language",
                      trailingWidget: const SettingsTileTrailingIcon(
                        trailingIcon: Icons.arrow_forward,
                      ),
                      onTap: () {
                        //   Navigator.pushNamed(
                        //       context, NotificationSettingsScreen.id,
                        //       arguments: notificationsSwitchStates);
                      },
                    ),
                    const SettingsSegmentTitle(
                      titleText: "VIEW OPTIONS",
                    ),
                    SettingsTile(
                      key: const Key("settings_screen_default_view_tile"),
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: Icons.table_rows_outlined,
                      ),
                      titleText: "Default view",
                      trailingWidget: const SettingsTileTrailingIcon(
                        trailingIcon: Icons.arrow_drop_down_sharp,
                      ),
                      onTap: () {
                        //Navigator.pushNamed(context, BlockedAccount.id);
                      },
                    ),
                    SettingsTile(
                      key: const Key("settings_screen_autoplay_tile"),
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: Icons.play_arrow_outlined,
                      ),
                      titleText: "Autoplay",
                      trailingWidget: const SettingsTileTrailingIcon(
                        trailingIcon: Icons.arrow_drop_down_sharp,
                      ),
                      onTap: () {
                        //Navigator.pushNamed(context, BlockedAccount.id);
                      },
                    ),
                    SettingsTile(
                      key: const Key("settings_screen_thumbnails_tile"),
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: Icons.table_rows_outlined,
                      ),
                      titleText: "Thumbnails",
                      trailingWidget: const SettingsTileTrailingIcon(
                        trailingIcon: Icons.arrow_drop_down_sharp,
                      ),
                      onTap: () {
                        //Navigator.pushNamed(context, BlockedAccount.id);
                      },
                    ),
                    SettingsTile(
                      key: const Key("settings_screen_text_size_tile"),
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: Icons.text_fields_rounded,
                      ),
                      titleText: "Text size",
                      trailingWidget: const SettingsTileTrailingIcon(
                        trailingIcon: Icons.arrow_forward,
                      ),
                      onTap: () {
                        //Navigator.pushNamed(context, BlockedAccount.id);
                      },
                    ),
                    const SettingsSegmentTitle(titleText: "ADVANCED"),
                    SettingsTile(
                      key: const Key("settings_screen_mute_videos_tile"),
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: Icons.volume_off_outlined,
                      ),
                      titleText: "Mute videos by default",
                      trailingWidget: CustomSwitch(
                        key: const Key("settings_screen_mute_videos_switch"),
                        isSwitched: isMuted,
                        onChanged: (value) {
                          setState(() {
                            isMuted = !isMuted;
                          });
                        },
                      ),
                      onTap: () {
                        //Navigator.pushNamed(context, BlockedAccount.id);
                      },
                    ),
                    SettingsTile(
                      key: const Key("settings_screen_recent_communities_tile"),
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: Icons.history_toggle_off,
                      ),
                      titleText: "Recent communities",
                      trailingWidget: CustomSwitch(
                        key: const Key(
                            "settings_screen_recent_communities_switch"),
                        isSwitched: recentCommunities,
                        onChanged: (value) {
                          setState(() {
                            recentCommunities = !recentCommunities;
                          });
                        },
                      ),
                      onTap: () {
                        //Navigator.pushNamed(context, BlockedAccount.id);
                      },
                    ),
                    SettingsTile(
                      key:
                          const Key("settings_screen_recent_comment_sort_tile"),
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: Icons.comment,
                      ),
                      titleText: "Default comment sort",
                      trailingWidget: const SettingsTileTrailingIcon(
                        trailingIcon: Icons.arrow_drop_down_sharp,
                      ),
                      onTap: () {
                        //Navigator.pushNamed(context, BlockedAccount.id);
                      },
                    ),
                    SettingsTile(
                      key: const Key(
                          "settings_screen_clear_local_history_sort_tile"),
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: Icons.delete_outlined,
                      ),
                      titleText: "Clear local history",
                      // trailingWidget: const SettingsTileTrailingIcon(
                      //   trailingIcon: Icons.arrow_drop_down_sharp,),
                      onTap: () {
                        //Navigator.pushNamed(context, BlockedAccount.id);
                      },
                    ),
                    const SettingsSegmentTitle(titleText: "ABOUT"),
                    SettingsTile(
                      key: const Key("settings_screen_content_policy_tile"),
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: Icons.list_alt_rounded,
                      ),
                      titleText: "Content policy",
                      onTap: () {
                        //Navigator.pushNamed(context, BlockedAccount.id);
                      },
                    ),
                    SettingsTile(
                      key: const Key("settings_screen_privacy_policy_tile"),
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: Icons.vpn_key_outlined,
                      ),
                      titleText: "Privacy policy",
                      onTap: () {
                        //Navigator.pushNamed(context, BlockedAccount.id);
                      },
                    ),
                    SettingsTile(
                      key: const Key("settings_screen_user_agreement_tile"),
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: Icons.person_2_outlined,
                      ),
                      titleText: "User agreement",
                      onTap: () {
                        //Navigator.pushNamed(context, BlockedAccount.id);
                      },
                    ),
                    SettingsTile(
                      key: const Key("settings_screen_acknowledgements_tile"),
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: Icons.list_alt_rounded,
                      ),
                      titleText: "Acknowledgements",
                      onTap: () {
                        //Navigator.pushNamed(context, BlockedAccount.id);
                      },
                    ),
                    const SettingsSegmentTitle(titleText: "SUPPORT"),
                    SettingsTile(
                      key: const Key("settings_screen_help_center_tile"),
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: Icons.help_outline_outlined,
                      ),
                      titleText: "Help center",
                      onTap: () {
                        //Navigator.pushNamed(context, BlockedAccount.id);
                      },
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
