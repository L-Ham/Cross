import 'package:flutter/material.dart';
import '../constants.dart';
import '../components/credentials_text_field.dart';
import '../components/continue_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isPassObscure = true;
  bool isNameFocused = false;
  bool isPassFocused = false;
  bool isButtonEnabled = false;

  void continueNavigation() {
    print('Continue button pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ContinueButton(
                onPress: () {
                  print('Button pressed');
                },
                text: "Continue with phone number",
                icon: const Icon(Icons.phone),
              ),
              ContinueButton(
                onPress: () {
                  print('Button pressed');
                },
                text: "Continue with Google",
                icon: Image(
                  image: const AssetImage('assets/images/google_logo.png'),
                  height: MediaQuery.of(context).size.height * 0.03,
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
              ),
              ContinueButton(
                onPress: () {
                  print('Button pressed');
                },
                text: "Continue with Apple",
                icon: const Icon(Icons.apple),
              ),
              ContinueButton(
                onPress: () {
                  print('Button pressed');
                },
                text: "Continue with Email",
                icon: const Icon(Icons.email),
              ),
              credentialsTextfield(
                controller: nameController,
                isObscure: false,
                text: 'Email or username',
                suffixIcon: isNameFocused
                    ? IconButton(
                        icon: Icon(Icons.clear_rounded),
                        onPressed: () {
                          setState(() {
                            nameController.clear();
                            isNameFocused = false;
                          });
                        },
                      )
                    : null,
                isFocused: isNameFocused,
                onChanged: (value) {
                  setState(() {
                    isNameFocused = value.isNotEmpty;
                    if (value.isNotEmpty && passController.text.isNotEmpty) {
                      setState(() {
                        isButtonEnabled = true;
                      });
                    } else {
                      setState(() {
                        isButtonEnabled = false;
                      });
                    }
                  });
                },
              ),
              credentialsTextfield(
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
                    if (value.isNotEmpty && nameController.text.isNotEmpty) {
                      setState(() {
                        isButtonEnabled = true;
                      });
                    } else {
                      setState(() {
                        isButtonEnabled = false;
                      });
                    }
                  });
                },
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ContinueButton(
                text: "Continue",
                isButtonEnabled: isButtonEnabled,
                onPress: () {
                  if (isButtonEnabled) {
                    continueNavigation();
                  } else {
                    null;
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
