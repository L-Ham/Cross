import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import 'package:reddit_bel_ham/components/general_components/continue_button.dart';

class AddApprovedUserScreen extends StatefulWidget {
  const AddApprovedUserScreen({super.key});

  static const String id = 'add_approved_user_screen';

  @override
  State<AddApprovedUserScreen> createState() => _AddApprovedUserScreenState();
}

class _AddApprovedUserScreenState extends State<AddApprovedUserScreen> {
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

  Future<void> addApprovedUser() async {
    Map<String, dynamic> response =
        await apiService.addApprovedUser(communityName, _controller.text);
    if (response['message'] == "User approved successfully") {
      if (mounted) {
        setState(() {
          showSnackBar('u/ ${_controller.text} was added');
        });
      }
      Navigator.pop(context);
    } else {
      if (mounted) {
        setState(() {
          showSnackBar('Error: ${response['message']}');
        });
      }
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
          'Add an approved user',
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
                          onTap: () {
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
                        Padding(
                          padding: EdgeInsets.only(
                              top: ScreenSizeHandler.bigger * 0.02),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'This user will be able to submit content to \nyour community',
                              style: kSettingsIconTextStyle.copyWith(
                                fontSize: ScreenSizeHandler.bigger *
                                    kSettingsTileSubtextRatio *
                                    1.1,
                                color: Colors.grey,
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
              Padding(
                  padding: EdgeInsets.only(
                      bottom:
                          ScreenSizeHandler.screenHeight * kButtonWidthRatio),
                  child: ContinueButton(
                    text: 'Add',
                    onPress: () {
                      if (hasText) {
                        addApprovedUser();
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
