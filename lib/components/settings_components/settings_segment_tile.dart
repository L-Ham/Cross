import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';

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
        style: kSettingsSegmentTileTextStyle.copyWith(
          fontSize: MediaQuery.of(context).size.height * kSettingsSegmentTextRatio,
        ),
      ),
    );
  }
}
