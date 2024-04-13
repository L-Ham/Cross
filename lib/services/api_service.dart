import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

const String baseURL = "https://reddit-bylham.me/api";

class ApiService {
  String token = '';
  late Map<String, String> headerWithToken;

  ApiService(String token) {
    this.token = token;
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
          if (body != null) {
            var request = http.Request('GET', url);
            request.headers.addAll(headers);
            request.body = jsonEncode(body);
            var streamedResponse = await request.send();
            response = await http.Response.fromStream(streamedResponse);
          } else {
            response = await http.get(url, headers: headers);
          }
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
        throw Exception('Failed to load data with error code ${response.body}');
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

  Future<dynamic> patchProfileSettings(
      Map<String, dynamic> profileSettings) async {
    Map<String, dynamic> sentData;
    sentData = profileSettings['profileSettings'];
    sentData.remove('socialLinks');
    var result = await request('/user/profileSettings',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<dynamic> getAllBlockedUsers() async {
    var result = await request('/user/getAllBlockedUsers',
        headers: headerWithToken, method: 'GET');
    return result;
  }

  Future<dynamic> unblockUser(String userName) async {
    Map<String, dynamic> sentData;
    sentData = {"UserNameToUnblock": userName};
    var result = await request('/user/unblockUser',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    print(result);
    return result;
  }

  Future<dynamic> blockUser(String userName) async {
    print(userName);
    Map<String, dynamic> sentData;
    sentData = {"usernameToBlock": userName};
    var result = await request('/user/blockUser',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    print(result);
    return result;
  }

  Future<dynamic> editLocation(String location) async {
    Map<String, dynamic> sentData;
    sentData = {"location": location};
    var result = await request('/user/editUserLocation',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    print(result);
    return result;
  }

  Future<dynamic> getUserLocation() async {
    var result = await request('/user/getUserLocation',
        headers: headerWithToken, method: 'GET');
    return result;
  }

  Future<dynamic> getSearchedForBlockedUsers(String userName) async {
    Map<String, dynamic> sentData;
    sentData = {"search": userName};
    var result = await request('/user/searchUsernames',
        headers: headerWithToken, method: 'GET', body: sentData);
    return result;
  }

  Future<dynamic> getCommunityDetails(String communityName) async {
    Map<String, dynamic> sentData;
    sentData = {"subRedditName": communityName};
    var result = await request('/subreddit/communityDetails',
        headers: headerWithToken, method: 'GET', body: sentData);
    return result;
  }
}
