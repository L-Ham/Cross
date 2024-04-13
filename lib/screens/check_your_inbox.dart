import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import '../utilities/screen_size_handler.dart';
import '../constants.dart';
import '../components/general_components/continue_button.dart';
import '../components/general_components/text_link.dart';
import '../components/login_components/logo_text_app_bar.dart';

class CheckYourInboxScreen extends StatefulWidget {
  final String username;
  const CheckYourInboxScreen({Key? key, required this.username}) : super(key: key);

  static const String id = 'check_your_inox_screen';
  

  @override
  _CheckYourInboxScreenState createState() => _CheckYourInboxScreenState();
}

class _CheckYourInboxScreenState extends State<CheckYourInboxScreen> {
  
  TextEditingController nameController = TextEditingController();
  bool isNameFocused = false;
  bool isButtonEnabled = false;
  bool isNameValid = true;
  bool isMailValid = true;
  bool didTimerFinish = false;
  String errorMessage = '';
  CountdownController timerController  = CountdownController();
  // String userEmail = "test@gmail.com";
  // String userEmail = ;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LogoTextAppBar(
            text: 'Help',
            onTap: () {
              // TODO
              // should be a link that redirects the user to a help center
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      "Sorry we can't help you :(",
                      style: TextStyle(
                          fontSize: ScreenSizeHandler.bigger * 0.027,
                          fontWeight: FontWeight.bold),
                    ),
                    content: const Text('We need someone who can help us!'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
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
                      'Check your inbox',
                      style: TextStyle(
                        fontSize: ScreenSizeHandler.smaller * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: ScreenSizeHandler.screenHeight * 0.02,
                        horizontal: ScreenSizeHandler.screenWidth * 0.04,
                      ),
                      child: Text(
                        "A link to reset your password was sent to \n ${widget.username}",
                        style: TextStyle(
                          fontSize: ScreenSizeHandler.smaller * 0.04,
                          color: kHintTextColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical:
                            ScreenSizeHandler.screenHeight * kButtonHeightRatio,
                        horizontal:
                            ScreenSizeHandler.screenWidth * kButtonWidthRatio,
                      ),
                      child: Image(
                        image: const AssetImage('assets/images/thinking_avatar.png'),
                        height: ScreenSizeHandler.screenHeight * 0.22,
                        width: ScreenSizeHandler.screenWidth * 0.22,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't get an email? ",
                    style: TextStyle(
                      fontSize: ScreenSizeHandler.smaller * kButtonSmallerFontRatio,
                      color: Colors.grey,
                    ),
                  ),
                  Visibility(
                    visible: !didTimerFinish,
                    child: Countdown(
                      controller: timerController,
                      seconds: 10,
                      build: (BuildContext context, double time) {
                        return Text(
                          "Resend in 00:${time.toInt()}",
                          style: TextStyle(
                            fontSize: ScreenSizeHandler.smaller * kButtonSmallerFontRatio,
                            color: const Color.fromARGB(255, 104, 102, 102),
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                      onFinished: () {
                      //TODO
                      //replace the text and timer with a text resend link that sends the email again
                        didTimerFinish = true;
                      }
                    ),
                  ),
                  Visibility(
                    visible: didTimerFinish,
                    child: TextLink(
                      // key: const Key('first_screen_log_in_text_link'),
                        fontSizeRatio: ScreenSizeHandler.smaller * kButtonSmallerFontRatio,
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const LoginScreen()));
                        },
                        text: 'Resend'),
                  ),
                ],
              ),
              ContinueButton(
                key: const Key('check_your_inbox_screen_open_email_app_button'),
                text: "Open Email App",
                isButtonEnabled: true,
                color: kOrangeActivatedColor,
                onPress: () {
                  //TODO
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
