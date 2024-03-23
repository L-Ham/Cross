import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/credentials_text_field.dart';
import 'package:reddit_bel_ham/components/general_components/gradient_button.dart';
import 'package:reddit_bel_ham/components/settings_components/forget_password_text.dart';
import 'package:reddit_bel_ham/components/settings_components/user_information_card.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  static const String id = 'change_password_screen';

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String email = "daniel.gebraiel01@eng-st.cu.edu.eg";
  String username = "DanielGebraiel";

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isCurrentPasswordFocused = false;
  bool isNewPasswordFocused = false;
  bool isConfirmPasswordFocused = false;
  bool isCurrentPasswordObscure = true;
  bool isNewPasswordObscure = true;
  bool isConfirmPasswordObscure = true;
  bool doPasswordsMatch = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Reset Password',
          style: kPageTitleStyle.copyWith(
              fontSize: ScreenSizeHandler.bigger * kAppBarTitleFontSizeRatio),
        ),
        backgroundColor: kBackgroundColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenSizeHandler.screenHeight *
                        kSettingsVerticalPaddingHeightRatio,
                    horizontal: kSettingsHorizontalPaddingHeightRatio *
                        ScreenSizeHandler.screenWidth,
                  ),
                  child: Column(
                    children: [
                      UserInformationCard(username: username, email: email),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: ScreenSizeHandler.screenHeight * 0.018),
                        child: CredentialsTextField(
                          controller: currentPasswordController,
                          isFocused: isCurrentPasswordFocused,
                          onChanged: (value) {
                            setState(() {
                              isCurrentPasswordFocused =
                                  currentPasswordController.text.isNotEmpty;
                            });
                          },
                          text: 'Current Password',
                          isObscure: isCurrentPasswordObscure,
                          suffixIcon: isCurrentPasswordFocused
                              ? IconButton(
                                  icon: Icon(Icons.visibility_rounded),
                                  onPressed: () {
                                    setState(() {
                                      isCurrentPasswordObscure =
                                          !isCurrentPasswordObscure;
                                    });
                                  },
                                )
                              : null,
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: ForgetPasswordText(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: ScreenSizeHandler.screenHeight * 0.018),
                        child: CredentialsTextField(
                          controller: newPasswordController,
                          isFocused: isNewPasswordFocused,
                          onChanged: (value) {
                            setState(() {
                              isNewPasswordFocused =
                                  newPasswordController.text.isNotEmpty;
                              if (value.isNotEmpty &&
                                  confirmPasswordController.text.isNotEmpty) {
                                doPasswordsMatch = newPasswordController.text ==
                                    confirmPasswordController.text;
                              } else {
                                doPasswordsMatch = true;
                              }
                            });
                          },
                          text: 'New Password',
                          isObscure: isNewPasswordObscure,
                          isValid: doPasswordsMatch,
                          suffixIcon: isNewPasswordFocused
                              ? IconButton(
                                  icon: const Icon(Icons.visibility_rounded),
                                  onPressed: () {
                                    setState(() {
                                      isNewPasswordObscure =
                                          !isNewPasswordObscure;
                                    });
                                  },
                                )
                              : null,
                        ),
                      ),
                      CredentialsTextField(
                        controller: confirmPasswordController,
                        isFocused: isConfirmPasswordFocused,
                        onChanged: (value) {
                          setState(() {
                            isConfirmPasswordFocused =
                                confirmPasswordController.text.isNotEmpty;
                            if (value.isNotEmpty &&
                                newPasswordController.text.isNotEmpty) {
                              doPasswordsMatch = newPasswordController.text ==
                                  confirmPasswordController.text;
                            } else {
                              doPasswordsMatch = true;
                            }
                          });
                        },
                        text: 'Confirm Password',
                        isObscure: isConfirmPasswordObscure,
                        isValid: doPasswordsMatch,
                        suffixIcon: isConfirmPasswordFocused
                            ? IconButton(
                                icon: Icon(Icons.visibility_rounded),
                                onPressed: () {
                                  setState(() {
                                    isConfirmPasswordObscure =
                                        !isConfirmPasswordObscure;
                                  });
                                },
                              )
                            : null,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenSizeHandler.screenHeight * 0.01),
                        child: Visibility(
                          visible: !doPasswordsMatch,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: ScreenSizeHandler.smaller * 0.05),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Passwords do not match!',
                                style: TextStyle(
                                  color: Colors.red[200],
                                  fontSize: ScreenSizeHandler.smaller * 0.03,
                                ),
                              ),
                            ),
                          ),
                        )
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: ScreenSizeHandler.screenHeight * kBottomButtonPadding,
                horizontal: kSettingsHorizontalPaddingHeightRatio *
                    ScreenSizeHandler.screenWidth),
            child: GradientButton(
                isPassFocused: (isConfirmPasswordFocused &&
                        isCurrentPasswordFocused &&
                        isNewPasswordFocused) &&
                    newPasswordController.text ==
                        confirmPasswordController.text,
                buttonTitle: 'Save',
                onTap: () {
                  if (newPasswordController.text ==
                      confirmPasswordController.text) {
                    print('yes');
                  }
                }),
          )
        ],
      ),
    );
  }
}
