import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/screens/signup_screen.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import '../screens/login_screen.dart';
import '../constants.dart';
import '../components/general_components/continue_button.dart';
import '../components/general_components/acknowledgement_text.dart';
import '../components/general_components/text_link.dart';
import '../utilities/screen_size_handler.dart';
import '../services/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_page_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
class FirstScreen extends StatefulWidget {
  const FirstScreen({
    super.key,
  });

  static const String id = 'first_screen';

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
    late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPrefs();
  }

  void initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> signUpWithGoogle(
    String token) async {
    print(token);
    final url = Uri.parse('https://reddit-bylham.me/api/auth/googleSignUp');

    final Map<String, dynamic> requestData = {
      'token': token
    };
    late final response;
    String message='Signup failed.';
    try {
      response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData),
      );
      if (response.statusCode == 200) {
        message='Signup successful.';
        var token = jsonDecode(response.body)['token'];
        prefs.setString('token', token);
        TokenDecoder.updateToken(token);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePageScreen()));
      }
      showDialog(context: context, builder:
          (BuildContext context) {
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
      print('Failed to signup.');
      showDialog(context: context, builder:
          (BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenSizeHandler.screenHeight * 0.06),
                    child: Hero(
                      tag: 'logo',
                      child: Image(
                        key: const Key('first_screen_logo_image'),
                        image: const AssetImage(
                            'assets/images/elham_final_logo.png'),
                        height: ScreenSizeHandler.screenHeight * 0.2,
                        width: ScreenSizeHandler.screenWidth * 0.3,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenSizeHandler.screenWidth * kButtonWidthRatio,
                          vertical: ScreenSizeHandler.screenHeight * kButtonHeightRatio),
                      child: Text(
                        'Reddit byLham\n والهم مش راضي بينا',
                        style: TextStyle(
                          fontSize: ScreenSizeHandler.smaller * 0.08,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenSizeHandler.screenHeight * 0.15,
                  ),
                  ContinueButton(
                    key: const Key('first_screen_continue_with_google_button'),
                    onPress: () async{
                      if (FirebaseAuth.instance.currentUser != null) {
                        await AuthService().signOutWithGoogle();
                      }
                      var check=await AuthService().signInWithGoogle();
                      if (check == null) {
                        return;
                      }
                      else {
                      signUpWithGoogle(check);
                      }
                      
                    },
                    text: "Continue with Google",
                    icon: Image(
                      image: const AssetImage('assets/images/google_logo.png'),
                      height: ScreenSizeHandler.screenHeight * 0.03,
                      width: ScreenSizeHandler.screenWidth * 0.05,
                    ),
                  ),
                  ContinueButton(
                    key: const Key('first_screen_continue_with_email_button'),
                    text: "Continue with Email",
                    icon: const Icon(Icons.email),
                    onPress: () {
                      Navigator.push( context,
                          MaterialPageRoute(
                              builder: (context) => const SignupScreen())
                      );
                    },
                  ),
                  const AcknowledgementText(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenSizeHandler.screenWidth * kButtonWidthRatio,
                        vertical: ScreenSizeHandler.screenHeight * kButtonHeightRatio),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already a redditor?',
                          style: TextStyle(
                            fontSize: ScreenSizeHandler.smaller * kButtonSmallerFontRatio,
                            color: Colors.white,
                          ),
                        ),
                        TextLink(
                          key: const Key('first_screen_log_in_text_link'),
                            fontSizeRatio: ScreenSizeHandler.smaller * kButtonSmallerFontRatio,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginScreen()));
                            },
                            text: 'Log in'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
