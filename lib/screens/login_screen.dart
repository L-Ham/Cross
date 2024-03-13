import 'package:flutter/material.dart';
import '../constants.dart';
import '../components/login_text_field.dart';
import '../components/continue_button.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isPassObscure = true;
  bool isNameFocused = false;
  bool isPassFocused = false;
  bool activated = false;

        @override
        Widget build(BuildContext context) {
          return Scaffold(
            backgroundColor: kBackgroundColor,
            body: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ... your ContinueButton widgets here ...
                    LoginTextField(
                      controller: nameController,
                      isObscure: false,
                      text: 'Email or username',
                      suffixIcon: isNameFocused
                          ? IconButton(
                              icon: Icon(Icons.clear_rounded),
                              onPressed: () {
                                nameController.clear();
                                isNameFocused = false;
                              },
                            )
                          : null,
                      isFocused: isNameFocused,
                      onChanged: (value) {
                        isNameFocused = value.isNotEmpty;
                      },
                    ),
                    LoginTextField(
                      controller: passController,
                      isObscure: isPassObscure,
                      text: 'Password',
                      suffixIcon: isPassFocused
                          ? IconButton(
                              icon: Icon(Icons.visibility_rounded),
                              onPressed: () {
                                isPassObscure = !isPassObscure;
                              },
                            )
                          : null,
                      isFocused: isPassFocused,
                      onChanged: (value) {
                        isPassFocused = value.isNotEmpty;
                      },
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ContinueButton(
                      onPress: () {
                        print('Button pressed');
                      },
                      text: "Continue",
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      }