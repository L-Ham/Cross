import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/general_components/custom_switch.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/change_password_screen.dart';
import 'package:reddit_bel_ham/screens/connected_accounts_disconnect_screen.dart';
import 'package:reddit_bel_ham/screens/notifications_screen.dart';
import 'package:reddit_bel_ham/screens/update_email_address_screen.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'change_gender_bottom_sheet.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_segment_tile.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_leading_icon.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_image.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_trailing_icon.dart';
import 'package:reddit_bel_ham/components/text_link.dart';
import '../screens/location_customization.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  static const String id = 'account_settings_screen';

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  String gender = "Male";
  String connectedEmailAddress = "daniel@email.com";
  String username = "dani";
  String location = "Egypt";
  List<bool> notificationsSwitchStates = List.generate(11, (index) => false);
  bool allowPeopleToFollowYou = false;
  bool isConnectedToGoogle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        toolbarHeight: ScreenSizeHandler.bigger * 0.06,
        leading: IconButton(
            key: const Key("account_settings_back_button"),
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
      backgroundColor: kSettingsBackGroundColor,
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
                      key: const Key("update_email_address_tile"),
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
                          context,
                          UpdateEmailAddressScreen.id,
                          arguments: {
                            'email': connectedEmailAddress,
                            'username': username,
                          },
                        );
                      },
                    );
                  },
                ),
                SettingsTile(
                  leadingIcon: const SettingsTileLeadingIcon(
                    leadingIcon: Icons.location_on_outlined,
                  ),
                  titleText: "Location Customization",
                  subtitleText: location,
                  trailingWidget: const SettingsTileTrailingIcon(
                    trailingIcon: Icons.arrow_forward,
                  ),
                  onTap: () async {
                    String newlocation = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationCustomization(
                          initialValue: location,
                        ),
                      ),
                    );
                    setState(() {
                      location = newlocation;
                    });
                  },
                ),
                const SettingsSegmentTitle(
                  titleText: "Connected Accounts",
                ),
                SettingsTile(
                  leadingIcon: const SettingsTileImage(
                    assetImageData: 'assets/images/google_logo.png',
                  ),
                  titleText: "Google",
                  trailingWidget: Text(
                    "Disconnect",
                    style: kSettingsConnectedAccountsTextStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.height *
                          kSettingsTileTextRatio,
                    ),
                    SettingsTile(
                      key: const Key("change_password_tile"),
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: Icons.settings_outlined,
                      ),
                      titleText: "Change Password",
                      trailingWidget: const SettingsTileTrailingIcon(
                        trailingIcon: Icons.arrow_forward,
                      ),
                      onTap: () {

                        Navigator.pushNamed(
                          context,
                          ChangePasswordScreen.id,
                          arguments: {
                            'email': connectedEmailAddress,
                            'username': username,
                          },
                        );
                      },
                    ),
                    SettingsTile(
                      key: const Key("change_gender_tile"),
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
                      key: const Key("location_customization_tile"),
                      subtitleText: location,
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: Icons.location_on_outlined,
                      ),
                      titleText: "Location Customization",
                      trailingWidget: const SettingsTileTrailingIcon(
                        trailingIcon: Icons.arrow_forward,
                      ),
                      onTap: () {
                        //TODO: Implement the location customization functionality
                      },
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
                          ? TextLink(
                              key: const Key("disconnect_google_text_link"),
                              text: "Disconnect",
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  DisconnectScreen.id,
                                  arguments: {
                                    'email': connectedEmailAddress,
                                    'username': username,
                                  },
                                );
                              },
                              fontSizeRatio: ScreenSizeHandler.smaller * 0.035,
                            )
                          : TextLink(
                              key: const Key("connect_google_text_link"),
                              text: "Connect",
                              onTap: () {
                                //TODO: Implement the connect functionality
                              },
                              fontSizeRatio: ScreenSizeHandler.smaller * 0.035,
                            ),
                      onTap: () {},
                    ),
                    const SettingsSegmentTitle(
                      titleText: "Contact Settings",
                    ),
                    SettingsTile(
                      key: const Key("manage_notifications_tile"),
                      leadingIcon: const SettingsTileLeadingIcon(
                        leadingIcon: Icons.notifications_outlined,
                      ),
                      titleText: "Manage Notifications",
                      trailingWidget: const SettingsTileTrailingIcon(
                        trailingIcon: Icons.arrow_forward,
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                            context, NotificationSettingsScreen.id,
                            arguments: notificationsSwitchStates);
                      },
                    ),
                    const SettingsSegmentTitle(
                      titleText: "Blocking and Permissions",
                    ),
                    SettingsTile(
                      key: const Key("manage_blocked_accounts_tile"),
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
                        key: const Key("allow_people_to_follow_you_switch"),
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
    );
  }
}
