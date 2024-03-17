import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/credentials_text_field.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/components/general_components/gradient_button.dart';

class DisconnectScreen extends StatefulWidget {
  const DisconnectScreen({super.key});

  @override
  State<DisconnectScreen> createState() => _DisconnectScreenState();
}

class _DisconnectScreenState extends State<DisconnectScreen> {
  TextEditingController passController = TextEditingController();
  bool isPassObscure = true;
  bool isPassFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kFillingColor,
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
              fontSize: ScreenSizeHandler.bigger * kAppBarTitleFontSizeRatio),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(ScreenSizeHandler.smaller * 0.045),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: kFillingColor,
                        radius: ScreenSizeHandler.bigger * 0.04,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenSizeHandler.smaller * 0.04,
                                vertical: ScreenSizeHandler.bigger * 0.01),
                            child: Text(
                              "u/Daniel_Gebraiel",
                              style: kDisconnectConnectedAccountsScreenTextStyle
                                  .copyWith(
                                      fontSize: ScreenSizeHandler.bigger * 0.019),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenSizeHandler.smaller * 0.04,
                                vertical: ScreenSizeHandler.bigger * 0.01),
                            child: Text(
                              "daniel.gebraiel01@eng-st.cu.edu.eg",
                              style: kDisconnectConnectedAccountsScreenTextStyle
                                  .copyWith(
                                      fontSize: ScreenSizeHandler.bigger * 0.019),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenSizeHandler.bigger * 0.022),
                    child: Text(
                      "For your security, confirm your password.",
                      style: kDisconnectConnectedAccountsScreenTextStyle.copyWith(
                          fontSize: ScreenSizeHandler.bigger * 0.019),
                    ),
                  ),
                  CredentialsTextField(
                    controller: passController,
                    isObscure: isPassObscure,
                    text: 'Password',
                    suffixIcon: isPassFocused
                        ? IconButton(
                            icon: const Icon(Icons.visibility_rounded),
                            onPressed: () {
                              setState(() {
                                isPassObscure = !isPassObscure;
                              });
                            },
                          )
                        : null,
                    isFocused: isPassFocused,
                    onChanged: (value) {
                      setState(() {
                        isPassFocused = value.isNotEmpty;
                      });
                    },
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: ScreenSizeHandler.bigger * 0.015),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Forgot password?",
                        style: kSettingsConnectedAccountsTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: ScreenSizeHandler.bigger * 0.02,
                horizontal: ScreenSizeHandler.smaller * 0.04,
              ),
              child: GradientButton(isPassFocused: isPassFocused),
            )
          ],
        ),
      ),
    );
  }
}
