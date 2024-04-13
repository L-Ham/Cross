import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/settings_components/forget_password_text.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_save_button.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_text_field.dart';
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
  late String? email;
  late String? username;

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
  void didChangeDependencies() {
    super.didChangeDependencies();

    Map<String?, String?>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String?, String?>?;
    email = args?['email'] ?? "nardo@email.com";
    username = args?['username'] ?? "nardo";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Reset Password',
          style: kPageTitleStyle.copyWith(
              fontSize:
                  ScreenSizeHandler.screenWidth * kAppBarTitleSmallerFontRatio),
        ),
        backgroundColor: kBackgroundColor,
        actions: [
          SettingsSaveButton(onPressed: () {
            //TODO: Implement the save button functionality
          })
        ],
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
                      UserInformationCard(
                          key: const Key(
                              'change_password_screen_user_info_card'),
                          username: username!,
                          email: email!),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenSizeHandler.screenHeight * 0.018),
                          child: SettingsTextField(
                            controller: currentPasswordController,
                            hintText: "Current password",
                            isObscured: true,
                            key: const Key(
                                'change_password_screen_current_password_text_field'),
                          )),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: ForgetPasswordText(
                            key: Key(
                                'change_password_screen_forgot_password_text_link')),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenSizeHandler.screenHeight * 0.018),
                          child: SettingsTextField(
                            controller: newPasswordController,
                            hintText: "New password",
                            isObscured: true,
                            key: const Key(
                                'change_password_screen_new_password_text_field'),
                          )),
                      SettingsTextField(
                          controller: confirmPasswordController,
                          hintText: "Confirm new password",
                          isObscured: true,
                          key: const Key(
                              'change_password_screen_confirm_password_text_field')),
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
                                    color: kErrorColor,
                                    fontSize: ScreenSizeHandler.smaller *
                                        kErrorMessageSmallerFontRatio,
                                  ),
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
