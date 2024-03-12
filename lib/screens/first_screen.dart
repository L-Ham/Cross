import 'package:flutter/material.dart';
import '../constants.dart';
import '../components/continue_button.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
                  child: Image(
                    image: AssetImage('assets/images/reddit_logo.png'),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                ),
                Center(
                  child: Padding(
                          padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: MediaQuery.of(context).size.height * 0.01),
                    child: Text(
                      'All your interests in one place',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.11,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ContinueButton(
                onPress: () {
                  print('Button pressed');
                },
                text: "Continue with phone number",
                icon: const Icon(Icons.phone),
              ),
              ContinueButton(
                onPress: () {
                  print('Button pressed');
                },
                text: "Continue with Google",
                icon: Image(
                  image: const AssetImage('assets/images/google_logo.png'),
                  height: MediaQuery.of(context).size.height * 0.03,
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
              ),
              ContinueButton(
                onPress: () {
                  print('Button pressed');
                },
                text: "Continue with Apple",
                icon: const Icon(Icons.apple),
              ),
              ContinueButton(
                onPress: () {
                  print('Button pressed');
                },
                text: "Continue with Email",
                icon: const Icon(Icons.email),
              ),
            Padding(
                    padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: MediaQuery.of(context).size.height * 0.02),
              child: Text(
                'By continuing, you agree to our User Agreement and acknowlege that you understand the Privacy Policy',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
                    padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: MediaQuery.of(context).size.height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: 
                [
                  Text(
                    'Already a redditor?',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Colors.white,
                    ),
                    
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.015),
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],),
            )
            ],
          ),
        ],
      ),
    );
  }
}
