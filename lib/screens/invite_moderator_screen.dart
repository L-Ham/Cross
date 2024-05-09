import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import 'package:reddit_bel_ham/components/general_components/continue_button.dart';

class InviteModeratorScreen extends StatefulWidget {
  const InviteModeratorScreen({super.key});

  static const String id = 'invite_moderator_screen';

  @override
  State<InviteModeratorScreen> createState() => _InviteModeratorScreenState();
}

class _InviteModeratorScreenState extends State<InviteModeratorScreen> {
  ApiService apiService = ApiService(TokenDecoder.token);
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  bool isFocused = false;
  bool hasText = false;
  String communityName = '';


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


   Future<void> inviteModerator() async {
    Map<String, dynamic> response = await apiService.inviteModerator(communityName, _controller.text);
    if (response['message'] == "Moderator invited successfully") {
      showSnackBar('u/ ${_controller.text} was added as a moderator');
      Navigator.pop(context);
    } else {
      showSnackBar('Error: ${response['message']}');
      _focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add a moderator',
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
                        TextFormField(
                          controller: _controller,
                          focusNode: _focusNode,
                          cursorColor: Colors.white,
                          style: kSettingsIconTextStyle.copyWith(
                            fontSize: ScreenSizeHandler.bigger *
                                kSettingsTileTextRatio *
                                1.2,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                          onTap: (){
                            setState(() {
                              isFocused = true;
                            });
                          
                          },
                          onChanged: (value) => setState(() {
                            hasText = value.isNotEmpty;
                          }),
                          decoration: InputDecoration(
                            prefixText: (isFocused || hasText) ? 'u/' : '',
                            label: Row(
                              children: [
                                Text(
                                  'Username',
                                  style: kSettingsIconTextStyle.copyWith(
                                    fontSize: ScreenSizeHandler.bigger *
                                        kSettingsTileTextRatio *
                                        1.3,
                                    color: kHintTextColor,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  '*',
                                  style: TextStyle(
                                    fontSize: ScreenSizeHandler.bigger *
                                        kSettingsTileTextRatio *
                                        1.3,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  );
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      bottom:
                          ScreenSizeHandler.screenHeight * kButtonWidthRatio),
                  child: ContinueButton(
                    text: 'Add',
                    onPress: () {
                      if (hasText) {
                        inviteModerator();
                      }
                    },
                    isButtonEnabled: hasText,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
