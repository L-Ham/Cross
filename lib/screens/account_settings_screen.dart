import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/create_community_components/custom_switch.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'change_gender_bottom_sheet.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_segment_tile.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_leading_icon.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_image.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_trailing_icon.dart';
import 'package:reddit_bel_ham/components/general_components/interactive_text.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  String gender = "Male";
  String connectedEmailAddress = "daniel.gebraiel01@eng-st.cu.edu.eg";
  bool allowPeopleToFollowYou = false;
  bool isConnectedToGoogle = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: kFillingColor,
          toolbarHeight: ScreenSizeHandler.bigger * 0.06,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            "Account Settings",
            style: kPageTitleStyle.copyWith(
                fontSize: ScreenSizeHandler.bigger * kAppBarTitleFontSizeRatio),
          ),
          centerTitle: true,
        ),
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SettingsSegmentTitle(titleText: "Basic Settings"),
                      SettingsTile(
                        leadingIcon: const SettingsTileLeadingIcon(
                          leadingIcon: Icons.settings_outlined,
                        ),
                        titleText: "Update Email Address",
                        trailingWidget: const SettingsTileTrailingIcon(
                          trailingIcon: Icons.arrow_forward,
                        ),
                        subtitleText: connectedEmailAddress,
                        onTap: () {
                          Navigator.pushNamed(
                              context, 'update_email_address_screen');
                        },
                      ),
                      SettingsTile(
                        leadingIcon: const SettingsTileLeadingIcon(
                          leadingIcon: Icons.settings_outlined,
                        ),
                        titleText: "Change Password",
                        trailingWidget: const SettingsTileTrailingIcon(
                          trailingIcon: Icons.arrow_forward,
                        ),
                        onTap: () {},
                      ),
                      SettingsTile(
                        leadingIcon: const SettingsTileLeadingIcon(
                          leadingIcon: Icons.person,
                        ),
                        titleText: "Gender",
                        subtitleText: gender,
                        trailingWidget: const SettingsTileTrailingIcon(
                          trailingIcon: Icons.arrow_drop_down_sharp,
                        ),
                        onTap: () async {
                          String? newGender = await showModalBottomSheet(
                              backgroundColor: kBackgroundColor.withOpacity(0),
                              context: context,
                              builder: (BuildContext bc) {
                                return ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(20.0),
                                  ),
                                  child: ChangeGenderBottomSheet(
                                    initialValue: gender,
                                  ),
                                );
                              });
                          setState(
                            () {
                              if (newGender != null) {
                                gender = newGender;
                              }
                            },
                          );
                        },
                      ),
                      SettingsTile(
                        leadingIcon: const SettingsTileLeadingIcon(
                          leadingIcon: Icons.location_on_outlined,
                        ),
                        titleText: "Location Customization",
                        trailingWidget: const SettingsTileTrailingIcon(
                          trailingIcon: Icons.arrow_forward,
                        ),
                        onTap: () {},
                      ),
                      const SettingsSegmentTitle(
                        titleText: "Connected Accounts",
                      ),
                      SettingsTile(
                        leadingIcon: const SettingsTileImage(
                          assetImageData: 'assets/images/google_logo.png',
                        ),
                        titleText: "Google",
                        trailingWidget: isConnectedToGoogle
                            ? InteractiveText(
                                text: "Disconnect",
                                onTap: () {
                                  Navigator.pushNamed(context,
                                      'connected_accounts_disconnect_screen');
                                },
                              )
                            : InteractiveText(
                                text: "Connect",
                                onTap: () {
                                  //TODO: Implement the connect functionality
                                },
                              ),
                        onTap: () {},
                      ),
                      const SettingsSegmentTitle(
                        titleText: "Contact Settings",
                      ),
                      SettingsTile(
                        leadingIcon: const SettingsTileLeadingIcon(
                          leadingIcon: Icons.notifications_outlined,
                        ),
                        titleText: "Manage Notifications",
                        trailingWidget: const SettingsTileTrailingIcon(
                          trailingIcon: Icons.arrow_forward,
                        ),
                        onTap: () {},
                      ),
                      const SettingsSegmentTitle(
                        titleText: "Blocking and Permissions",
                      ),
                      SettingsTile(
                        leadingIcon: const SettingsTileLeadingIcon(
                          leadingIcon: Icons.block_outlined,
                        ),
                        titleText: "Manage Blocked Accounts",
                        trailingWidget: const SettingsTileTrailingIcon(
                          trailingIcon: Icons.arrow_forward,
                        ),
                        onTap: () {},
                      ),
                      SettingsTile(
                        leadingIcon: const SettingsTileLeadingIcon(
                          leadingIcon: Icons.people,
                        ),
                        titleText: "Allow People to Follow You",
                        trailingWidget: CustomSwitch(
                          isSwitched: allowPeopleToFollowYou,
                          onChanged: (value) {
                            setState(() {
                              allowPeopleToFollowYou = !allowPeopleToFollowYou;
                            });
                          },
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
      ),
    );
  }
}
