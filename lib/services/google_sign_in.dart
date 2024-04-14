
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return null;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    var token = googleAuth.accessToken;
    googleSignIn.signOut();
    return token;
  }

  signOutWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }
}
