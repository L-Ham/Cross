import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';

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
      size: MediaQuery.of(context).size.height * kSettingsTrailingIconRatio,
      color: Colors.white38,
    );
  }
}