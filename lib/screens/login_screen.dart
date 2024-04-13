import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:reddit_bel_ham/components/general_components/reddit_loading_indicator.dart';
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
import 'package:reddit_bel_ham/services/google_sign_in.dart';

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
  bool isLoading = false;
  final _focusNode = FocusNode();
  final _focusNode2 = FocusNode();



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
      message = jsonDecode(response.body)['message'];
      if (response.statusCode == 200) {
        message = 'Login successful.';
        var token = jsonDecode(response.body)['token'];
        prefs.setString('token', token);
        TokenDecoder.updateToken(token);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomePageScreen()));
      }
      else
      {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
            bottom: ScreenSizeHandler.screenHeight * 0.12,
            left: ScreenSizeHandler.screenWidth * 0.04,
            right: ScreenSizeHandler.screenWidth * 0.04),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        content: Center(child: Text(message)),
        duration: const Duration(seconds: 3),
      ));
      }
    } catch (e) {
      print(e);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
            bottom: ScreenSizeHandler.screenHeight * 0.12,
            left: ScreenSizeHandler.screenWidth * 0.04,
            right: ScreenSizeHandler.screenWidth * 0.04),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        content: Center(child: Text(message)),
        duration: const Duration(seconds: 3),
      ));
    } 
    finally {
      setState(() {
        isLoading = false;
      });

    }
  }

  Future<void> loginWithGoogle(String token) async {
    // await AuthService().signOutWithGoogle();
    print(token);
    final url = Uri.parse('https://reddit-bylham.me/api/auth/googleLogin');

    final Map<String, dynamic> requestData = {'token': token};
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
      message = jsonDecode(response.body)['message'];
      if (response.statusCode == 200) {
        message = 'Login successful.';
        var token = jsonDecode(response.body)['token'];
        prefs.setString('token', token);
        TokenDecoder.updateToken(token);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePageScreen()));
      }
      else 
      {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
            bottom: ScreenSizeHandler.screenHeight * 0.12,
            left: ScreenSizeHandler.screenWidth * 0.04,
            right: ScreenSizeHandler.screenWidth * 0.04),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        content: Center(child: Text(message)),
        duration: const Duration(seconds: 3),
      ));
      }
    } catch (e) {
      print(e);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
            bottom: ScreenSizeHandler.screenHeight * 0.12,
            left: ScreenSizeHandler.screenWidth * 0.04,
            right: ScreenSizeHandler.screenWidth * 0.04),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        content: Center(child: Text(message)),
        duration: const Duration(seconds: 3),
      ));
    } finally {
      setState(() {
        isLoading = false;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: const RedditLoadingIndicator(),
      blur: 0,
      opacity: 0,
      offset: Offset(ScreenSizeHandler.screenWidth * 0.38,
          ScreenSizeHandler.screenHeight * 0.6),
      child: Scaffold(
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
                        key: const Key(
                            'login_screen_continue_with_google_button'),
                        onPress: () async {
                          setState(() {
                            isLoading = true;
                          });
                          var check = await AuthService().signInWithGoogle();
                          if (check == null) {
                            setState(() {
                              isLoading = false;
                            });
                            return;
                          } else {
                            loginWithGoogle(check);
                          }
                        },
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
                          focusNode: _focusNode,
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
                            horizontal: ScreenSizeHandler.screenWidth *
                                kButtonWidthRatio,
                            vertical: ScreenSizeHandler.screenHeight *
                                kButtonHeightRatio),
                        child: CredentialsTextField(
                          focusNode: _focusNode2,
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
                                                username:
                                                    nameController.text)));
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
                      bottom:
                          ScreenSizeHandler.screenHeight * kButtonWidthRatio),
                  child: ContinueButton(
                    key: const Key('login_screen_continue_button'),
                    text: "Continue",
                    isButtonEnabled: isButtonEnabled,
                    onPress: () async {
                      if (isButtonEnabled) {
                        setState(() {
                          isLoading = true;
                          _focusNode.unfocus();
                          _focusNode2.unfocus();
                        });
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
      ),
    );
  }
}
