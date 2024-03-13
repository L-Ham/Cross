import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'constants.dart';

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
                      fontSize: MediaQuery.of(context).size.width *
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
                      fontSize: MediaQuery.of(context).size.width *
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

class SettingsTileTrailingIcon extends StatelessWidget {
  const SettingsTileTrailingIcon({
    required this.trailingIcon,
    super.key,
  });

  final IconData trailingIcon;

  @override
  Widget build(BuildContext context) {
    return Icon(
      trailingIcon,
      size: MediaQuery.of(context).size.width * 0.075,
      color: Colors.white38,
    );
  }
}

class SettingsSegmentTitle extends StatelessWidget {
  final String titleText;

  const SettingsSegmentTitle({
    required this.titleText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
      child: Text(
        titleText,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.038,
          fontWeight: FontWeight.bold,
          color: Colors.white38,
        ),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final Widget leadingIcon;
  final String titleText;
  final String? subtitleText;
  final Widget trailingWidget;
  final VoidCallback? onTap;

  const SettingsTile({
    Key? key,
    required this.leadingIcon,
    required this.titleText,
    this.subtitleText,
    required this.trailingWidget,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: kFillingColor,
      visualDensity: VisualDensity.compact,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          leadingIcon,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleText,
                  style: kSettingsIconTextStyle.copyWith(
                    fontSize: MediaQuery.of(context).size.width *
                        kSettingsTileTextRatio,
                  ),
                ),
                if (subtitleText != null)
                  Text(
                    subtitleText!,
                    style: kSettingsIconTextStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.width *
                          kSettingsTileTextRatio,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
          trailingWidget
        ],
      ),
      onTap: onTap,
    );
  }
}

class SettingsTileLeadingIcon extends StatelessWidget {
  const SettingsTileLeadingIcon({
    super.key,
    required this.leadingIcon,
  });

  final IconData leadingIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: MediaQuery.of(context).size.width * 0.04,
      ),
      child: Icon(
        leadingIcon,
        size: MediaQuery.of(context).size.width * kSettingsLeadingIconRatio,
        color: Colors.white38,
      ),
    );
  }
}

class SettingsTileImage extends StatelessWidget {
  const SettingsTileImage({
    super.key,
    required this.assetImageData,
  });

  final String assetImageData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: MediaQuery.of(context).size.width * 0.04,
      ),
      child: Image(
        image: AssetImage(
          assetImageData,
        ),
        width: MediaQuery.of(context).size.width * 0.06,
        height: MediaQuery.of(context).size.height * 0.045,
      ),
    );
  }
}
