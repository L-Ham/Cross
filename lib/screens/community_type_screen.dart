import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_save_button.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import '../components/general_components/custom_switch.dart';

class CommunityTypeScreen extends StatefulWidget {
  const CommunityTypeScreen({super.key});

  static const String id = 'community_type_screen';

  @override
  State<CommunityTypeScreen> createState() => _CommunityTypeScreenState();
}

class _CommunityTypeScreenState extends State<CommunityTypeScreen> {
  ApiService apiService = ApiService(TokenDecoder.token);
  bool isButtonEnabled = false;
  double sliderValue = 0;
  bool isSwitched = false;

  // Future<void> editCommunityDetails() async {
  //   Map<String, dynamic> response = await apiService.editCommunityDetails(
  //       subredditID,
  //       membersNickname,
  //       currentlyViewingNickname,
  //       _controller.text);
  //   if (response['message'] ==
  //       "Subreddit's Community Details Edited Successfully") {
  //     _focusNode.unfocus();
  //     Navigator.pop(context);
  //   } else {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Error'),
  //           content: Text(response['message']),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: const Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBackgroundColor,
        actions: [
          SettingsSaveButton(
            onPressed: () {
              //TODO: Implement the save button functionality
              Navigator.pop(context);
            },
            isUnderlined: false,
            isEnabled: isButtonEnabled,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: ScreenSizeHandler.screenHeight *
                            kSettingsVerticalPaddingHeightRatio,
                        horizontal: kSettingsHorizontalPaddingHeightRatio *
                            ScreenSizeHandler.screenWidth,
                      ),
                      child: Column(
                        children: [
                          SliderTheme(
                            data: SliderThemeData(
                              trackHeight: ScreenSizeHandler.smaller * 0.005,
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius:
                                      ScreenSizeHandler.smaller * 0.03),
                              overlayShape: RoundSliderOverlayShape(
                                  overlayRadius:
                                      ScreenSizeHandler.smaller * 0.005),
                              overlayColor: Colors.transparent,
                              inactiveTickMarkColor: kBackgroundColor,
                              activeTickMarkColor: kBackgroundColor,
                              tickMarkShape: RoundSliderTickMarkShape(
                                  tickMarkRadius:
                                      ScreenSizeHandler.smaller * 0.006),
                              thumbColor: sliderValue == 0
                                  ? Colors.greenAccent[400]
                                  : sliderValue == 1
                                      ? Colors.yellow[400]
                                      : Colors.red,
                              activeTrackColor: sliderValue == 0
                                  ? Colors.greenAccent[400]
                                  : sliderValue == 1
                                      ? Colors.yellow[400]
                                      : Colors.red,
                            ),
                            child: Slider(
                              value: sliderValue,
                              onChanged: (double val) {
                                setState(() {
                                  isButtonEnabled = true;
                                  sliderValue = val;
                                });
                              },
                              divisions: 2,
                              min: 0,
                              max: 2,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: ScreenSizeHandler.screenHeight *
                                  kSettingsVerticalPaddingHeightRatio,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                sliderValue == 0
                                    ? 'Public'
                                    : sliderValue == 1
                                        ? 'Restricted'
                                        : 'Private',
                                style: TextStyle(
                                  fontSize: ScreenSizeHandler.smaller *
                                      kButtonSmallerFontRatio *
                                      1.25,
                                  color: sliderValue == 0
                                      ? Colors.greenAccent[400]
                                      : sliderValue == 1
                                          ? Colors.yellow[400]
                                          : Colors.red,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              sliderValue == 0
                                  ? 'Anyone can see and participate in this community.'
                                  : sliderValue == 1
                                      ? 'Anyone can see, join or vote in this community, but ypu control who posts and comments.'
                                      : 'Only people you approve can see and participate in this community.',
                              style: TextStyle(
                                fontSize: ScreenSizeHandler.smaller *
                                    kButtonSmallerFontRatio *
                                    0.8,
                              ),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(
                              vertical: ScreenSizeHandler.screenHeight *
                                  kSettingsVerticalPaddingHeightRatio,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '18+ community',
                                  key: const Key('age_community_text'),
                                  style: TextStyle(
                                    fontSize: ScreenSizeHandler.smaller *
                                        kButtonSmallerFontRatio *
                                        1.15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                CustomSwitch(
                                  key: const Key('age_switch'),
                                  isSwitched: isSwitched,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
