// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'screens/first_screen.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {


  void continueNavigation(){
    print('Continue button pressed');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      home: FirstScreen()
    );
  }
}




