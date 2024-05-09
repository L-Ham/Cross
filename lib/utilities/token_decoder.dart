import 'package:jwt_decoder/jwt_decoder.dart';

class TokenDecoder {
  static String _username = "";
  static String _email = "";
  static String _token = "";
  static String _id = "";

  static void updateToken(String token) {
    _token = token;
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(_token);
    print('Token: $jwtDecodedToken');
    _username = jwtDecodedToken['user']['userName'] ?? '';
    _email = jwtDecodedToken['user']['email'] ?? '';
    _id = jwtDecodedToken['user']['id'] ?? '';
  }

  static String get token => _token;
  static String get username => _username;
  static String get email => _email;
  static String get id => _id;
}
