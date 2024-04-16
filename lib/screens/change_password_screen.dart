import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit_bel_ham/components/settings_components/forget_password_text.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_save_button.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_text_field.dart';
import 'package:reddit_bel_ham/components/settings_components/user_information_card.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

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
  FocusNode currentPasswordFocusNode = FocusNode();
  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  ApiService apiService = ApiService(TokenDecoder.token);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Map<String?, String?>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String?, String?>?;
    email = args?['email'] ?? "nardo@email.com";
    username = args?['username'] ?? "nardo";
  }

  void showSnackBar(String snackBarText) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text(snackBarText)),
          backgroundColor: Colors.white,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            left: ScreenSizeHandler.screenWidth * kButtonWidthRatio,
            right: ScreenSizeHandler.screenWidth * kButtonWidthRatio,
            bottom: ScreenSizeHandler.screenHeight * 0.05,
          ),
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      );
    });
  }

  Future<void> ChangePasswordRequest(
      String currentPass, String newPass, String confirmPass) async {
    Map<String, dynamic> response =
        await apiService.changePassword(currentPass, newPass, confirmPass);
    if (response['message'] == 'Password changed successfully') {
      Navigator.pop(context);
      setState(() {
        showSnackBar('Woohoo! Your password is updated.');
      });
    } else {
      setState(() {
        showSnackBar(response['message']);
      });
    }
  }

  bool doPasswordsMatch(String newPassword, String confirmPassword) {
    if (newPassword != confirmPassword) {
      showSnackBar("Oops, your passwords don't match. Try that again.");
      return false;
    }
    return true;
  }

  bool isNewPasswordValid(String newPassword) {
    if (newPassword.length < 8) {
      showSnackBar(
          'Sorry, your password must be at least 8 characters long. Try that again.');
      return false;
    }
    return true;
  }

  bool isEmpty(String currentPass, String newPass, String confirmPass) {
    if (currentPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
      showSnackBar('Oops, you forgot to fill everything out.');
      return true;
    }
    return false;
  }

  Future<void> saveButton() async {
    if (isEmpty(currentPasswordController.text, newPasswordController.text,
            confirmPasswordController.text) ||
        !isNewPasswordValid(newPasswordController.text) ||
        !doPasswordsMatch(
            newPasswordController.text, confirmPasswordController.text)) {
      return;
    }
    await ChangePasswordRequest(currentPasswordController.text,
        newPasswordController.text, confirmPasswordController.text);
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
            newPasswordFocusNode.unfocus();
            confirmPasswordFocusNode.unfocus();
            currentPasswordFocusNode.unfocus();
            saveButton();
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
                          child: Semantics(
                            identifier: "current_password_text_field",
                            child: SettingsTextField(
                              controller: currentPasswordController,
                              focusNode: currentPasswordFocusNode,
                              hintText: "Current password",
                              isObscured: true,
                              key: const Key(
                                  'change_password_screen_current_password_text_field'),
                            ),
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
                          child: Semantics(
                            identifier: "new_password_text_field",
                            child: SettingsTextField(
                              controller: newPasswordController,
                              focusNode: newPasswordFocusNode,
                              hintText: "New password",
                              isObscured: true,
                              key: const Key(
                                  'change_password_screen_new_password_text_field'),
                            ),
                          )),
                      Semantics(
                        identifier: "confirm_password_text_field",
                        child: SettingsTextField(
                            controller: confirmPasswordController,
                            focusNode: confirmPasswordFocusNode,
                            hintText: "Confirm new password",
                            isObscured: true,
                            key: const Key(
                                'change_password_screen_confirm_password_text_field')),
                      ),
                      // Padding(
                      //     padding: EdgeInsets.only(
                      //         top: ScreenSizeHandler.screenHeight * 0.01),
                      //     child: Visibility(
                      //       visible: !doPasswordsMatch,
                      //       child: Padding(
                      //         padding: EdgeInsets.only(
                      //             left: ScreenSizeHandler.smaller * 0.05),
                      //         child: Align(
                      //           alignment: Alignment.centerLeft,
                      //           child: Text(
                      //             'Passwords do not match!',
                      //             style: TextStyle(
                      //               color: kErrorColor,
                      //               fontSize: ScreenSizeHandler.smaller *
                      //                   kErrorMessageSmallerFontRatio,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ))
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
