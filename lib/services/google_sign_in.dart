import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  signInWithGoogle() async{
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser =  await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    // return googleAuth.idToken;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // return googleAuth.idToken;
    // await FirebaseAuth.instance.signInWithCredential(credential);
    print (credential);
    return credential.accessToken;

  }
  signOutWithGoogle() async{
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  // GoogleSignInAccount? _user;
  // GoogleSignInAccount get user => _user!;
  // Future googleLogin() async {
  //   final googleUser = await googleSignIn.signIn();
  //   if (googleUser == null) return;
  //   _user = googleUser;
  //   final googleAuth = await googleUser.authentication;
  //   // final credential = GoogleAuthProvider.credential(
  //   //   accessToken: googleAuth.accessToken,
  //   //   idToken: googleAuth.idToken,
  //   // );
  //   // await FirebaseAuth.instance.signInWithCredential(credential);
  //   // notifyListeners();
  //   return googleAuth.idToken;
  }
