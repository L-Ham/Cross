import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'change_gender_bottom_sheet.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_segment_tile.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_leading_icon.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_image.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_trailing_icon.dart';
import '../screens/location_customization.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  String gender = "Male";
  String location = "Egypt";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Center(
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
                  subtitleText: "daniel.gebraiel01@eng-st.cu.edu.eg",
                  onTap: () {},
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
                        context: context,
                        builder: (BuildContext bc) {
                          return ChangeGenderBottomSheet(
                            initialValue: gender,
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
                  ),
                  onTap: () {},
                ),
                SettingsTile(
                  leadingIcon: const SettingsTileImage(
                    assetImageData: 'assets/images/facebook_logo.png',
                  ),
                  titleText: "Facebook",
                  trailingWidget: Text(
                    "Connect",
                    style: kSettingsConnectedAccountsTextStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.height *
                          kSettingsTileTextRatio,
                    ),
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
                  trailingWidget: const SettingsTileTrailingIcon(
                    trailingIcon: Icons.arrow_forward,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
