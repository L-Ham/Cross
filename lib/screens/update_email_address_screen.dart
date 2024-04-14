import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/settings_components/user_information_card.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/components/settings_components/forget_password_text.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

import '../components/settings_components/settings_save_button.dart';
import '../components/settings_components/settings_text_field.dart';
import '../services/api_service.dart';

class UpdateEmailAddressScreen extends StatefulWidget {
  const UpdateEmailAddressScreen({super.key});

  static const String id = 'update_email_address_screen';

  @override
  State<UpdateEmailAddressScreen> createState() =>
      _UpdateEmailAddressScreenState();
}

class _UpdateEmailAddressScreenState extends State<UpdateEmailAddressScreen> {
  late String username;
  late String email;
  TextEditingController passwordController = TextEditingController();
  bool isPasswordObscure = true;
  bool isPasswordFocused = false;

  TextEditingController emailController = TextEditingController();
  bool isEmailFocused = false;
  ApiService apiService = ApiService(TokenDecoder.token);

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

  Future<void> updateEmailRequest(String email,String password) async {
    Map<String, dynamic> response = await apiService.updateEmailAddress(email,password);

    if (response['message'] == 'Email updated successfully') {
      showSnackBar('Email updated successfully');
      Navigator.pop(context);
    
    } else if (response['message'] == 'Invalid password') {
      showSnackBar('Wrong password');
    }
    else
    {
      showSnackBar('Oops, you forgot to fill everything out.');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Map<String, String> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    email = args['email'] as String;
    username = args['username'] as String;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Update email address",
          style: kPageTitleStyle.copyWith(
            fontSize: ScreenSizeHandler.smaller * kAppBarTitleSmallerFontRatio,
          ),
        ),
        centerTitle: true,
        actions: [
          SettingsSaveButton(
            onPressed: () async {
              print(emailController.text);
              print(passwordController.text);
              await updateEmailRequest(emailController.text,passwordController.text);
            },
          ),
        ],
      ),
      backgroundColor: kBackgroundColor,
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
                      horizontal: ScreenSizeHandler.screenWidth *
                          kSettingsHorizontalPaddingHeightRatio),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: ScreenSizeHandler.bigger * 0.02),
                        child: UserInformationCard(
                            username: username, email: email),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: ScreenSizeHandler.bigger * 0.005),
                        child: Text(
                          "Be sure to verify your new email address",
                          style: kSettingsSubHeaderTextStyle.copyWith(
                            fontSize:
                                ScreenSizeHandler.bigger * kSettingsTextRatio,
                          ),
                        ),
                      ),
                      Text(
                        "We'll send an email with a link to verity your update to your new email address.",
                        style: kSettingsBodyTextStyle.copyWith(
                          fontSize:
                              ScreenSizeHandler.bigger * kSettingsTextRatio,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenSizeHandler.screenHeight * 0.02),
                        child: SettingsTextField(
                          controller: emailController,
                          hintText: 'New email address',
                          key: const Key(
                              'update_email_address_email_text_field'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenSizeHandler.screenHeight * 0.02),
                        child: SettingsTextField(
                          controller: passwordController,
                          hintText: 'Reddit password',
                          isObscured: isPasswordObscure,
                          key: const Key(
                              'update_email_address_password_text_field'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: ScreenSizeHandler.screenHeight * 0.005),
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: ForgetPasswordText(),
                        ),
                      ),
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
