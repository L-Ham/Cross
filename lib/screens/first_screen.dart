import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/screens/login_screen.dart';
import '../constants.dart';
import '../components/continue_button.dart';

class FirstScreen extends StatelessWidget {
  FirstScreen({
    super.key,
  });

  bool isPressed=false;

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
                    image: const AssetImage('assets/images/elham_final_logo.png'),
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                ),
                Center(
                  child: Padding(
                          padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: MediaQuery.of(context).size.height * 0.01),
                    child: Text(
                      'Reddit b Elham والهم مش راضي بينا',
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
