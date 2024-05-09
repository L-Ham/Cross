import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import 'package:reddit_bel_ham/components/general_components/continue_button.dart';
import 'package:reddit_bel_ham/components/mod_tools_components/rule_broken_item.dart';

class BanUserScreen extends StatefulWidget {
  const BanUserScreen({super.key});

  static const String id = 'ban_user_screen';

  @override
  State<BanUserScreen> createState() => _BanUserScreenState();
}

class _BanUserScreenState extends State<BanUserScreen> {
  ApiService apiService = ApiService(TokenDecoder.token);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ruleController = TextEditingController();
  final TextEditingController _msgController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  bool isFocused = false;
  bool hasText = false;
  bool didChooseReason = false;
  String communityName = '';

  @override
  void initState() {
    super.initState();
    _ruleController.text = 'Select a rule';
  }

  @override
  void didChangeDependencies() {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    communityName = args["communityName"];
    super.didChangeDependencies();
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

  Future<void> banUser() async {
    Map<String, dynamic> response = await apiService.banUser(communityName,
        _nameController.text, _ruleController.text, _noteController.text, true);
    if (response['message'] == "User banned successfully") {
      Navigator.pop(context);
    } else {
      showSnackBar('Error: ${response['message']}');
    }
  }

  void showRules() async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(10.0),
            ),
            child: Container(
              padding: EdgeInsets.only(bottom: ScreenSizeHandler.screenHeight * 0.025),
              color: Colors.grey[900],
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RuleBrokenItem(
                      text: 'Rule broken',
                      onTap: () {},
                      titleFontWeight: FontWeight.bold,
                      icon: IconButton(
                        icon: const Icon(
                          Icons.cancel_outlined,
                          size: kDefaultFontSize * 2,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.grey,
                      ),
                    ),
                    Divider(
                      color: Colors.grey[700],
                    ),
                    RuleBrokenItem(
                      text: 'Spam',
                      onTap: () {
                        setState(() {
                          didChooseReason = true;
                        });
                        _ruleController.text = 'Spam';
                        Navigator.pop(context);
                      },
                    ),
                    RuleBrokenItem(
                      text: 'Personal and confidential information',
                      onTap: () {
                        setState(() {
                          didChooseReason = true;
                        });
                        _ruleController.text =
                            'Personal and confidential information';
                        Navigator.pop(context);
                      },
                    ),
                    RuleBrokenItem(
                      text: 'Threatening, harassing, or inciting violence',
                      onTap: () {
                        setState(() {
                          didChooseReason = true;
                        });
                        _ruleController.text =
                            'Threatening, harassing, or inciting violence';
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
    setState(
      () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Ban user',
          style: TextStyle(
            fontSize: ScreenSizeHandler.bigger * 0.025,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: kBackgroundColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: kSettingsHorizontalPaddingHeightRatio *
                          ScreenSizeHandler.screenWidth,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Username',
                            style: TextStyle(
                              fontSize: ScreenSizeHandler.bigger *
                                  kSettingsTileTextRatio *
                                  1.2,
                              color: kHintTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextField(
                          controller: _nameController,
                          onChanged: (value) => setState(() {
                            hasText = value.isNotEmpty;
                          }),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: kDefaultFontSize * 1.1,
                          ),
                          decoration: InputDecoration(
                            prefixText: 'u/',
                            prefixStyle: const TextStyle(
                              color: kHintTextColor,
                              fontWeight: FontWeight.normal,
                              fontSize: kDefaultFontSize * 1.1,
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: ScreenSizeHandler.smaller * 0.02,
                                horizontal: ScreenSizeHandler.smaller *
                                    0.03), // Decrease this value to reduce height
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            fillColor: kFillingColor,
                            filled: true,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: ScreenSizeHandler.bigger * 0.026),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Rule broken',
                              style: TextStyle(
                                fontSize: ScreenSizeHandler.bigger *
                                    kSettingsTileTextRatio *
                                    1.2,
                                color: kHintTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        TextField(
                          controller: _ruleController,
                          onChanged: (value) => setState(() {}),
                          onTap: () {
                            showRules();
                          },
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: kDefaultFontSize * 1.1,
                          ),
                          readOnly: true,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: kDefaultFontSize * 1.2,
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: ScreenSizeHandler.smaller * 0.02,
                                horizontal: ScreenSizeHandler.smaller * 0.03),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            fillColor: kFillingColor,
                            filled: true,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: ScreenSizeHandler.bigger * 0.002,
                              left: ScreenSizeHandler.bigger * 0.02),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Required',
                              style: kSettingsIconTextStyle.copyWith(
                                fontSize: ScreenSizeHandler.bigger *
                                    kSettingsTileSubtextRatio *
                                    1.1,
                                color: kHintTextColor,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: ScreenSizeHandler.bigger * 0.025),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Ban length',
                              style: TextStyle(
                                fontSize: ScreenSizeHandler.bigger *
                                    kSettingsTileTextRatio *
                                    1.2,
                                color: kHintTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: ScreenSizeHandler.smaller * 0.02,
                                horizontal: ScreenSizeHandler.smaller * 0.03,
                              ),
                              decoration: BoxDecoration(
                                color: kFillingColor,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 0.2,
                                ),
                              ),
                              child: Text(
                                'Permanent',
                                style: TextStyle(
                                  fontSize: ScreenSizeHandler.bigger *
                                      kSettingsTileTextRatio,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenSizeHandler.smaller * 0.02),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: ScreenSizeHandler.smaller * 0.02,
                                  horizontal: ScreenSizeHandler.smaller * 0.03,
                                ),
                                decoration: BoxDecoration(
                                  color: kBackgroundColor,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 0.2,
                                  ),
                                ),
                                child: Text(
                                  'Custom',
                                  style: TextStyle(
                                    fontSize: ScreenSizeHandler.bigger *
                                        kSettingsTileTextRatio,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: ScreenSizeHandler.smaller * 0.05,
                          ),
                          child: TextField(
                            controller: _msgController,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: kDefaultFontSize,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: ScreenSizeHandler.smaller * 0.02,
                                  horizontal: ScreenSizeHandler.smaller * 0.03),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              fillColor: kFillingColor,
                              filled: true,
                              hintText: 'Message to user',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: ScreenSizeHandler.smaller * 0.05,
                          ),
                          child: TextField(
                            controller: _noteController,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: kDefaultFontSize,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: ScreenSizeHandler.smaller * 0.02,
                                  horizontal: ScreenSizeHandler.smaller * 0.03),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              fillColor: kFillingColor,
                              filled: true,
                              hintText: 'Mod note',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: ScreenSizeHandler.bigger * 0.002,
                              left: ScreenSizeHandler.bigger * 0.02),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Only seen by mods',
                              style: kSettingsIconTextStyle.copyWith(
                                fontSize: ScreenSizeHandler.bigger *
                                    kSettingsTileSubtextRatio *
                                    1.1,
                                color: kHintTextColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ));
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Divider(
                color: Colors.grey[700],
              ),
              ContinueButton(
                text: 'Ban',
                onPress: () {
                  if (hasText && didChooseReason) {
                    banUser();
                  }
                },
                isButtonEnabled: hasText && didChooseReason,
                color: hasText && didChooseReason
                    ? const Color.fromARGB(255, 29, 72, 214)
                    : kDisabledButtonColor,
              ),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: ScreenSizeHandler.screenHeight * 0.02),
                  child: ContinueButton(
                    text: 'Cancel',
                    onPress: () {
                      Navigator.pop(context);
                    },
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
