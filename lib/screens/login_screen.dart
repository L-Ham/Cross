import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/screens/signup_screen.dart';
import '../components/acknowledgement_text.dart';
import '../components/text_link.dart';
import '../utilities/screen_size_handler.dart';
import '../constants.dart';
import '../components/credentials_text_field.dart';
import '../components/continue_button.dart';
import 'first_screen.dart';
import '../components/logo_text_app_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isPassObscure = true;
  bool isNameFocused = false;
  bool isPassFocused = false;
  bool isButtonEnabled = false;

  void continueNavigation() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LogoTextAppBar(
            text: 'Sign up',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignupScreen()));
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
                      'Log in',
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
                    ContinueButton(
                      onPress: () {},
                      text: "Continue with Google",
                      icon: Image(
                        image:
                            const AssetImage('assets/images/google_logo.png'),
                        height: ScreenSizeHandler.screenHeight * 0.03,
                        width: ScreenSizeHandler.screenWidth * 0.05,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: ScreenSizeHandler.screenWidth * 0.06,
                          vertical: ScreenSizeHandler.screenHeight * 0.01),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(
                            child: Divider(
                              color: kHintTextColor,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    ScreenSizeHandler.screenWidth * 0.03),
                            child: Text(
                              'OR',
                              style: TextStyle(
                                color: kHintTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenSizeHandler.smaller * 0.025,
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Divider(
                              color: kHintTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
          horizontal: ScreenSizeHandler.screenWidth * 0.04,
          vertical: ScreenSizeHandler.screenHeight * 0.01),
                      child: CredentialsTextField(
                        controller: nameController,
                        isObscure: false,
                        text: 'Email or username',
                        suffixIcon: isNameFocused
                            ? IconButton(
                                icon: const Icon(Icons.clear_rounded),
                                onPressed: () {
                                  setState(() {
                                    nameController.clear();
                                    isNameFocused = false;
                                   isButtonEnabled = false;

                                  });
                                },
                              )
                            : null,
                        isFocused: isNameFocused,
                        onChanged: (value) {
                          setState(() {
                            isNameFocused = value.isNotEmpty;
                            if (value.isNotEmpty &&
                                passController.text.isNotEmpty) {
                              setState(() {
                                isButtonEnabled = true;
                              });
                            } else {
                              setState(() {
                                isButtonEnabled = false;
                              });
                            }
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
          horizontal: ScreenSizeHandler.screenWidth * 0.04,
          vertical: ScreenSizeHandler.screenHeight * 0.01),
                      child: CredentialsTextField(
                        controller: passController,
                        isObscure: isPassObscure,
                        text: 'Password',
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
                            isPassFocused = value.isNotEmpty;
                            if (value.isNotEmpty &&
                                nameController.text.isNotEmpty) {
                              setState(() {
                                isButtonEnabled = true;
                              });
                            } else {
                              setState(() {
                                isButtonEnabled = false;
                              });
                            }
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenSizeHandler.screenWidth * 0.03,
                          vertical: ScreenSizeHandler.screenHeight * 0.01),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextLink(
                            text: 'Forgot your password?',
                            onTap: () {},
                          ),
                        ],
                      ),
                    )
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
                    continueNavigation(); //TODO
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
