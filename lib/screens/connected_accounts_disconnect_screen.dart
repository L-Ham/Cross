import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_text_field.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/components/settings_components/forget_password_text.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/components/general_components/gradient_button.dart';
import 'package:reddit_bel_ham/components/settings_components/user_information_card.dart';

class DisconnectScreen extends StatefulWidget {
  const DisconnectScreen({super.key});

  static const String id = 'connected_accounts_disconnect_screen';

  @override
  State<DisconnectScreen> createState() => _DisconnectScreenState();
}

class _DisconnectScreenState extends State<DisconnectScreen> {
  TextEditingController passController = TextEditingController();
  bool isPassObscure = true;
  bool isPassNotEmpty = false;
  late String email;
  late String username;

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    passController.addListener(() {
      setState(() {
        isPassNotEmpty = passController.text.isNotEmpty;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Map<String, String>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
    if (args == null) {
      email = "daniel@email.com";
      username = "dani";
    } else {
      email = args['email']!;
      username = args['username']!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Confirm your password",
          style: TextStyle(
              color: Colors.white,
              fontSize:
                  ScreenSizeHandler.smaller * kAppBarTitleSmallerFontRatio,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenSizeHandler.screenHeight * 0.045,
                      horizontal: ScreenSizeHandler.screenWidth * 0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserInformationCard(
                        email: email,
                        username: username,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: ScreenSizeHandler.bigger * 0.022),
                        child: Text(
                          "For your security, confirm your password.",
                          style: kSettingsSubHeaderTextStyle.copyWith(
                              fontSize: ScreenSizeHandler.bigger * 0.017,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      SettingsTextField(
                        controller: passController,
                        hintText: "Password",
                        isDisconnectScreen: true,
                        isObscured: isPassObscure,
                        onTap: () {
                          setState(() {
                            isPassObscure = !isPassObscure;
                          });
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenSizeHandler.bigger * 0.015),
                        child: const ForgetPasswordText(
                          isDisconnectScreen: true,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(
                vertical: ScreenSizeHandler.screenHeight * kBottomButtonPadding,
                horizontal: ScreenSizeHandler.smaller * 0.08,
              ),
              child: GradientButton(
                key: const Key("disconnect_screen_confirm_button"),
                isPassFocused: isPassNotEmpty,
                buttonTitle: "Confirm",
                onTap: () {
                  //TODO: Implement the logic for disconnecting the account
                  if (isPassNotEmpty) {
                    showSnackBar(context, "Invalid username or password");
                  }
                },
              )),
        ],
      ),
    );
  }
}
