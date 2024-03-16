import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/credentials_text_field.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

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
                                      fontSize:
                                          ScreenSizeHandler.bigger * 0.019),
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
                                      fontSize:
                                          ScreenSizeHandler.bigger * 0.019),
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
                      style: kDisconnectConnectedAccountsScreenTextStyle
                          .copyWith(fontSize: ScreenSizeHandler.bigger * 0.019),
                    ),
                  ),
                  CredentialsTextField(
                    controller: passController,
                    isObscure: isPassObscure,
                    text: 'Password',
                    suffixIcon: isPassFocused
                        ? IconButton(
                            icon: Icon(Icons.visibility_rounded),
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
            SizedBox(
              height: ScreenSizeHandler.screenHeight * 0.48,
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

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.isPassFocused,
  });

  final bool isPassFocused;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isPassFocused) {}
      },
      child: Opacity(
        opacity: isPassFocused ? 1 : 0.5,
        child: Container(
          height: ScreenSizeHandler.bigger * 0.065,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.red, Colors.orange],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(30.0), // adjust as needed
          ),
          child: Center(
            child: Text(
              'Confirm',
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenSizeHandler.bigger * 0.025,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
