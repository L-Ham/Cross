// import '../services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/screens/home_page_screen.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import '../utilities/screen_size_handler.dart';
import '../constants.dart';
import '../components/general_components/credentials_text_field.dart';
import '../components/general_components/continue_button.dart';
import '../components/login_components/logo_text_app_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AboutYouScreen extends StatefulWidget {
  const AboutYouScreen({Key? key}) : super(key: key);

  static const String id = 'about_you_screen';

  @override
  AboutYouScreenState createState() => AboutYouScreenState();
}

class AboutYouScreenState extends State<AboutYouScreen> {
  String gender = '';
  late String username, email, password;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    username = args['username'];
    email = args['email'];
    password = args['password'];
  }
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPrefs();
  }

  void initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> signUp(
    String userName, String email, String password, String gender) async {
    final url = Uri.parse('https://reddit-bylham.me/api/auth/signUp');

    final Map<String, dynamic> requestData = {
      'userName': userName,
      'email': email,
      'password': password,
      'gender': gender,
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
      print('Error: $e');
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LogoTextAppBar(
            key: const Key('about_you_screen_logo_text_app_bar_skip_button'),
            text: 'Skip',
            onTap: () async {
              await signUp(username, email, password, gender);
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
                      'About you',
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
                          'Tell us about yourself to improve your \nrecommendations and ads.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: kHintTextColor,
                              fontSize: ScreenSizeHandler.smaller *
                                  kAcknowledgeTextSmallerFontRatio *
                                  1.1)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'How do you identify?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kHintTextColor,
                            fontSize: ScreenSizeHandler.smaller *
                                kAcknowledgeTextSmallerFontRatio *
                                1.1,
                          ),
                        ),
                        ContinueButton(
                          onPress: () async {
                            gender = 'Female';
                            await signUp(username, email, password, gender);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => HomePageScreen()));
                          },
                          text: 'Woman',
                          textColor: Colors.blue,
                        ),
                        ContinueButton(
                          onPress: () async {
                            gender = 'Male';
                            await signUp(username, email, password, gender);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => HomePageScreen()));
                          },
                          text: 'Man',
                          textColor: Colors.blue,
                        ),
                        ContinueButton(
                          onPress: () async {
                            gender = 'I prefer not to say';
                            await signUp(username, email, password, gender);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => HomePageScreen()));
                          },
                          text: 'I prefer not to say',
                          textColor: Colors.blue,
                        )
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
