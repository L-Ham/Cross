
import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/screens/create_community_screen.dart';
import 'screens/account_settings_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/first_screen.dart';
import 'package:reddit_bel_ham/screens/signup_screen.dart';
import 'utilities/screen_size_handler.dart';

void main() {
  runApp( MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {


  @override
  Widget build(BuildContext context) {
    ScreenSizeHandler.initialize(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);

    return  MaterialApp( 
      color: Colors.black,
      home: FirstScreen()

    );
  }
}