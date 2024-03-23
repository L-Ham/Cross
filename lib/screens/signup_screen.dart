import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/screens/login_screen.dart';
import '../components/acknowledgement_text.dart';
import '../utilities/screen_size_handler.dart';
import '../constants.dart';
import '../components/credentials_text_field.dart';
import '../components/continue_button.dart';
import '../components/logo_text_app_bar.dart';
import '../utilities/email_regex.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isPassObscure = true;
  bool isNameFocused = false;
  bool isPassFocused = false;
  bool isButtonEnabled = false;
  bool isValidEmail = true;
  bool isValidPassword = true;

  void continueNavigation() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LogoTextAppBar(
            text: 'Log in',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
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
                          horizontal: ScreenSizeHandler.screenWidth * 0.04,
                          vertical: ScreenSizeHandler.screenHeight * 0.01),
                      child: CredentialsTextField(
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
                                icon: const Icon(
                                  Icons.clear_rounded,
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
                            isNameFocused = value.isNotEmpty;
                            if (value.isNotEmpty &&
                                passController.text.isNotEmpty) {
                              setState(() {
                                isButtonEnabled = true;
                              });
                            } else {
                              if (value.isEmpty) {
                                setState(() {
                                  isValidEmail = true;
                                });
                              }
                              setState(() {
                                isButtonEnabled = false;
                              });
                            }
                          });
                        },
                      ),
                    ),
                    Visibility(
                      visible: !isValidEmail,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: ScreenSizeHandler.smaller * 0.05),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Please enter a valid email address',
                            style: TextStyle(
                              color: Colors.red[200],
                              fontSize: ScreenSizeHandler.smaller * 0.03,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenSizeHandler.screenWidth * 0.04,
                          vertical: ScreenSizeHandler.screenHeight * 0.01),
                      child: CredentialsTextField(
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
                                icon: const Icon(Icons.visibility_rounded),
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
                            if (value.isNotEmpty &&
                                nameController.text.isNotEmpty) {
                              setState(() {
                                isButtonEnabled = true;
                              });
                            } else {
                              if (value.isEmpty) {
                                setState(() {
                                  isValidPassword = true;
                                });
                              }
                              setState(() {
                                isButtonEnabled = false;
                              });
                            }
                          });
                        },
                      ),
                    ),
                    Visibility(
                      visible: !isValidPassword,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: ScreenSizeHandler.smaller * 0.05),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Password must be at least 8 characters',
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
                text: "Continue",
                isButtonEnabled: isButtonEnabled,
                onPress: () {
                  if (isButtonEnabled) {
                    continueNavigation();
                  } else {
                    null;
                  }
                },
                color: Colors.orange[900],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
