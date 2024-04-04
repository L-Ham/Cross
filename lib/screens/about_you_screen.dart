import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/screens/home_page_screen.dart';
import '../utilities/screen_size_handler.dart';
import '../constants.dart';
import '../components/general_components/credentials_text_field.dart';
import '../components/general_components/continue_button.dart';
import '../components/login_components/logo_text_app_bar.dart';

class AboutYouScreen extends StatefulWidget {
  const AboutYouScreen({Key? key}) : super(key: key);

  static const String id = 'create_username_screen';

  @override
  AboutYouScreenState createState() => AboutYouScreenState();
}

class AboutYouScreenState extends State<AboutYouScreen> {
  String gender = 'None';
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
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePageScreen()));
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
                          onPress: () {
                            gender = 'Male';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePageScreen()));
                          },
                          text: 'Woman',
                          textColor: Colors.blue,
                        ),
                        ContinueButton(
                          onPress: () {
                            gender = 'Female';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePageScreen()));
                          },
                          text: 'Man',
                          textColor: Colors.blue,
                        ),
                        ContinueButton(
                          onPress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePageScreen()));
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
