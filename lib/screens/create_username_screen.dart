import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/screens/about_you_screen.dart';
import 'package:reddit_bel_ham/screens/home_page_screen.dart';
import '../utilities/screen_size_handler.dart';
import '../constants.dart';
import '../components/general_components/credentials_text_field.dart';
import '../components/general_components/continue_button.dart';
import '../components/login_components/logo_text_app_bar.dart';

class CreateUsernameScreen extends StatefulWidget {
  const CreateUsernameScreen({Key? key}) : super(key: key);

  static const String id = 'create_username_screen';

  @override
  CreateUsernameScreenState createState() => CreateUsernameScreenState();
}

class CreateUsernameScreenState extends State<CreateUsernameScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isNameFocused = false;
  bool isButtonEnabled = false;
  bool isValidName = true;
  bool isTaken = false;
  String firstName = 'El_Homar';
  String secondName = 'El_Gamoosa';
  String thirdName = 'Ana_Zhe2t';

  void continueNavigation() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LogoTextAppBar(
            key: const Key(
                'create_username_screen_logo_text_app_bar_login_button'),
            text: '',
            onTap: () {},
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Create your username',
                      style: TextStyle(
                        fontSize: ScreenSizeHandler.smaller * 0.055,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: ScreenSizeHandler.screenHeight * 0.04,
                          top: ScreenSizeHandler.screenHeight * 0.02),
                      child: Text(
                          'Most redditors use an anonymous username. \n You won'
                          't be able to change it later.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: kHintTextColor,
                              fontSize: ScreenSizeHandler.smaller *
                                  kAcknowledgeTextSmallerFontRatio *
                                  1.1)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              ScreenSizeHandler.screenWidth * kButtonWidthRatio,
                          vertical: ScreenSizeHandler.screenHeight *
                              kButtonHeightRatio),
                      child: CredentialsTextField(
                        key: const Key(
                            'create_username_screen_email_text_field'),
                        controller: nameController,
                        isObscure: false,
                        isValid: isValidName,
                        text: 'Username',
                        suffixIcon: isValidName && isNameFocused
                            ? const Icon(
                                Icons.check_rounded,
                                color: Colors.green,
                              )
                            : !isValidName
                                ? Icon(Icons.error, color: Colors.red[200])
                                : null,
                        isFocused: isNameFocused,
                        onChanged: (value) {
                          setState(() {
                            isValidName = value.length >= 3 &&
                                value.length <= 20 &&
                                !value.contains(RegExp(r'[^\w\s-]')) &&
                                !isTaken;
                            isButtonEnabled = isValidName && isNameFocused;
                            isNameFocused = value.isNotEmpty;
                            if (value.isNotEmpty &&
                                passController.text.isNotEmpty) {
                              setState(() {});
                            } else {
                              if (value.isEmpty) {
                                setState(() {
                                  // isValidName = true;
                                });
                              }
                              setState(() {});
                            }
                          });
                        },
                      ),
                    ),
                    Visibility(
                      key: const Key('create_username_screen_email_error_text'),
                      visible: isNameFocused,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: ScreenSizeHandler.screenWidth *
                                kErrorMessageLeftPaddingRatio),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            isTaken
                                ? 'Username already taken! Try another'
                                : nameController.text.length > 20 ||
                                        nameController.text.length < 3
                                    ? 'Your username must be between 3 and 20 characters.'
                                    : nameController.text
                                            .contains(RegExp(r'[^\w\s-]'))
                                        ? 'Your username can only contain letters, numbers, or the special characters - or _'
                                        : 'Great name! It'
                                            's not taken, so it'
                                            's all yours.',
                            style: TextStyle(
                              color: isValidName ? Colors.green : kErrorColor,
                              fontSize: ScreenSizeHandler.smaller *
                                  kErrorMessageSmallerFontRatio,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: ScreenSizeHandler.screenHeight * 0.04,
                            left: ScreenSizeHandler.screenWidth * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Need inspiration? Try these usernames:',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: kHintTextColor,
                                    fontSize: ScreenSizeHandler.smaller *
                                        kAcknowledgeTextSmallerFontRatio *
                                        1.1)),
                            Padding(
                              padding: EdgeInsets.only(
                                top: ScreenSizeHandler.screenHeight * 0.02,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  nameController.text = firstName;
                                  setState(() {
                                    isValidName = true;
                                    isNameFocused = true;
                                    isButtonEnabled = true;
                                  });
                                },
                                child: Text(firstName,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenSizeHandler.smaller *
                                            kAcknowledgeTextSmallerFontRatio *
                                            1.2)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: ScreenSizeHandler.screenHeight * 0.02,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  nameController.text = secondName;
                                  setState(() {
                                    isValidName = true;
                                    isNameFocused = true;
                                    isButtonEnabled = true;
                                  });
                                },
                                child: Text(
                                  secondName,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenSizeHandler.smaller *
                                          kAcknowledgeTextSmallerFontRatio *
                                          1.2),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: ScreenSizeHandler.screenHeight * 0.02,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  nameController.text = thirdName;
                                  setState(() {
                                    isValidName = true;
                                    isNameFocused = true;
                                    isButtonEnabled = true;
                                  });
                                },
                                child: Text(thirdName,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenSizeHandler.smaller *
                                            kAcknowledgeTextSmallerFontRatio *
                                            1.2)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: ScreenSizeHandler.screenHeight * 0.02,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    firstName += 'A';
                                    secondName += 'B';
                                    thirdName += 'C';
                                  });
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ScreenSizeHandler.screenWidth *
                                                  0.02),
                                      child: const Icon(Icons.refresh),
                                    ),
                                    Text('Refresh',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenSizeHandler
                                                    .smaller *
                                                kAcknowledgeTextSmallerFontRatio *
                                                1.2)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: ScreenSizeHandler.screenHeight * kButtonWidthRatio),
                child: ContinueButton(
                  key: const Key('create_username_screen_continue_button'),
                  text: "Continue",
                  isButtonEnabled: isButtonEnabled,
                  onPress: () {
                    if (isButtonEnabled) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AboutYouScreen()));
                    } else {
                      null;
                    }
                  },
                  color: kOrangeActivatedColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
