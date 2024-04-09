import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String serverName = "https://reddit-bylham.me/api";

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
      String token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjVmOGEzZTRiZGNlYWU5YmNiODJkYWUwIiwidHlwZSI6Im5vcm1hbCJ9LCJpYXQiOjE3MTEzMDMyNTEsImV4cCI6NTAxNzExMzAzMjUxfQ.h0qBRBJXuerCcd-tVJx0yWDCSm5oyOrRIshgXy-38Ug';
      final response = await http.post(
        Uri.parse('$serverName/subreddit/createCommunity'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
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

  Future<dynamic> getUserAccountSettings() async {
    try {
      String token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjYwZmU5ZmRiYmM0ODI1NzI4ZDA1OWM5IiwidXNlck5hbWUiOiJmb2ZhIiwiZW1haWwiOiJmYXJpZGF5YXNzZXI0NUBnbWFpbC5jb20iLCJ0eXBlIjoibm9ybWFsIn0sImlhdCI6MTcxMjY4ODk0NSwiZXhwIjoxNzEyNjk5NzQ1fQ.elaT8jEaH5V0tnyyp4JTwPKFEbRicl4S1YxLjvEXG9E";
      final response = await http.get(
        Uri.parse("$serverName/user/accountSettings"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get account settings');
      }
    } catch (e) {
      debugPrint("Exception occured: $e");
    }
  }
}
