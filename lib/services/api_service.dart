import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseURL;

  ApiService(this.baseURL);

  Future<dynamic> request(String endpoint,
      {String method = 'GET',
      required Map<String, String> headers,
      dynamic body}) async {
    var url = Uri.parse(baseURL + endpoint);
    http.Response response;

    switch (method) {
      case 'GET':
        response = await http.get(url, headers: headers);
        break;
      case 'POST':
        response =
            await http.post(url, headers: headers, body: jsonEncode(body));
        break;
      // Add other methods as needed
      default:
        throw Exception('HTTP method $method not implemented');
    }

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> createCommunity(Map<String, dynamic> data) async {
    try {
      String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjVmOGEzZTRiZGNlYWU5YmNiODJkYWUwIiwidHlwZSI6Im5vcm1hbCJ9LCJpYXQiOjE3MTEzMDMyNTEsImV4cCI6NTAxNzExMzAzMjUxfQ.h0qBRBJXuerCcd-tVJx0yWDCSm5oyOrRIshgXy-38Ug';
      final response = await http.post(
        Uri.parse('https://reddit-bylham.me/api/subreddit/createCommunity'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'Bearer $token',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to create community');
      }
    } catch (e) {
      print('Exception occurred: $e');
      throw e;
    }
  }
}
