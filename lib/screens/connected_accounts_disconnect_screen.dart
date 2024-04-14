import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_text_field.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/components/settings_components/forget_password_text.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/services/google_sign_in.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/components/general_components/gradient_button.dart';
import 'package:reddit_bel_ham/components/settings_components/user_information_card.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

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
  late bool isConnectedToGoogle;
  late String googleToken;

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

    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args == null) {
      email = "daniel@email.com";
      username = "dani";
      isConnectedToGoogle = false;
      googleToken = "";
    } else {
      email = args['email']!;
      username = args['username']!;
      isConnectedToGoogle = args['isConnectedToGoogle'];
      googleToken = args['googleToken']?? "";
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
                      Semantics(
                        identifier: "password_text_field",
                        child: SettingsTextField(
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
              onTap: () async {
                //TODO: Implement the logic for disconnecting the account
                if (isPassNotEmpty) {
                  if (!isConnectedToGoogle) {
                    if (googleToken != null) {
                      ApiService apiService = ApiService(TokenDecoder.token);
                      var response = await apiService.connectWithGoogle(
                          passController.text, googleToken);
                      if (response['message'] ==
                          "Google connected successfully") {
                        Navigator.pop(context, true);
                      } else {
                        showSnackBar(context, response['message']);
                      }
                    } else {
                      showSnackBar(
                          context, "Error when connecting with google");
                    }
                  } else {
                    ApiService apiService = ApiService(TokenDecoder.token);
                    var response =
                        await apiService.disconnectGoogle(passController.text);
                    if (response['message'] ==
                        "Google disconnected successfully") {
                      Navigator.pop(context, false);
                    } else {
                      showSnackBar(context, response['message']);
                    }
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
