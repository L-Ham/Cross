import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/screens/create_username_screen.dart';
import 'package:reddit_bel_ham/screens/home_page_screen.dart';
import 'package:reddit_bel_ham/screens/login_screen.dart';
import '../components/general_components/acknowledgement_text.dart';
import '../utilities/screen_size_handler.dart';
import '../constants.dart';
import '../components/general_components/credentials_text_field.dart';
import '../components/general_components/continue_button.dart';
import '../components/login_components/logo_text_app_bar.dart';
import '../utilities/email_regex.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  static const String id = 'signup_screen';

  @override
  SignupScreenState createState() => SignupScreenState();
}


class SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isPassObscure = true;
  bool isNameFocused = false;
  bool isPassFocused = false;
  bool isButtonEnabled = false;
  bool isValidEmail = true;
  bool isValidPassword = true;
  final _focusNode = FocusNode();
  final _focusNode2 = FocusNode();

  void continueNavigation() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LogoTextAppBar(
            key: const Key('signup_screen_logo_text_app_bar_login_button'),
            text: 'Log in',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Hi new friend,\nWelcome to Reddit byLham!',
                      style: TextStyle(
                        fontSize: ScreenSizeHandler.smaller * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: ScreenSizeHandler.screenHeight * 0.02,
                      ),
                      child: const AcknowledgementText(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenSizeHandler.screenWidth * kButtonWidthRatio,
                          vertical: ScreenSizeHandler.screenHeight * kButtonHeightRatio),
                      child: CredentialsTextField(
                        focusNode: _focusNode,
                        key: const Key('signup_screen_email_text_field'),
                        controller: nameController,
                        isObscure: false,
                        isValid: isValidEmail,
                        text: 'Email',
                        prefixIcon: isValidEmail && isNameFocused
                            ?const Icon(
                                  Icons.check_rounded,
                                  color: Colors.green,
                                )
                            : null,
                        suffixIcon: isNameFocused
                            ? IconButton(
                                icon: Semantics(
                                  identifier: 'signup_screen_email_clear_button',
                                  child: const Icon(
                                    Icons.clear_rounded,
                                  ),
                                ),
                                onPressed: () {
                                  nameController.clear();
                                  setState(() {
                                    isButtonEnabled = false;
                                    isNameFocused = false;
                                    isValidEmail = true;
                                  });
                                },
                              )
                            : null,
                        isFocused: isNameFocused,
                        onChanged: (value) {
                          setState(() {
                            isValidEmail = isEmailValid(value);
                            isButtonEnabled = isValidEmail && isValidPassword && isPassFocused && isNameFocused;
                            isNameFocused = value.isNotEmpty;
                            if (value.isNotEmpty &&
                                passController.text.isNotEmpty) {
                              setState(() {
                              });
                            } else {
                              if (value.isEmpty) {
                                setState(() {
                                  isValidEmail = true;
                                });
                              }
                              setState(() {

                              });
                            }
                          });
                        },
                      ),
                    ),
                    Visibility(
                      key: const Key('signup_screen_email_error_text'),
                      visible: !isValidEmail,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: ScreenSizeHandler.screenWidth * kErrorMessageLeftPaddingRatio),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Please enter a valid email address',
                            style: TextStyle(
                              color: kErrorColor,
                              fontSize: ScreenSizeHandler.smaller * kErrorMessageSmallerFontRatio,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenSizeHandler.screenWidth * kButtonWidthRatio,
                          vertical: ScreenSizeHandler.screenHeight * kButtonHeightRatio),
                      child: CredentialsTextField(
                        focusNode: _focusNode2,
                        key: const Key('signup_screen_password_text_field'),
                        controller: passController,
                        isObscure: isPassObscure,
                        isValid: isValidPassword,
                        text: 'Password',
                    prefixIcon: isValidPassword && isPassFocused
                            ? const Icon(
                                  Icons.check_rounded,
                                  color: Colors.green,
                                )
                            : null,
                        suffixIcon: isPassFocused
                            ? IconButton(
                                icon: Semantics(
                                  identifier: 'signup_screen_password_visibility_button',
                                  child: const Icon(Icons.visibility_rounded)),
                                onPressed: () {
                                  setState(() {
                                    isPassObscure = !isPassObscure;
                                  });
                                },
                              )
                            : null,
                        isFocused: isPassFocused,
                        onChanged: (value) {
                          setState(() {
                            isValidPassword = value.length >= 8;
                            isPassFocused = value.isNotEmpty;
                            isButtonEnabled = isValidEmail && isValidPassword && isPassFocused && isNameFocused;
                            if (value.isNotEmpty &&
                                nameController.text.isNotEmpty) {
                              setState(() {
                              });
                            } else {
                              if (value.isEmpty) {
                                setState(() {
                                  // isValidPassword = true;
                                });
                              }
                              setState(() {
                              });
                            }
                          });
                        },
                      ),
                    ),
                    Visibility(
                      key: const Key('signup_screen_password_error_text'),
                      visible: !isValidPassword || isPassFocused,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: ScreenSizeHandler.screenWidth * kErrorMessageLeftPaddingRatio),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Password must be at least 8 characters',
                            style: TextStyle(
                              color: isValidPassword? Colors.green: kErrorColor,
                              fontSize: ScreenSizeHandler.smaller * kErrorMessageSmallerFontRatio,
                            ),
                          ),
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
                padding: EdgeInsets.only(bottom: ScreenSizeHandler.screenHeight * kButtonWidthRatio),
                child: ContinueButton(
                  key: const Key('signup_screen_continue_button'),
                  text: "Continue",
                  isButtonEnabled: isButtonEnabled,
                  onPress: () {
                    if (isButtonEnabled) {
                      _focusNode.unfocus();
                      _focusNode2.unfocus();
                      Navigator.pushNamed(context,CreateUsernameScreen.id, arguments: {'email': nameController.text, 'password': passController.text, 'username': ''});
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
