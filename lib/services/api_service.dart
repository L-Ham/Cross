import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';

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
      return jsonDecode(response.body);
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
    }
  }

  Future<List<Post>> fetchPosts() async {
    //   final response = await http.get('https://MestanyElBackend.com/posts');

    //   if (response.statusCode == 200) {
    //     List<dynamic> jsonPosts = jsonDecode(response.body);
    //     return jsonPosts.map((json) => Post.fromJson(json)).toList();
    //   } else {
    throw Exception('Failed to load posts');
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
      debugPrint('Image file path: ${imageFile.path}');
      request.files
          .add(await http.MultipartFile.fromPath('file', imageFile.path));
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      debugPrint('Media uploaded successfully');
    } else {
      debugPrint(response.statusCode.toString());
      debugPrint('Media upload failed');
    }
  }

  Future<dynamic> addTextPost(Map<String, dynamic> body) async {
    debugPrint('success');
    var result = await request('/post/createPost',
        headers: headerWithToken, method: 'POST', body: body);
    return result;
  }

  Future<dynamic> addPollPost(Map<String, dynamic> body) async {
    var result = await request('/post/createPost',
        headers: headerWithToken, method: 'POST', body: body);
    return result;
  }

  Future<dynamic> getCommunityDetails(String communityName) async {
    Map<String, dynamic> sentData;
    sentData = {"subRedditName": communityName};
    var result = await request('/subreddit/communityDetails',
        headers: headerWithToken, method: 'GET', body: sentData);
    return result;
  }

  Future<dynamic> searchSubredditByName(String communityName) async {
    Map<String, dynamic> sentData;
    sentData = {"search": communityName};
    var result = await request('/subreddit/nameSearch',
        headers: headerWithToken, method: 'GET', body: sentData);
    return result;
  }

  Future<dynamic> getSubredditRules(String communityId) async {
    Map<String, dynamic> sentData;
    sentData = {"subredditId": communityId};
    var result = await request('/subreddit/rule',
        headers: headerWithToken, method: 'GET', body: sentData);
  }

  Future<dynamic> changePassword(
      String currentPass, String newPass, String confirmPass) async {
    Map<String, dynamic> sentData;
    sentData = {
      "oldPassword": currentPass,
      "newPassword": newPass,
      "confirmPassword": confirmPass
    };
    var result = await request('/auth/changePassword',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<dynamic> forgotPassword(String username) async {
    var result = await request('/auth/forgotPassword',
        headers: {'Content-Type': 'application/json'},
        method: 'POST',
        body: {"email": username});
    return result;
  }

  Future<dynamic> updateEmailAddress(String newEmail, String password) async {
    Map<String, dynamic> sentData;
    sentData = {
      "email": newEmail,
      "password": password,
    };
    var result = await request('/auth/email',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<dynamic> connectWithGoogle(String password, String token) async {
    Map<String, dynamic> sentData;
    sentData = {"password": password, "token": token};
    var result = await request('/auth/googleConnect',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<dynamic> disconnectGoogle(String password) async {
    var result = await request('/auth/googleDisconnect',
        headers: headerWithToken,
        method: 'PATCH',
        body: {"password": password});
    return result;
  }
}
