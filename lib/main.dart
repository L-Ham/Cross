import 'package:flutter/material.dart';
import 'create_community.dart';
import 'blocked_accounts.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: BlockedAccount(),
    );
  }
}
