import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../constants.dart';
import '../components/continue_button.dart';
import '../components/acknowledgement_text.dart';
import '../components/text_link.dart';
import '../utilities/screen_size_handler.dart';

class FirstScreen extends StatelessWidget {
  FirstScreen({
    super.key,
  });

  bool isPressed = false;

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
                          horizontal: ScreenSizeHandler.screenWidth * 0.04,
                          vertical: ScreenSizeHandler.screenHeight * 0.01),
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
                    onPress: () {
                      
                    },
                    text: "Continue with Google",
                    icon: Image(
                      image: const AssetImage('assets/images/google_logo.png'),
                      height: ScreenSizeHandler.screenHeight * 0.03,
                      width: ScreenSizeHandler.screenWidth * 0.05,
                    ),
                  ),
                  ContinueButton(
                    onPress: () {},
                    text: "Continue with Email",
                    icon: const Icon(Icons.email),
                  ),
                  const AcknowledgementText(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenSizeHandler.screenWidth * 0.04,
                        vertical: ScreenSizeHandler.screenHeight * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already a redditor?',
                          style: TextStyle(
                            fontSize: ScreenSizeHandler.smaller * 0.035,
                            color: Colors.white,
                          ),
                        ),
                        TextLink(
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