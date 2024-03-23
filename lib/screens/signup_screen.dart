
import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/screens/login_screen.dart';
import '../components/acknowledgement_text.dart';
import '../components/text_link.dart';
import '../utilities/screen_size_handler.dart';
import '../constants.dart';
import '../components/credentials_text_field.dart';
import '../components/continue_button.dart';
import 'first_screen.dart';
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



  void continueNavigation() {
  }

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
                    CredentialsTextField(
                      controller: nameController,
                      isObscure: false,
                      text: 'Email',
                      suffixIcon: isNameFocused
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded),
                              onPressed: () {
                                setState(() {
                                  nameController.clear();
                                  isNameFocused = false;
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
                    Visibility(
                      visible: !isNameFocused && isEmailValid(nameController.text),
                      child: Text(
                        'Please enter a valid email address',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: ScreenSizeHandler.smaller * 0.5,
                        ),
                        
                      ),
                    ),
                    CredentialsTextField(
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
