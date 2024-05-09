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
  double sliderValue = 0;
  bool isSwitched = false;
  String communityName = '';
  String privacy = '';
  String initialPrivacy = '';
  bool initialAgeRestriction = false;

  @override
  void didChangeDependencies() {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    communityName = args["communityName"];
    super.didChangeDependencies();
    getCommunityType();
  }

  void showSnackBar(String snackBarText) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(snackBarText),
          backgroundColor: Colors.white,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            left: ScreenSizeHandler.screenWidth * kButtonWidthRatio,
            right: ScreenSizeHandler.screenWidth * kButtonWidthRatio,
            bottom: ScreenSizeHandler.screenHeight * 0.09,
          ),
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      );
    });
  }

  Future<void> getCommunityType() async {
    Map<String, dynamic> response =
        await apiService.getCommunityType(communityName);
    if (response['message'] == "Retrieved subreddit type") {
      if (mounted) {
        setState(() {
          initialPrivacy = response['privacy'];
          initialAgeRestriction = response['ageRestriction'];
          privacy = response['privacy'];
          sliderValue = privacy == 'public'
              ? 0
              : privacy == 'restricted'
                  ? 1
                  : 2;
          isSwitched = response['ageRestriction'];
        });
      }
    } else {
      if (mounted) {
        setState(() {
          showSnackBar('Error: ${response['message']}');
        });
      }
    }
  }

  Future<void> changeCommunityType() async {
    Map<String, dynamic> response = await apiService.changeCommunityType(
        communityName, isSwitched, privacy);
    if (response['message'] == "Subreddit type changed successfully") {
      Navigator.pop(context);
    } else {
      if (mounted) {
        setState(() {
          showSnackBar('Error: ${response['message']}');
        });
      }
    }
  }

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
              changeCommunityType();
            },
            isUnderlined: false,
            isEnabled: (initialPrivacy != privacy ||
                initialAgeRestriction != isSwitched),
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
                                  sliderValue = val;
                                  privacy = sliderValue == 0
                                      ? 'public'
                                      : sliderValue == 1
                                          ? 'restricted'
                                          : 'private';
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
                            padding: EdgeInsets.symmetric(
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
