import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

const String baseURL = "https://reddit-bylham.me/api";

class ApiService {
  String token;
  late Map<String, String> headerWithToken;

  ApiService(this.token) {
    token = TokenDecoder.token;
    headerWithToken = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<dynamic> request(String endpoint,
      {String method = 'GET',
      required Map<String, String> headers,
      dynamic body}) async {
    var url = Uri.parse(baseURL + endpoint);
    http.Response response;

    try {
      switch (method) {
        case 'GET':
          response = await http.get(url, headers: headers);
          break;
        case 'POST':
          response =
              await http.post(url, headers: headers, body: jsonEncode(body));
          break;
        case 'PATCH':
          response =
              await http.patch(url, headers: headers, body: jsonEncode(body));
          break;
        default:
          throw Exception('HTTP method $method not implemented');
      }

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to load data with error body ${response.body} and status code ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("Exception occured: $e");
    }
  }

  Future<dynamic> createCommunity(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseURL/subreddit/createCommunity'),
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
    var result = await request('/user/accountSettings',
        headers: headerWithToken, method: 'GET');
    return result;
  }

  Future<dynamic> patchNotificationSettings(List<bool> switchStates) async {
    var result = await request('/user/notificationsSettings',
        headers: headerWithToken,
        method: 'PATCH',
        body: {
          "inboxMessage":
              switchStates[kNotificationSettingsPrivateMessagesSwitchIndex],
          "chatMessages":
              switchStates[kNotificationSettingsChatMessagesSwitchIndex],
          "chatRequest":
              switchStates[kNotificationSettingsChatRequestsSwitchIndex],
          "mentions":
              switchStates[kNotificationSettingsMentionsOfUsernameSwitchIndex],
          "comments":
              switchStates[kNotificationSettingsCommentsOnYourPostsSwitchIndex],
          "upvotesToPosts":
              switchStates[kNotificationSettingsUpvotesOnYourPostsSwitchIndex],
          "upvotesToComments": switchStates[
              kNotificationSettingsUpvotesOnYourCommentsSwitchIndex],
          "repliesToComments": switchStates[
              kNotificationSettingsRepliesToYourCommentsSwitchIndex],
          "newFollowers":
              switchStates[kNotificationSettingsNewFollowersSwitchIndex],
          "modNotifications":
              switchStates[kNotificationSettingsModNotificationsSwitchIndex]
        });
    return result;
  }

  Future<dynamic> getNotificationSettings() async {
    var result = await request('/user/notificationsSettings',
        headers: headerWithToken, method: 'GET');
    return result;
  }

  Future<dynamic> getProfileSettings() async {
    var result = await request('/user/profileSettings',
        headers: headerWithToken, method: 'GET');
    return result;
  }

  Future<dynamic> patchGender(String newGender) async {
    var result = await request('/user/gender',
        headers: headerWithToken, method: 'PATCH', body: {"gender": newGender});
    return result;
  }

  Future<dynamic> patchProfileSettings(
      Map<String, dynamic> profileSettings) async {
    Map<String, dynamic> sentData;
    sentData = profileSettings['profileSettings'];
    sentData.remove('socialLinks');
    var result = await request('/user/profileSettings',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<void> addMediaPost(
      List<File> imageFiles, Map<String, dynamic> body) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$baseURL/post/createPost'));

    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': "Bearer $token",
    });

    request.fields['title'] = body['title'];
    request.fields['text'] = body['text'];
    request.fields['type'] = body['type'];
    request.fields['subRedditId'] = body['subRedditId'];
    request.fields['isNSFW'] = false.toString();
    request.fields['isSpoiler'] = body['isSpoiler'].toString();
    request.fields['isLocked'] = false.toString();

    for (var imageFile in imageFiles) {
      print('Image file path: ${imageFile.path}');
      request.files
          .add(await http.MultipartFile.fromPath('file', imageFile.path));
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Media uploaded successfully');
    } else {
      print(response.statusCode);
      print('Media upload failed');
    }
  }

  Future<dynamic> addTextPost(Map<String, dynamic> body) async {
    print('success');
    var result = await request('/post/createPost',
        headers: headerWithToken, method: 'POST', body: body);
    return result;
  }

  Future<dynamic> addPollPost(Map<String, dynamic> body) async {
    var result = await request('/post/createPost',
        headers: headerWithToken, method: 'POST', body: body);
    return result;
  }
}
