import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class SettingsTile extends StatelessWidget {
  final Widget leadingIcon;
  final String titleText;
  final String? subtitleText;
  final Widget? trailingWidget;
  final VoidCallback? onTap;

  const SettingsTile({
    Key? key,
    required this.leadingIcon,
    required this.titleText,
    this.subtitleText,
    this.trailingWidget,
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
                    fontSize: ScreenSizeHandler.bigger *
                        kSettingsTileTextRatio,
                  ),
                ),
                if (subtitleText != null)
                  Text(
                    subtitleText!,
                    style: kSettingsIconTextStyle.copyWith(
                      fontSize: ScreenSizeHandler.bigger *
                          kSettingsTileSubtextRatio,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
          if (trailingWidget != null) trailingWidget !,
        ],
      ),
      onTap: onTap,
    );
  }
}
