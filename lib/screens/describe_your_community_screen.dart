import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_save_button.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

class DescribeCommunityScreen extends StatefulWidget {
  // final String subredditID,
  //     membersNickname,
  //     currentlyViewingNickname,
  //     communityDescription;
  // const DescribeCommunityScreen({super.key, required this.subredditID, required this.membersNickname, required this.currentlyViewingNickname, required this.communityDescription});
  const DescribeCommunityScreen({super.key});

  static const String id = 'describe_community_screen';

  @override
  State<DescribeCommunityScreen> createState() =>
      _DescribeCommunityScreenState();
}

class _DescribeCommunityScreenState extends State<DescribeCommunityScreen> {
  ApiService apiService = ApiService(TokenDecoder.token);
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool isButtonEnabled = false;
  String subredditID = '',
      membersNickname = '',
      currentlyViewingNickname = '',
      communityDescription = '';

  @override
  void didChangeDependencies() {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    subredditID = args["subredditID"];
    membersNickname = args["membersNickname"];
    currentlyViewingNickname = args["currentlyViewingNickname"];
    communityDescription = args["communityDescription"];

    _controller.text = communityDescription;
    _focusNode.requestFocus();

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

  Future<void> editCommunityDetails() async {
    Map<String, dynamic> response = await apiService.editCommunityDetails(
        subredditID,
        membersNickname,
        currentlyViewingNickname,
        _controller.text);
    if (response['message'] ==
        "Subreddit's Community Details Edited Successfully") {
      _focusNode.unfocus();
      Navigator.pop(context, _controller.text);
    } else {
      if (mounted) {
        setState(() {
          showSnackBar('Error: ${response['message']}');
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.text = communityDescription;
    _focusNode.requestFocus();
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
              print('tany wahda: description: $communityDescription');
              editCommunityDetails();
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
                return Padding(
                  padding: EdgeInsets.only(
                    top: ScreenSizeHandler.screenHeight * 0.07,
                    bottom: ScreenSizeHandler.screenHeight *
                        kSettingsVerticalPaddingHeightRatio,
                    left: kSettingsHorizontalPaddingHeightRatio *
                        ScreenSizeHandler.screenWidth,
                    right: kSettingsHorizontalPaddingHeightRatio *
                        ScreenSizeHandler.screenWidth,
                  ),
                  child: TextFormField(
                    controller: _controller,
                    focusNode: _focusNode,
                    maxLines: null,
                    maxLength: 500,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      counterStyle: TextStyle(
                        color: kHintTextColor,
                        fontSize:
                            ScreenSizeHandler.smaller * kButtonSmallerFontRatio,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: _controller.text.isEmpty
                          ? 'Describe your community'
                          : '',
                      hintStyle: TextStyle(
                        color: kHintTextColor,
                        fontSize: ScreenSizeHandler.bigger *
                            kButtonSmallerFontRatio *
                            0.85,
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenSizeHandler.bigger *
                          kButtonSmallerFontRatio *
                          0.85,
                    ),
                    onChanged: (value) {
                      setState(() {
                        isButtonEnabled = (value != communityDescription);
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
