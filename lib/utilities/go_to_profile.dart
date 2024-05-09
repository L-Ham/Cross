import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/screens/profile_screen.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';



void goToProfile(BuildContext context, String username) {
Navigator.pushNamed(context, ProfileScreen.id, arguments: {'isMyProfile': username==TokenDecoder.username, 'username': username==TokenDecoder.username?TokenDecoder.username:username});
}