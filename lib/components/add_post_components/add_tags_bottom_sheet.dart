import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../utilities/screen_size_handler.dart';
import '../general_components/custom_switch.dart';
import '../settings_components/settings_tile.dart';
import '../settings_components/settings_tile_leading_icon.dart';
import 'icon_button_with_caption.dart';

class AddTagsBottomSheet extends StatefulWidget {
  const AddTagsBottomSheet(
      {super.key,
      required this.isSpoiler,
      required this.isBrandAffiliate,
      required this.setIsSpoiler,
      required this.setIsBrandAffiliate});

  final bool isSpoiler;
  final bool isBrandAffiliate;
  final Function(bool) setIsSpoiler;
  final Function(bool) setIsBrandAffiliate;

  @override
  State<AddTagsBottomSheet> createState() => _AddTagsBottomSheetState();
}

class _AddTagsBottomSheetState extends State<AddTagsBottomSheet> {
  bool isSpoiler = false;
  bool isBrandAffiliate = false;

  @override
  void initState() {
    super.initState();
    isSpoiler = widget.isSpoiler;
    isBrandAffiliate = widget.isBrandAffiliate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenSizeHandler.screenWidth * 0.05),
            child: Padding(
              padding: EdgeInsets.only(
                  top: ScreenSizeHandler.screenHeight * 0.015,
                  bottom: ScreenSizeHandler.screenHeight * 0.017),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add tags',
                    style: TextStyle(
                        fontSize: ScreenSizeHandler.bigger * 0.02,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButtonWithCaption(
                    icon: Icons.clear,
                    onTap: () {
                      Navigator.pop(
                        context,
                        {
                          'isSpoiler': isSpoiler,
                          'isBrandAffiliate': isBrandAffiliate
                        },
                      );
                    },
                    backgroundColor: kFillingColor,
                    iconRadiusRatio: 0.018,
                    isIconEnabled: true,
                    hasCaption: false,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenSizeHandler.screenWidth * 0.05),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text('Universal tags'),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: ScreenSizeHandler.screenHeight * 0.007,
                bottom: ScreenSizeHandler.screenHeight * 0.01),
            child: SettingsTile(
              leadingIcon:
                  const SettingsTileLeadingIcon(leadingIcon: Icons.warning),
              titleText: "Spoiler",
              subtitleText: "Tag posts that may ruin a surprise",
              titleFontWeight: FontWeight.w400,
              subtitileFontWeight: FontWeight.w400,
              trailingWidget: CustomSwitch(
                key: const Key('spoiler_switch'),
                isSwitched: isSpoiler,
                onChanged: (bool newValue) {
                  setState(() {
                    isSpoiler = newValue;
                    widget.setIsSpoiler(newValue);
                  });
                },
              ),
            ),
          ),
          SettingsTile(
            leadingIcon:
                const SettingsTileLeadingIcon(leadingIcon: Icons.waves),
            titleText: "Brand affiliate",
            subtitleText: "Made for a brand or business",
            titleFontWeight: FontWeight.w400,
            subtitileFontWeight: FontWeight.w400,
            trailingWidget: CustomSwitch(
              key: const Key('brand_affiliate_switch'),
                isSwitched: isBrandAffiliate,
                onChanged: (bool newValue) {
                  setState(() {
                    isBrandAffiliate = newValue;
                    widget.setIsBrandAffiliate(newValue);
                  });
                }),
          )
        ],
      ),
    );
  }
}
