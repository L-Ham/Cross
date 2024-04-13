import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/screens/signup_screen.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:reddit_bel_ham/services/auth_service.dart';
import '../components/general_components/acknowledgement_text.dart';
import '../components/general_components/text_link.dart';
import '../utilities/screen_size_handler.dart';
import '../constants.dart';
import '../components/general_components/credentials_text_field.dart';
import '../components/general_components/continue_button.dart';
import '../components/login_components/logo_text_app_bar.dart';
import '../screens/forgot_password_screen.dart';
import '../screens/home_page_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String id = 'login_screen';

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isPassObscure = true;
  bool isNameFocused = false;
  bool isPassFocused = false;
  bool isButtonEnabled = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPrefs();
  }

  void initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> login(String userName, String password) async {
    final url = Uri.parse('https://reddit-bylham.me/api/auth/login');

    final Map<String, dynamic> requestData = {
      'email': userName,
      'userName': userName,
      'password': password,
    };
    late final response;
    String message = 'Login failed.';
    try {
      response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData),
      );
      if (response.statusCode == 200) {
        message='Login successful.';
        var token = jsonDecode(response.body)['token'];
        prefs.setString('token', token);
        TokenDecoder.updateToken(token);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const HomePageScreen()));
      }
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(message),
              content: Text(response.body.toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                )
              ],
            );
          });
    } catch (e) {
      print('Failed to login.');
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Failed to login'),
              content: Text('Please try again later.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LogoTextAppBar(
            key: const Key('login_screen_logo_text_app_bar'),
            text: 'Sign up',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignupScreen()));
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
                        fontSize: ScreenSizeHandler.smaller * 0.07,
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
                      key:
                          const Key('login_screen_continue_with_google_button'),
                      onPress: () {}, // => AuthService().signInWithGoogle(),
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
                        key: const Key(
                            'login_screen_email_or_username_text_field'),
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
                          horizontal:
                              ScreenSizeHandler.screenWidth * kButtonWidthRatio,
                          vertical: ScreenSizeHandler.screenHeight *
                              kButtonHeightRatio),
                      child: CredentialsTextField(
                        key: const Key('login_screen_password_text_field'),
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
                            key: const Key(
                                'login_screen_forgot_password_text_link'),
                            fontSizeRatio: ScreenSizeHandler.smaller *
                                kButtonSmallerFontRatio,
                            text: 'Forgot your password?',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordScreen(
                                              username: nameController.text)));
                            },
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
              Padding(
                padding: EdgeInsets.only(
                    bottom: ScreenSizeHandler.screenHeight * kButtonWidthRatio),
                child: ContinueButton(
                  key: const Key('login_screen_continue_button'),
                  text: "Continue",
                  isButtonEnabled: isButtonEnabled,
                  onPress: () async {
                    if (isButtonEnabled) {
                      login(nameController.text, passController.text);
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
