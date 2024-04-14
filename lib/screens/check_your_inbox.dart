import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import '../utilities/screen_size_handler.dart';
import '../constants.dart';
import '../components/general_components/continue_button.dart';
import '../components/general_components/text_link.dart';
import '../components/login_components/logo_text_app_bar.dart';
import 'package:reddit_bel_ham/services/api_service.dart';

class CheckYourInboxScreen extends StatefulWidget {
  final String username;
  const CheckYourInboxScreen({Key? key, required this.username})
      : super(key: key);

  static const String id = 'check_your_inbox_screen';

  @override
  _CheckYourInboxScreenState createState() => _CheckYourInboxScreenState();
}

class _CheckYourInboxScreenState extends State<CheckYourInboxScreen>
    with WidgetsBindingObserver {
  TextEditingController nameController = TextEditingController();
  bool isNameFocused = false;
  bool isNameValid = true;
  bool isMailValid = true;
  bool didTimerFinish = false;
  bool isResending = false;
  bool isSnackBarVisible = true;
  String errorMessage = '';
  CountdownController timerController = CountdownController();
  String snackBarText = '';
  String accountName = '';
  ApiService apiService = ApiService('');
  Map<String, dynamic> response = {};

  void showSnackBar() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      snackBarText = widget.username.contains('@')
          ? ("Email sent to ${widget.username}")
          : 'Email sent';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text(snackBarText)),
          backgroundColor: Colors.white,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            left: ScreenSizeHandler.screenWidth * kButtonWidthRatio,
            right: ScreenSizeHandler.screenWidth * kButtonWidthRatio,
            bottom: ScreenSizeHandler.screenHeight * 0.09,
          ),
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      );
    });
  }

  Future<void> resendEmail() async {
    response = await apiService.forgotPassword(widget.username);
    if (response['message'] == 'Email sent') {
      showSnackBar();
      setState(() {
        isResending = false;
        didTimerFinish = false;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(response['message']),
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
    }
  }

  @override
  void initState() {
    super.initState();
    accountName = widget.username.contains('@')
        ? widget.username
        : "the email associated with your ${widget.username} account";
    showSnackBar();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this as WidgetsBindingObserver);
    super.dispose();
  }

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
                        "A link to reset your password was sent to \n $accountName",
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
                        image: const AssetImage(
                            'assets/images/thinking_avatar.png'),
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
              Visibility(
                visible: !isResending,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't get an email? ",
                      style: TextStyle(
                        fontSize:
                            ScreenSizeHandler.smaller * kButtonSmallerFontRatio,
                        color: Colors.grey,
                      ),
                    ),
                    Visibility(
                      visible: !didTimerFinish,
                      child: Countdown(
                        seconds: 60,
                        build: (BuildContext context, double time) => Text(
                          "Resend in 00:${time.toInt()}",
                          style: TextStyle(
                            fontSize: ScreenSizeHandler.smaller *
                                kButtonSmallerFontRatio,
                            color: const Color.fromARGB(255, 104, 102, 102),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        interval: const Duration(milliseconds: 100),
                        onFinished: () {
                          setState(() {
                            didTimerFinish = true;
                          });
                        },
                      ),
                    ),
                    Visibility(
                      visible: didTimerFinish,
                      child: TextLink(
                        key: const Key(
                            'check_your_inbox_screen_resend_text_link'),
                        fontSizeRatio:
                            ScreenSizeHandler.smaller * kButtonSmallerFontRatio,
                        onTap: () {
                          resendEmail();
                        },
                        text: 'Resend',
                        color: Colors.white,
                        isBold: true,
                        isUnderline: true,
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                  visible: isResending,
                  child: Text(
                    "Sending...",
                    style: TextStyle(
                      fontSize:
                          ScreenSizeHandler.smaller * kButtonSmallerFontRatio,
                      color: Colors.white,
                    ),
                  )),
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
