import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/credentials_text_field.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/change_password_screen.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/components/general_components/gradient_button.dart';
import 'package:reddit_bel_ham/components/settings_components/user_information_card.dart';

class DisconnectScreen extends StatefulWidget {
  const DisconnectScreen({super.key});

  @override
  State<DisconnectScreen> createState() => _DisconnectScreenState();
}

class _DisconnectScreenState extends State<DisconnectScreen> {
  TextEditingController passController = TextEditingController();
  bool isPassObscure = true;
  bool isPassFocused = false;
  String email = "daniel.gebraiel01@eng-st.cu.edu.eg";
  String username = "DanielGebraiel";

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
              fontSize: ScreenSizeHandler.bigger * kAppBarTitleFontSizeRatio),
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
                  padding: EdgeInsets.all(ScreenSizeHandler.smaller * 0.045),
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
                            fontSize: ScreenSizeHandler.bigger * 0.019,
                          ),
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
                        padding: EdgeInsets.only(
                            top: ScreenSizeHandler.bigger * 0.015),
                        child: const ForgetPasswordText(),
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
              horizontal: ScreenSizeHandler.smaller * 0.04,
            ),
            child: GradientButton(
              isPassFocused: isPassFocused,
              buttonTitle: "Confirm",
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }
}
