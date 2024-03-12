import 'package:flutter/material.dart';
import 'constants.dart';
import 'components/login_text_field.dart';
import 'components/continue_button.dart';
void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isPassObscure = true;
  bool isNameFocused = false;
  bool isPassFocused = false;
  bool activated = false;

  void continueNavigation(){
    print('Continue button pressed');
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                LoginTextField(
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
                    });
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
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ContinueButton(
                  //disable button if no text is entered (button is still not disabled)
                onPress: () {
                  if (nameController.text.isNotEmpty && passController.text.isNotEmpty) {
                    continueNavigation();
                  }
                  else {
                    null;
                  }
                },
                
                text: "Continue",
              ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
