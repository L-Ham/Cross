import 'dart:async';
import 'package:flutter/material.dart';
import '../components/create_community_components/community_name_text_box.dart';
import '../components/general_components/continue_button.dart';
import '../components/general_components/custom_switch.dart';
import '../components/create_community_components/community_type_selector.dart';
import '../utilities/screen_size_handler.dart';
import '../constants.dart';

class CreateCommunityScreen extends StatefulWidget {
  const CreateCommunityScreen({Key? key}) : super(key: key);

  static const String id = 'create_community_screen';

  @override
  _CreateCommunityScreenState createState() => _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends State<CreateCommunityScreen> {
  final TextEditingController _controller = TextEditingController();
  String communityType = 'Public';
  String communityTypeDescription =
      'Anyone can view, post and comment to this community';
  bool isSwitched = false;
  bool activated = false;
  bool isCommunityNameTaken = false;
  String errorText = '';

  String validateInput(String value) {
    String trimmedValue = value.trim();

    if (trimmedValue.contains(RegExp(r'[^\w\s]')) ||
        trimmedValue.contains(' ') ||
        ((trimmedValue.length < kCommunityNameMinLength) && value.isNotEmpty) ||
        (trimmedValue.isEmpty && value.isNotEmpty)) {
      return 'Community names must be be tween $kCommunityNameMinLength-$kCommunityNameMaxLength characters, and can only contain letters, numbers, and underscores';
    }
    //Check if the community name is already taken (LATER IMPLEMENTATION)
    if (trimmedValue == 'toto') {
      isCommunityNameTaken = true;
    } else {
      isCommunityNameTaken = false;
    }
    if (value.length >= kCommunityNameMinLength && isCommunityNameTaken) {
      return 'This community name is already taken';
    }
    if (value.isEmpty ||
        (value.length >= kCommunityNameMinLength && !isCommunityNameTaken)) {
      return '';
    }
    return '';
  }

  void createCommunity() {
    print('Community created');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(
              top: ScreenSizeHandler.screenHeight *
                  kPageTtleTopBottomPaddingRatio,
              bottom: ScreenSizeHandler.screenHeight *
                  kPageTtleTopBottomPaddingRatio),
          child: Text(
            'Create a community',
            style: kPageTitleStyle.copyWith(
              fontSize:
                  ScreenSizeHandler.bigger * kPageTitleFontSizeHeightRatio,
            ),
          ),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(kPageEdgesPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: ScreenSizeHandler.screenHeight * 0.005,
              ),
              Text('Community name',
                  key: const Key('community_name_text'),
                  style: TextStyle(
                    fontSize: ScreenSizeHandler.smaller *
                        kAcknowledgeTextWidthRatio,
                  )),
              SizedBox(
                height: ScreenSizeHandler.screenHeight * 0.01,
              ),
              CommunityNameTextBox(
                key: const Key('community_name_text_box'),
                controller: _controller,
                onChanged: (value) {
                  if (value.length > kCommunityNameMaxLength) {
                    setState(() {
                      _controller.text =
                          value.substring(0, kCommunityNameMaxLength);
                      _controller.selection = TextSelection.fromPosition(
                          TextPosition(offset: _controller.text.length));
                    });
                  }

                  Future.delayed(
                      const Duration(
                          milliseconds: kErrorDisplayDelayTimeMilliseconds),
                      () {
                    setState(
                      () {
                        errorText = validateInput(value);
                        if (errorText == 'Empty') {
                          errorText = '';
                          activated = false;
                        } else if (value.length >= kCommunityNameMinLength &&
                            errorText == '') {
                          activated = true;
                        } else {
                          activated = false;
                        }
                      },
                    );
                  });
                },
                onClear: () {
                  setState(() {
                    _controller.clear();
                    activated = false;
                  });
                },
              ),
              Visibility(
                visible: errorText.isNotEmpty,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: kErrorTextTopBottomPadding),
                  child: Text(
                    errorText,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize:
                          ScreenSizeHandler.bigger * kErrorTextHeightRatio,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: ScreenSizeHandler.screenHeight * 0.02),
                child: Text('Community type',
                    style: TextStyle(
                      fontSize: ScreenSizeHandler.bigger *
                          kPageSubtitleFontSizeHeightRatio,
                    )),
              ),
              CommunityTypeSelector(
                key: const Key('community_type_selector'),
                communityType: communityType,
                onCommunityTypeChanged: (type, description) {
                  setState(() {
                    communityType = type;
                    communityTypeDescription = description;
                  });
                },
              ),
              Text(communityTypeDescription,
                  style: TextStyle(
                    fontSize: ScreenSizeHandler.bigger *
                        kCommunityTypeDescriptionHeightRatio,
                    color: Colors.grey,
                  )),
              SizedBox(height: ScreenSizeHandler.screenHeight * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '18+ community',
                    key: const Key('age_community_text'),
                    style: TextStyle(
                      fontSize: ScreenSizeHandler.smaller *
                          kButtonSmallerFontRatio,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: ScreenSizeHandler.screenHeight * 0.02,
                  ),
                  ContinueButton(
                      onPress: () {},
                      key: const Key('create_community_button'),
                      text: 'Create community',
                      color: Colors.blue,
                      isButtonEnabled: activated),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
