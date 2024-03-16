import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';

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
        size: MediaQuery.of(context).size.height * kSettingsLeadingIconRatio,
        color: Colors.white38,
      ),
    );
  }
}