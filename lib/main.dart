import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'constants.dart';
import 'components/login_text_field.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Center(
          child: SafeArea(
              child: Column(
            children: [
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
          )),
        ),
      ),
    );
  }
}


