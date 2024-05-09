import 'dart:async';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:reddit_bel_ham/components/general_components/reddit_loading_indicator.dart';
import 'package:reddit_bel_ham/screens/add_post_screen.dart';
import 'package:reddit_bel_ham/screens/subreddit_screen.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import '../components/create_community_components/community_name_text_box.dart';
import '../components/general_components/continue_button.dart';
import '../components/general_components/custom_switch.dart';
import '../components/create_community_components/community_type_selector.dart';
import '../utilities/screen_size_handler.dart';
import '../constants.dart';
import '../services/api_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  bool isLoading = false;
  late String message;

  Future<void> getValidCommunityName(String communityname) async {
    String token = TokenDecoder.token;
    final url = Uri.parse(
        'https://reddit-bylham.me/api/subreddit/subredditNameAvailability?name=$communityname');
    late final response;
    try {
      response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      String recievedMessage = jsonDecode(response.body)['message'];
      message = '$recievedMessage! Try another';
      print(recievedMessage);
      if (response.statusCode == 200) {
        message = 'Great Name! It\'s not taken, so it\'s all yours.';
      }
      setState(() {
        if (recievedMessage == 'Name already taken') {
          isCommunityNameTaken = true;
        } else {
          isCommunityNameTaken = false;
        }
      });
    } catch (e) {
      print('Error: $e');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  String validateInput(String value) {
    String trimmedValue = value.trim();

    if (trimmedValue.contains(RegExp(r'[^\w\s]')) ||
        trimmedValue.contains(' ') ||
        ((trimmedValue.length < kCommunityNameMinLength) && value.isNotEmpty) ||
        (trimmedValue.isEmpty && value.isNotEmpty)) {
      return 'Community names must be between $kCommunityNameMinLength-$kCommunityNameMaxLength characters, and can only contain letters, numbers, and underscores';
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

  Future<void> createCommunity() async {
    ApiService apiService = ApiService(TokenDecoder.token);
    setState(() {
      isLoading = true;
    });
    //print("Community Created Successfully");
    Map<String, dynamic> data = {
      "name": _controller.text,
      "privacy": communityType,
      "ageRestriction": isSwitched
    };
    Map<String, dynamic> communityData = await apiService.createCommunity(data);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushNamed(context, SubredditScreen.id,
        arguments: _controller.text);
    Navigator.pushNamed(context, AddPostScreen.id, arguments: {
      "subredditName": _controller.text,
      "subredditId": communityData['savedCommunity']["_id"],
      "subredditImage": "assets/images/planet3.png"
    });
    setState(() {
      isLoading = false;
    });
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
                  ScreenSizeHandler.smaller * kButtonSmallerFontRatio * 1.3,
            ),
          ),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        blur: 0,
        opacity: 0,
        progressIndicator: const RedditLoadingIndicator(),
        child: Padding(
          padding: EdgeInsets.all(
              ScreenSizeHandler.screenWidth * kPageEdgesPaddingWidthRatio),
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
                          kAcknowledgeTextSmallerFontRatio,
                    )),
                SizedBox(
                  height: ScreenSizeHandler.screenHeight * 0.01,
                ),
                CommunityNameTextBox(
                  key: const Key('community_name_text_box'),
                  controller: _controller,
                  onChanged: (value) async {
                    await getValidCommunityName(value);
                    if (value.length > kCommunityNameMaxLength) {
                      setState(() {
                        _controller.text =
                            value.substring(0, kCommunityNameMaxLength);
                        _controller.selection = TextSelection.fromPosition(
                            TextPosition(offset: _controller.text.length));
                      });
                    }
                    if (mounted) {
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
                    }
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
                  padding: EdgeInsets.only(
                      top: ScreenSizeHandler.screenHeight * 0.02),
                  child: Text('Community type',
                      style: TextStyle(
                        fontSize: ScreenSizeHandler.smaller *
                            kAcknowledgeTextSmallerFontRatio,
                      )),
                ),
                Semantics(
                  identifier: "community_type_selector",
                  child: CommunityTypeSelector(
                    key: const Key('community_type_selector'),
                    communityType: communityType,
                    onCommunityTypeChanged: (type, description) {
                      setState(() {
                        communityType = type;
                        communityTypeDescription = description;
                      });
                    },
                  ),
                ),
                Text(communityTypeDescription,
                    style: TextStyle(
                      fontSize: ScreenSizeHandler.smaller *
                          kAcknowledgeTextSmallerFontRatio,
                      color: Colors.grey,
                    )),
                SizedBox(height: ScreenSizeHandler.screenHeight * 0.025),
                Row(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: ScreenSizeHandler.screenHeight * 0.02,
                    ),
                    ContinueButton(
                      onPress: () async {
                        if (activated) {
                          try {
                            // Store the values you want to pass to the next screen
                            // String value1 = 'example value 1';
                            // int value2 = 123;
                            await createCommunity();
                          } catch (e) {
                            print('Exception occurred: $e');
                          }
                          //TODO: Navigate to the next screen and pass the values as arguments
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => CreateCommunityScreen(value1: value1, value2: value2),
                          //   ),
                          // );
                        }
                      },
                      key: const Key('create_community_button'),
                      text: 'Create community',
                      color: Colors.blue,
                      isButtonEnabled: activated,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
