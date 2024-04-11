import 'package:jwt_decoder/jwt_decoder.dart';

class TokenDecoder {
  static String _username = "";
  static String _email = "";
  static String _token = "";

  static void updateToken(String token) {
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(token);
    _token = token;
    _username = jwtDecodedToken['user']['userName'];
    _email = jwtDecodedToken['user']['email'];
  }

  static String get token => _token;
  static String get username => _username;
  static String get email => _email;
}