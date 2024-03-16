import 'package:flutter/material.dart';
import 'constants.dart';
import 'components/settings_components/settings_tile_trailing_icon.dart';
import 'components/settings_components/settings_segment_tile.dart';
import 'components/settings_components/settings_tile.dart';
import 'components/settings_components/settings_tile_leading_icon.dart';
import 'components/settings_components/settings_tile_image.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String gender = "Farida";

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
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext bc) {
                        return Container(
                          color: kFillingColor,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: const Text(
                                  'Male',
                                  style: TextStyle(color: Colors.white),
                                ),
                                leading: Radio(
                                  activeColor: Colors.white,
                                  value: 'Male',
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value!;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text(
                                  'Female',
                                  style: TextStyle(color: Colors.white),
                                ),
                                leading: Radio(
                                  activeColor: Colors.white,
                                  value: 'Female',
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
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







