import 'package:flutter/material.dart';
import 'constants.dart';
import 'components/continue_button.dart';
import 'screens/first_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstScreen(),
    );
  }
}

