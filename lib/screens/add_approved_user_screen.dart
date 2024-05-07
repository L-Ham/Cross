import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import 'package:reddit_bel_ham/components/mod_tools_components/user_tile.dart';
import 'package:reddit_bel_ham/components/mod_tools_components/user_bottom_sheet_tile.dart';
import 'package:reddit_bel_ham/components/general_components/continue_button.dart';

class AddApprovedUserScreen extends StatefulWidget {
  const AddApprovedUserScreen({super.key});

  static const String id = 'add_approved_user_screen';

  @override
  State<AddApprovedUserScreen> createState() => _AddApprovedUserScreenState();
}

class _AddApprovedUserScreenState extends State<AddApprovedUserScreen> {
  ApiService apiService = ApiService(TokenDecoder.token);
  // String username = TokenDecoder.username;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  bool isFocused = false;
  bool hasText = false;

 Future<void> chackUsername (String username) async {
    Map<String, dynamic> response = await apiService.getApprovedUsers("nardoZeh2et");
    if (response['message'] == "Retrieved subreddit Approved Users Successfully") {
      setState(() {
        // approvedUsers = response['approvedMembers'];
      });
    }
    else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(response['message']),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        }, 
      );
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
                        Padding(
                          padding: EdgeInsets.only(
                              top: ScreenSizeHandler.bigger * 0.02),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'This user will be able to submit content to \nyour community',
                              style: kSettingsIconTextStyle.copyWith(
                                fontSize: ScreenSizeHandler.bigger *
                                    kSettingsTileSubtextRatio * 1.1,
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
                        chackUsername(_controller.text);
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
