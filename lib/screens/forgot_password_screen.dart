import 'dart:convert';
import 'package:flutter/material.dart';
import '../utilities/screen_size_handler.dart';
import '../constants.dart';
import '../components/general_components/credentials_text_field.dart';
import '../components/general_components/continue_button.dart';
import '../components/login_components/logo_text_app_bar.dart';
import '../utilities/email_regex.dart';
import 'package:http/http.dart' as http;
import 'check_your_inbox.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String username;
  const ForgotPasswordScreen({Key? key, required this.username})
      : super(key: key);

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
  String _response = '';
  String UesrnameOrEmail = '';

  Future<void> ForgotPasswordRequest(String username) async {
    try {
      final response = await http.post(
        Uri.parse('https://reddit-bylham.me/api/auth/forgotPassword'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjVmNzNlY2Q5OGZlZWIyZmRjNWVjYzkwIiwidHlwZSI6Im5vcm1hbCJ9LCJpYXQiOjE3MTA3OTExNjIsImV4cCI6NTAxNzEwNzkxMTYyfQ.Io0wcsk6LS8juXEJOOdFq7qPvjxFzrN_nrwhbYIMoBQ'
        },
        body: json.encode({"email": username}),
      );
      _response = 'POST Response: ${response.body}';
    } catch (e) {
      _response = 'Error: $e';
    }
  }

  void checkUsernameOrEmail(String value) {
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
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      nameController.text = widget.username;
    });
    checkUsernameOrEmail(widget.username);
  }

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
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      "Sorry we can't help you :(",
                      style: TextStyle(
                          fontSize: ScreenSizeHandler.bigger * 0.027,
                          fontWeight: FontWeight.bold),
                    ),
                    content: const Text('We need someone who can help us!'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
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
                        vertical:
                            ScreenSizeHandler.screenHeight * kButtonHeightRatio,
                        horizontal:
                            ScreenSizeHandler.screenWidth * kButtonWidthRatio,
                      ),
                      child: CredentialsTextField(
                        key: const Key(
                            'forgot_password_screen_email_or_username_text_field'),
                        controller: nameController,
                        isObscure: false,
                        isValid: isNameValid,
                        prefixIcon: (isNameValid && isNameFocused)
                            ? const Icon(Icons.check_rounded,
                                color: Colors.green)
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
                          checkUsernameOrEmail(value);
                        },
                      ),
                    ),
                    Visibility(
                      visible: !isNameValid,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: ScreenSizeHandler.screenWidth *
                                kErrorMessageLeftPaddingRatio),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            errorMessage,
                            style: TextStyle(
                              color: kErrorColor,
                              fontSize: ScreenSizeHandler.smaller *
                                  kErrorMessageSmallerFontRatio,
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
                key: const Key('forgot_password_screen_reset_Password_button'),
                text: "Reset Password",
                isButtonEnabled: isButtonEnabled,
                color: kOrangeActivatedColor,
                onPress: () async {
                  if (isButtonEnabled) {
                    UesrnameOrEmail = nameController.text;
                    await ForgotPasswordRequest(UesrnameOrEmail);

                    if (_response.contains('Email sent')) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckYourInboxScreen(
                                  username: UesrnameOrEmail)));
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: Text(_response),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
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
