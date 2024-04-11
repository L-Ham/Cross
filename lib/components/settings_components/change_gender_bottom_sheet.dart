import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_radio_button_tile.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

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

  bool isChanged = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kFillingColor,
      child: SingleChildScrollView(
        child: Column(
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
                      fontSize: ScreenSizeHandler.bigger * 0.023,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.pop(context, groupValueNotifier.value);
                      ApiService apiService = ApiService(TokenDecoder.token);
                      apiService.patchGender(groupValueNotifier.value!);
                    },
                    child: Text(
                      "Done",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: ScreenSizeHandler.bigger * 0.0215,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                      key: const Key('change_gender_done_button'),
                    ),
                  )
                ],
              ),
            ),
            const Divider(color: Colors.grey),
            Text(
              "This information may be used to improve your recommendations and ads",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: ScreenSizeHandler.bigger * 0.017),
              textAlign: TextAlign.center,
            ),
            SettingsRadioButtonTile(
              key: const Key('change_gender_Female_radio_button_tile'),
              groupValueNotifier: groupValueNotifier,
              value: "Female",
            ),
            SettingsRadioButtonTile(
              key: const Key('change_gender_Male_radio_button_tile'),
              groupValueNotifier: groupValueNotifier,
              value: "Male",
            ),
            SettingsRadioButtonTile(
              key: const Key(
                  'change_gender_I_prefer_not_to_say_radio_button_tile'),
              groupValueNotifier: groupValueNotifier,
              value: "I prefer not to say",
            ),
          ],
        ),
      ),
    );
  }
}
