import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/general_components/custom_switch.dart';
import 'package:reddit_bel_ham/components/general_components/interactive_text.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/change_password_screen.dart';
import 'package:reddit_bel_ham/screens/connected_accounts_disconnect_screen.dart';
import 'package:reddit_bel_ham/screens/notifications_settings_screen.dart';
import 'package:reddit_bel_ham/screens/update_email_address_screen.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import '../components/general_components/reddit_loading_indicator.dart';
import '../components/settings_components/change_gender_bottom_sheet.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_segment_tile.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_leading_icon.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_image.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_trailing_icon.dart';
import 'package:reddit_bel_ham/screens/location_customization.dart';
import 'package:reddit_bel_ham/screens/blocked_accounts.dart';
import 'package:reddit_bel_ham/services/api_service.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  static const String id = 'account_settings_screen';

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  ApiService apiService = ApiService(TokenDecoder.token);
  String gender = "Man";
  String connectedEmailAddress = "daniel@email.com";
  String username = "dani";
  String location = "Egypt";
  bool allowPeopleToFollowYou = false;
  bool isConnectedToGoogle = true;
  bool isLoading = true;
  Map<String, dynamic> profileSettings = {};
  Map<String, dynamic> recievedLocation = {};

  Future<void> getUserData() async {
    Map<String, dynamic> data = await apiService.getUserAccountSettings();
    profileSettings = await apiService.getProfileSettings();
    recievedLocation = await apiService.getUserLocation();
    setState(() {
      gender = data['accountSettings']['gender'];
      connectedEmailAddress = data['accountSettings']['email'];
      //connectedEmailAddress = data['accountSettings']['email'];
      isConnectedToGoogle = data['accountSettings']['connectedToGoogle'];
      allowPeopleToFollowYou =
          profileSettings['profileSettings']['allowFollow'];
      isLoading = false;
      username = TokenDecoder.username;
      location = recievedLocation['location'];
      gender = gender == "" ? "Select" : gender;
    });
  }

  Future<void> editLocation(String location) async {
    await apiService.editLocation(location);
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        toolbarHeight: ScreenSizeHandler.bigger * 0.055,
        leading: IconButton(
            key: const Key("account_settings_back_button"),
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Account Settings",
          style: kPageTitleStyle.copyWith(
              fontSize:
                  ScreenSizeHandler.smaller * kAppBarTitleSmallerFontRatio),
        ),
        centerTitle: true,
      ),
      backgroundColor: kSettingsBackGroundColor,
      body: isLoading
          ? const RedditLoadingIndicator()
          : SafeArea(
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
                                titleText: "Basic Settings"),
                          ),
                          SettingsTile(
                            key: const Key(
                                "account_settings_update_email_address_tile"),
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
                          ),
                          SettingsTile(
                            key: const Key(
                                "account_settings_change_password_tile"),
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
                            key: const Key(
                                "account_settings_change_gender_tile"),
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
                                  backgroundColor:
                                      kBackgroundColor.withOpacity(0),
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
                            key: const Key(
                                "account_settings_location_customization_tile"),
                            leadingIcon: const SettingsTileLeadingIcon(
                              leadingIcon: Icons.location_on_outlined,
                            ),
                            titleText: "Location Customization",
                            subtitleText:
                                "\n$location\n\nSpecify a location to customize your recommendations and feed. Reddit does not track your precise geolocation data.",
                            trailingWidget: const SettingsTileTrailingIcon(
                              trailingIcon: Icons.arrow_forward,
                            ),
                            onTap: () async {
                              String? newLocation = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LocationCustomization(
                                    initialValue: location,
                                  ),
                                ),
                              );
                              if (newLocation != null) {
                                setState(() {
                                  location = newLocation;
                                  editLocation(location);
                                });
                              }
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
                                ? InteractiveText(
                                    key: const Key(
                                        "account_settings_disconnect_google_text_link"),
                                    text: "Disconnect",
                                    isUnderlined: true,
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
                                    fontSizeRatio: 0.018,
                                  )
                                : InteractiveText(
                                    key: const Key(
                                        "account_settings_connect_google_text_link"),
                                    text: "Connect",
                                    isUnderlined: true,
                                    onTap: () {
                                      //TODO: Implement the connect functionality
                                      Navigator.pushNamed(
                                        context,
                                        DisconnectScreen.id,
                                        arguments: {
                                          'email': connectedEmailAddress,
                                          'username': username,
                                        },
                                      );
                                    },
                                    fontSizeRatio: 0.018,
                                  ),
                            onTap: () {},
                          ),
                          const SettingsSegmentTitle(
                            titleText: "Contact Settings",
                          ),
                          SettingsTile(
                            key: const Key(
                                "account_settings_manage_notifications_tile"),
                            leadingIcon: const SettingsTileLeadingIcon(
                              leadingIcon: Icons.notifications_outlined,
                            ),
                            titleText: "Manage Notifications",
                            trailingWidget: const SettingsTileTrailingIcon(
                              trailingIcon: Icons.arrow_forward,
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                NotificationSettingsScreen.id,
                              );
                            },
                          ),
                          const SettingsSegmentTitle(
                            titleText: "Blocking and Permissions",
                          ),
                          SettingsTile(
                            key: const Key(
                                "account_settings_manage_blocked_accounts_tile"),
                            leadingIcon: const SettingsTileLeadingIcon(
                              leadingIcon: Icons.block_outlined,
                            ),
                            titleText: "Manage Blocked Accounts",
                            trailingWidget: const SettingsTileTrailingIcon(
                              trailingIcon: Icons.arrow_forward,
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, BlockedAccount.id);
                            },
                          ),
                          SettingsTile(
                            leadingIcon: const SettingsTileLeadingIcon(
                              leadingIcon: Icons.people,
                            ),
                            titleText: "Allow People to Follow You",
                            subtitleText:
                                "Followers will be notified about posts you make to your profile and see them in their home feed.",
                            trailingWidget: CustomSwitch(
                              key: const Key(
                                  "account_settings_allow_people_to_follow_you_switch"),
                              isSwitched: allowPeopleToFollowYou,
                              onChanged: (value) {
                                setState(() {
                                  allowPeopleToFollowYou =
                                      !allowPeopleToFollowYou;
                                });
                                profileSettings['profileSettings']
                                    ['allowFollow'] = allowPeopleToFollowYou;
                                apiService
                                    .patchProfileSettings(profileSettings);
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
