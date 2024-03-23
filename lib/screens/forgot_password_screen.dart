import 'package:flutter/material.dart';
import '../utilities/screen_size_handler.dart';
import '../constants.dart';
import '../components/credentials_text_field.dart';
import '../components/continue_button.dart';
import '../components/logo_text_app_bar.dart';
import '../utilities/email_regex.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  static const String id = 'forgot_password_screen';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController nameController = TextEditingController();
  bool isNameFocused = false;
  bool isButtonEnabled = false;
  bool isNameValid = true;
  bool isMailValid = true;
  String errorMessage = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LogoTextAppBar(
            text: 'Help',
            onTap: () {
              // TODO
              // a link that redirects the user to a help center
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
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: ScreenSizeHandler.smaller * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: ScreenSizeHandler.screenHeight * 0.02,
                        horizontal: ScreenSizeHandler.screenWidth * 0.04,
                      ),
                      child: Text(
                        "Enter your email address or username and we'll send you a link to reset your password",
                        style: TextStyle(
                          fontSize: ScreenSizeHandler.smaller * 0.04,
                          color: kHintTextColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: ScreenSizeHandler.screenHeight * 0.01,
                        horizontal: ScreenSizeHandler.screenWidth * 0.04,
                      ),
                      child: CredentialsTextField(
                        controller: nameController,
                        isObscure: false,
                        isValid: isNameValid,
                        prefixIcon: (isNameValid && isNameFocused)
                            ? const Icon(Icons.check_rounded, color: Colors.green)
                            : null,
                        text: 'Email or username',
                        suffixIcon: isNameFocused
                            ? IconButton(
                                icon: const Icon(Icons.clear_rounded),
                                onPressed: () {
                                  setState(() {
                                    nameController.clear();
                                    isNameFocused = false;
                                    isButtonEnabled = false;
                                    isNameValid = true;
                                  });
                                },
                              )
                            : null,
                        isFocused: isNameFocused,
                        onChanged: (value) {
                          setState(() {
                            isNameFocused = value.isNotEmpty;
                            if (value.isEmpty) {
                              setState(() {
                                isButtonEnabled = false;
                                isNameValid = true;
                              });
                            } else {
                              if (value.contains('@')) {
                                isMailValid = isEmailValid(value);
                                if (isMailValid) {
                                  setState(() {
                                    isButtonEnabled = true;
                                    isNameValid = true;
                                  });
                                } else {
                                  setState(() {
                                    isButtonEnabled = false;
                                    isNameValid = false;
                                    errorMessage = "Not a valid email address";
                                  });
                                }
                              } else if (value.length > 2 && value.length < 21) {
                                setState(() {
                                  isButtonEnabled = true;
                                  isNameValid = true;
                                });
                              } else {
                                setState(() {
                                  isButtonEnabled = false;
                                  isNameValid = false;
                                  errorMessage = "There isn't a Reddit account with that username";
                                });
                              }
                            }
                          });
                        },
                      ),
                    ),
                    Visibility(
                      visible: !isNameValid,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: ScreenSizeHandler.smaller * 0.05
                          ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            errorMessage,
                            style: TextStyle(
                              color: Colors.red[200],
                              fontSize: ScreenSizeHandler.smaller * 0.03,
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
              ContinueButton(
                text: "Reset Password",
                isButtonEnabled: isButtonEnabled,
                color: Colors.orange[900],
                onPress: () {
                  if (isButtonEnabled) {
                    // TODO 
                  } else {
                    null;
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
