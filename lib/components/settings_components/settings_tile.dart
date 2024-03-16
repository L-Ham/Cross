import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';

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
                    fontSize: MediaQuery.of(context).size.height *
                        kSettingsTileTextRatio,
                  ),
                ),
                if (subtitleText != null)
                  Text(
                    subtitleText!,
                    style: kSettingsIconTextStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.height *
                          kSettingsTileSubtextRatio,
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
