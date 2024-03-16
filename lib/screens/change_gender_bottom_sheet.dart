import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_radio_button_tile.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class ChangeGenderBottomSheet extends StatefulWidget {
  const ChangeGenderBottomSheet({super.key, required this.initialValue});

  final String initialValue;

  @override
  State<ChangeGenderBottomSheet> createState() =>
      _ChangeGenderBottomSheetState();
}

class _ChangeGenderBottomSheetState extends State<ChangeGenderBottomSheet> {
  final groupValueNotifier = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    groupValueNotifier.value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kFillingColor,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: ScreenSizeHandler.bigger * 0.02,
                bottom: ScreenSizeHandler.bigger * 0.012,
                left: ScreenSizeHandler.smaller * 0.05,
                right: ScreenSizeHandler.smaller * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: ScreenSizeHandler.smaller * 0.05,
                  ),
                  Text(
                    "Select Gender",
                    style: kPageTitleStyle.copyWith(
                      fontSize: ScreenSizeHandler.bigger * 0.028,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context, groupValueNotifier.value);
                    },
                    child: Text(
                      "Done",
                      style: kSettingsConnectedAccountsTextStyle.copyWith(
                          fontSize: ScreenSizeHandler.bigger * 0.022),
                    ),
                  )
                ],
              ),
            ),
            const Divider(color: Colors.white),
            SettingsRadioButtonTile(
              groupValueNotifier: groupValueNotifier,
              value: "Male",
            ),
            SettingsRadioButtonTile(
              groupValueNotifier: groupValueNotifier,
              value: "Female",
            ),
            SettingsRadioButtonTile(
              groupValueNotifier: groupValueNotifier,
              value: "Others",
            )
          ],
        ),
      ),
    );
  }
}
