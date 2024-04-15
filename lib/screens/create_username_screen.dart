import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:reddit_bel_ham/screens/about_you_screen.dart';
import '../utilities/screen_size_handler.dart';
import '../constants.dart';
import '../components/general_components/credentials_text_field.dart';
import '../components/general_components/continue_button.dart';
import '../components/login_components/logo_text_app_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../components/general_components/reddit_loading_indicator.dart';

class CreateUsernameScreen extends StatefulWidget {
  const CreateUsernameScreen({Key? key}) : super(key: key);

  static const String id = 'create_username_screen';

  @override
  CreateUsernameScreenState createState() => CreateUsernameScreenState();
}

class CreateUsernameScreenState extends State<CreateUsernameScreen> {
  late String email;
  late String password;
  late String? username;
  String firstName = '', secondName = '', thirdName = '';

  Future<void> generateUsernames() async {
    final url =
        Uri.parse('https://reddit-bylham.me/api/auth/generateUsernames');

    late final response;
    String message = 'Fetch successful.';
    try {
      response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(jsonDecode(response.body)['usernames']);
      if (response.statusCode == 200) {
        message = 'Generation successful.';
        firstName = jsonDecode(response.body)['usernames'][0];
        secondName = jsonDecode(response.body)['usernames'][1];
        thirdName = jsonDecode(response.body)['usernames'][2];
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Map<String, String> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    email = args['email'] as String;
    password = args['password'] as String;
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isNameFocused = false;
  bool isButtonEnabled = false;
  bool isValidName = true;
  bool isTaken = false;
  bool isLoading = false;
  String message = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    generateUsernames();
  }

  Future<void> checkAvailability(String username) async {
    final url = Uri.parse(
        'https://reddit-bylham.me/api/user/usernameAvailability?username=$username');

    late final response;
    try {
      response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      String recievedMessage = jsonDecode(response.body)['message'];
      message = '$recievedMessage! Try another';
      print(recievedMessage);
      if (response.statusCode == 200) {
        message = 'Great Name! It\'s not taken, so it\'s all yours.';
      }
      setState(() {
        if (recievedMessage == 'Username already taken') {
          isTaken = true;
        } else {
          isTaken = false;
        }
      });
    } catch (e) {
      print('Error: $e');
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
              key: const Key('create_username_screen_logo_text_app_bar'),
              text: '',
              onTap: () {},
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Create your username',
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
                            'Most redditors use an anonymous username. \n You won'
                            't be able to change it later.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: kHintTextColor,
                                fontSize: ScreenSizeHandler.smaller *
                                    kAcknowledgeTextSmallerFontRatio *
                                    1.1)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenSizeHandler.screenWidth *
                                kButtonWidthRatio,
                            vertical: ScreenSizeHandler.screenHeight *
                                kButtonHeightRatio),
                        child: CredentialsTextField(
                          key: const Key('create_username_screen_text_field'),
                          controller: nameController,
                          isObscure: false,
                          isValid: isValidName,
                          text: 'Username',
                          suffixIcon: isValidName &&
                                  isNameFocused &&
                                  message.contains('Great Name')
                              ? const Icon(
                                  Icons.check_rounded,
                                  color: Colors.green,
                                )
                              : !isValidName
                                  ? Icon(Icons.error, color: Colors.red[200])
                                  : null,
                          isFocused: isNameFocused,
                          onChanged: (value) async {
                            await checkAvailability(value);
                            setState(() {
                              isValidName = value.length >= 3 &&
                                  value.length <= 20 &&
                                  !value.contains(RegExp(r'[^\w\s-]')) &&
                                  !isTaken;
                              isNameFocused = value.isNotEmpty;
                              isButtonEnabled = isValidName && isNameFocused;
                              if (value.isNotEmpty &&
                                  passController.text.isNotEmpty) {
                                setState(() {});
                              } else {
                                if (value.isEmpty) {
                                  setState(() {
                                    // isValidName = true;
                                  });
                                }
                                setState(() {});
                              }
                            });
                          },
                        ),
                      ),
                      Visibility(
                        key: const Key('create_username_screen_error_text'),
                        visible: nameController.text.isNotEmpty,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: ScreenSizeHandler.screenWidth *
                                  kErrorMessageLeftPaddingRatio),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              isTaken
                                  ? message
                                  : nameController.text.length > 20 ||
                                          nameController.text.length < 3
                                      ? 'Your username must be between 3 and 20 characters.'
                                      : nameController.text
                                              .contains(RegExp(r'[^\w\s-]'))
                                          ? 'Your username can only contain letters, numbers, or the special characters - or _'
                                          : message,
                              style: TextStyle(
                                color: message.contains('Great Name') &&
                                        isValidName
                                    ? Colors.green
                                    : kErrorColor,
                                fontSize: ScreenSizeHandler.smaller *
                                    kErrorMessageSmallerFontRatio,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: ScreenSizeHandler.screenHeight * 0.04,
                              left: ScreenSizeHandler.screenWidth * 0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Need inspiration? Try these usernames:',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: kHintTextColor,
                                      fontSize: ScreenSizeHandler.smaller *
                                          kAcknowledgeTextSmallerFontRatio *
                                          1.1)),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: ScreenSizeHandler.screenHeight * 0.02,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    nameController.text = firstName;
                                    checkAvailability(nameController.text);
                                    setState(() {
                                      isNameFocused = true;
                                      isValidName = true;
                                      isButtonEnabled = true;
                                    });
                                  },
                                  child: Semantics(
                                    identifier:
                                        "create_username_screen_firstname",
                                    child: Text(firstName,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenSizeHandler
                                                    .smaller *
                                                kAcknowledgeTextSmallerFontRatio *
                                                1.2)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: ScreenSizeHandler.screenHeight * 0.02,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    nameController.text = secondName;
                                    checkAvailability(nameController.text);
                                    setState(() {
                                      isValidName = true;
                                      isNameFocused = true;
                                      isButtonEnabled = true;
                                    });
                                  },
                                  child: Semantics(
                                    identifier:
                                        "create_username_screen_secondname",
                                    child: Text(
                                      secondName,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenSizeHandler.smaller *
                                              kAcknowledgeTextSmallerFontRatio *
                                              1.2),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: ScreenSizeHandler.screenHeight * 0.02,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    nameController.text = thirdName;
                                    checkAvailability(nameController.text);
                                    setState(() {
                                      isValidName = true;
                                      isNameFocused = true;
                                      isButtonEnabled = true;
                                    });
                                  },
                                  child: Semantics(
                                    identifier:
                                        "create_username_screen_thirdname",
                                    child: Text(thirdName,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenSizeHandler
                                                    .smaller *
                                                kAcknowledgeTextSmallerFontRatio *
                                                1.2)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: ScreenSizeHandler.screenHeight * 0.02,
                                ),
                                child: GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await generateUsernames();
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                ScreenSizeHandler.screenWidth *
                                                    0.02),
                                        child: const Icon(Icons.refresh),
                                      ),
                                      Text('Refresh',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: ScreenSizeHandler
                                                      .smaller *
                                                  kAcknowledgeTextSmallerFontRatio *
                                                  1.2)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                    key: const Key('create_username_screen_continue_button'),
                    text: "Continue",
                    isButtonEnabled: isButtonEnabled,
                    onPress: () {
                      if (isButtonEnabled) {
                        setState(() {
                          username = nameController.text;
                        });
                        Navigator.pushNamed(context, AboutYouScreen.id,
                            arguments: {
                              'email': email,
                              'password': password,
                              'username': username
                            });
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
