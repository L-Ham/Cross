import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/email_regex.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';

const String baseURL = "https://reddit-bylham.me/api";

//const String baseURL = "https://e895ac26-6dc5-4b44-8937-20b3ad854396.mock.pstmn.io/api";
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
            url = Uri.parse(
                "$baseURL$endpoint?${Uri(queryParameters: body).query}");
            print("uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu");
            print(url);
            response = await http.get(url, headers: headers);
          } else {
            response = await http.get(url, headers: headers);
          }
          break;
        case 'POST':
          response =
              await http.post(url, headers: headers, body: jsonEncode(body));
          break;
        case 'DELETE':
          response =
              await http.delete(url, headers: headers, body: jsonEncode(body));
          break;
        case 'PATCH':
          print(url);
          response =
              await http.patch(url, headers: headers, body: jsonEncode(body));
          break;
        case 'DELETE':
          var request = http.Request('DELETE', url);
          request.headers.addAll(headers);
          if (body != null) {
            request.body = jsonEncode(body);
          }
          var streamedResponse = await request.send();
          response = await http.Response.fromStream(streamedResponse);
          break;
        default:
          throw Exception('HTTP method $method not implemented');
      }
      print(response.body);
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

  Future<dynamic> checkSubredditAvailability(String communityName) async {
    var result = await request(
        '/subreddit/subredditNameAvailability?name=$communityName',
        headers: headerWithToken,
        method: 'GET');
    return result;
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

  Future<dynamic> changeNotificationSettings(Map<String, dynamic> body) async {
    var result = await request('/user/notificationsSettings',
        headers: headerWithToken, method: 'PATCH', body: body);
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
    print('result: $result');
    return result;
  }

  Future<dynamic> addMediaPost(
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
    print(body['subRedditId']);
    request.fields['subRedditId'] = body['subRedditId'];
    request.fields['isNSFW'] = false.toString();
    request.fields['isSpoiler'] = body['isSpoiler'].toString();
    request.fields['isLocked'] = false.toString();

    for (var imageFile in imageFiles) {
      debugPrint('Image file path: ${imageFile.path}');
      request.files
          .add(await http.MultipartFile.fromPath('file', imageFile.path));
    }
    var response;
    try {
      response = await request.send();
      response = await http.Response.fromStream(response);
      return jsonDecode(response.body);
      // Handle the response...
    } on SocketException catch (e) {
      debugPrint('SocketException: $e');
      // Handle the exception...
    }
    if (response.statusCode == 200) {
      debugPrint('Media uploaded successfully');
    } else {
      debugPrint(response.statusCode.toString());
      String responseBody = await response.stream.bytesToString();

      // Parse the string as JSON
      Map<String, dynamic> responseJson = jsonDecode(responseBody);

      debugPrint(response.statusCode.toString());
      debugPrint('Response body: $responseBody');
      debugPrint('Media upload failed');

      response = await http.Response.fromStream(response);
      return jsonDecode(response.body);
    }
  }

  Future<void> addMediaPostScheduled(
      List<File> imageFiles, Map<String, dynamic> body) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$baseURL/post/scheduledPost'));

    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': "Bearer $token",
    });

    request.fields['title'] = body['title'];
    request.fields['text'] = body['text'];
    request.fields['type'] = body['type'];
    request.fields['scheduledMinutes'] = body['scheduledMinutes'].toString();
    request.fields['subRedditId'] = body['subRedditId'];
    request.fields['isNSFW'] = false.toString();
    request.fields['isSpoiler'] = body['isSpoiler'].toString();
    request.fields['isLocked'] = false.toString();

    for (var imageFile in imageFiles) {
      debugPrint('Image file path: ${imageFile.path}');
      request.files
          .add(await http.MultipartFile.fromPath('file', imageFile.path));
    }
    var response;
    try {
      response = await request.send();
      // Handle the response...
    } on SocketException catch (e) {
      debugPrint('SocketException: $e');
      // Handle the exception...
    }
    if (response.statusCode == 200) {
      debugPrint('Media uploaded successfully');
    } else {
      debugPrint(response.statusCode.toString());
      String responseBody = await response.stream.bytesToString();

      // Parse the string as JSON
      Map<String, dynamic> responseJson = jsonDecode(response);

      debugPrint(response.statusCode.toString());
      debugPrint('Response body: $responseBody');
      debugPrint('Media upload failed');
    }
  }

  Future<dynamic> addTextPost(Map<String, dynamic> body) async {
    debugPrint('success');
    print(body);
    var result = await request('/post/createPost',
        headers: headerWithToken, method: 'POST', body: body);
    return result;
  }

  Future<dynamic> addTextPostScheduled(Map<String, dynamic> body) async {
    debugPrint('success');
    var result = await request('/post/scheduledPost',
        headers: headerWithToken, method: 'POST', body: body);
    print(result);
    return result;
  }

  Future<dynamic> addPollPost(Map<String, dynamic> body) async {
    var result = await request('/post/createPost',
        headers: headerWithToken, method: 'POST', body: body);
    return result;
  }

  Future<dynamic> addPollPostScheduled(Map<String, dynamic> body) async {
    var result = await request('/post/scheduledPost',
        headers: headerWithToken, method: 'POST', body: body);
    print(result);
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
    return result;
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
        body: isEmailValid(username)
            ? {"email": username}
            : {"username": username});
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

  Future<dynamic> getUserChats() async {
    var response = await request('/conversation/getUserChats',
        headers: headerWithToken, method: 'GET');
    print(response);
    return response;
  }

  Future<dynamic> sendTextMessage(String conversationId, String message) async {
    var response = await request('/chat/sendMessage',
        headers: headerWithToken,
        method: 'POST',
        body: {"chatId": conversationId, "type": "text", "message": message});

    return response;
  }

  Future<Map<String, dynamic>?> sendImageMessage(
      File imageFile, String conversationId) async {
    print('inside api call');
    var request =
        http.MultipartRequest('POST', Uri.parse('$baseURL/chat/sendMessage'));

    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': "Bearer $token",
    });

    request.fields['chatId'] = conversationId;
    request.fields['type'] = "image";
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));

    var response;
    print('bypassed api call');
    try {
      response = await request.send();
    } on SocketException catch (e) {
      debugPrint('SocketException: $e');
    }

    if (response.statusCode == 200) {
      debugPrint('Media uploaded successfully');
      String responseBody = await response.stream.bytesToString();
      return jsonDecode(responseBody); // Return the parsed JSON
    } else {
      debugPrint('${response.statusCode.toString()}zzzzzzzzzzzzzzzzzz');
      String responseBody = await response.stream.bytesToString();
      debugPrint(response.statusCode.toString());
      debugPrint('Response body: $responseBody');
      debugPrint('Media upload failed');
      return null; // Return null or throw an exception
    }
  }

  Future<dynamic> startNewConversation(
      String chatName, List<String> participants) async {
    var response = await http.post(
      Uri.parse('https://reddit-bylham.me/api/conversation/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({"chatName": chatName, "participants": participants}),
    );
    print(response);
    print(response.statusCode);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create community');
    }
  }

  Future<dynamic> joinCommunity(String subredditID) async {
    var result = await request('/user/joinCommunity',
        headers: headerWithToken,
        method: 'PATCH',
        body: {"subRedditId": subredditID});
    return result;
  }

  Future<dynamic> leaveCommunity(String subredditID) async {
    var result = await request('/user/unjoinCommunity',
        headers: headerWithToken,
        method: 'DELETE',
        body: {"subRedditId": subredditID});

    return result;
  }

  Future<dynamic> deletePost(String postId) async {
    var result = await request('/post/deletePost',
        headers: headerWithToken, method: 'DELETE', body: {"postId": postId});
    print(result);
    return result;
  }

  Future<dynamic> muteCommunity(String subredditName) async {
    var result = await request('/user/muteCommunity',
        headers: headerWithToken,
        method: 'PATCH',
        body: {"subRedditName": subredditName});
    return result;
  }

  Future<dynamic> unmuteCommunity(String subredditName) async {
    var result = await request('/user/unmuteCommunity',
        headers: headerWithToken,
        method: 'DELETE',
        body: {"subRedditName": subredditName});

    return result;
  }

  Future<dynamic> getCommunityModerators(String communityName) async {
    Map<String, dynamic> sentData;
    sentData = {"subredditName": communityName};
    var result = await request('/subreddit/moderators',
        headers: headerWithToken, method: 'GET', body: sentData);
    return result;
  }

  Future<dynamic> getAllInbox() async {
    var result = await request('/message/getAllInbox',
        headers: headerWithToken, method: 'GET');
    return result;
  }

  Future<dynamic> getAllSent() async {
    var result = await request('/message/getSentMessages',
        headers: headerWithToken, method: 'GET');
    return result;
  }

  Future<dynamic> composeMessage(Map<String, dynamic> body) async {
    var result = await request('/message/compose',
        headers: headerWithToken, method: 'POST', body: body);
    return result;
  }

  Future<dynamic> getSavedPosts(
      String username, String page, String limit) async {
    Map<String, dynamic> sentData;
    sentData = {"username": username, "page": page, "limit": limit};
    var result = await request('/user/savedPosts',
        headers: headerWithToken, method: 'GET', body: sentData);
    print(result);
    return result;
  }

  Future<dynamic> editCommunityDetails(
      String subredditID,
      String membersNickname,
      String currentlyViewingNickname,
      String communityDescription) async {
    Map<String, dynamic> sentData;
    sentData = {
      "subredditId": subredditID,
      "membersNickname": membersNickname,
      "currentlyViewingNickname": currentlyViewingNickname,
      "communityDescription": communityDescription
    };
    var result = await request('/subreddit/communityDetails',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    // print(result);
    return result;
  }

  Future<dynamic> getApprovedUsers(String communityName) async {
    Map<String, dynamic> sentData;
    sentData = {"subredditName": communityName};
    var result = await request('/subreddit/users/approved',
        headers: headerWithToken, method: 'GET', body: sentData);
    return result;
  }

  Future<dynamic> getBannedUsers(String communityName) async {
    Map<String, dynamic> sentData;
    sentData = {"subredditName": communityName};
    var result = await request('/subreddit/users/banned',
        headers: headerWithToken, method: 'GET', body: sentData);
    return result;
  }

  Future<dynamic> getPopularCommunites() async {
    var result = await request('/subreddit/popularCommunity',
        headers: headerWithToken, method: 'GET');
    return result;
  }

  Future<dynamic> getTrendingCommunities() async {
    var result = await request('/subreddit/trendingCommunity',
        headers: headerWithToken, method: 'GET');
    return result;
  }

  Future<dynamic> markAsRead(String messageId) async {
    Map<String, dynamic> sentData;
    sentData = {
      "messageId": messageId,
    };
    var result = await request('/message/read',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<dynamic> markAsUnread(String messageId) async {
    Map<String, dynamic> sentData;
    sentData = {
      "messageId": messageId,
    };
    var result = await request('/message/unread',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<dynamic> getUserSelfInfo() async {
    var result = await request('/user/selfInfo',
        headers: headerWithToken, method: 'GET');
    return result;
  }

  Future<dynamic> getUserInfo(String id) async {
    var result = await request('/user/info?userId=$id',
        headers: headerWithToken, method: 'GET');
    return result;
  }

  Future<dynamic> addSocialLink(Map<String, dynamic> body) async {
    var result = await request('/user/socialLink',
        headers: headerWithToken, method: 'POST', body: body);
    return result;
  }

  Future<dynamic> deleteSocialLink(String linkId) async {
    Map<String, dynamic> sentData;
    sentData = {
      "socialLinkId": linkId,
    };
    var result = await request('/user/socialLink',
        headers: headerWithToken, method: 'DELETE', body: sentData);
    return result;
  }

  Future<dynamic> hideNotification(String notificationId) async {
    Map<String, dynamic> sentData;
    sentData = {
      "notificationId": notificationId,
    };
    var result = await request('/notification/hide',
        headers: headerWithToken, method: 'DELETE', body: sentData);
    return result;
  }

  Future<dynamic> markNotificationAsRead(String notificationId) async {
    Map<String, dynamic> sentData;
    sentData = {
      "notificationId": notificationId,
    };
    var result = await request('/notification/markRead',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<void> uploadAvatarImage(File imageFile) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$baseURL/user/avatarImage'));

    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': "Bearer $token",
    });

    debugPrint('Image file path: ${imageFile.path}');
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));
    var response;
    try {
      response = await request.send();
      print(response);
      // Handle the response...
    } on SocketException catch (e) {
      print('hena');
      debugPrint('SocketException: $e');
      // Handle the exception...
    }
    if (response.statusCode == 200) {
      debugPrint('Media uploaded successfully');
    } else {
      print(response.statusCode.toString());
      // debugPrint(response.statusCode.toString());
      // String responseBody = await response.stream.bytesToString();

      // Parse the string as JSON
      // Map<String, dynamic> responseJson = jsonDecode(responseBody);

      // debugPrint(response.statusCode.toString());
      // debugPrint('Response body: $responseBody');
      // debugPrint('Media upload failed');
    }
  }

  Future<void> uploadBannerImage(File imageFile) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$baseURL/user/banner'));

    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': "Bearer $token",
    });

    debugPrint('Image file path: ${imageFile.path}');
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));
    var response;
    try {
      response = await request.send();
      print(response);
      // Handle the response...
    } on SocketException catch (e) {
      debugPrint('SocketException: $e');
      // Handle the exception...
    }
    if (response.statusCode == 200) {
      debugPrint('Media uploaded successfully');
    } else {
      // debugPrint(response.statusCode.toString());
      // String responseBody = await response.stream.bytesToString();

      // Parse the string as JSON
      // Map<String, dynamic> responseJson = jsonDecode(responseBody);

      // debugPrint(response.statusCode.toString());
      // debugPrint('Response body: $responseBody');
      // debugPrint('Media upload failed');
    }
  }

  Future<dynamic> editProfileInfo(
      displayName, about, contentVisibility, communitiesVisibility) async {
    Map<String, dynamic> sentData;
    sentData = {
      "displayName": displayName,
      "about": about,
      "contentVisibility": contentVisibility,
      "communitiesVisibility": communitiesVisibility
    };
    var result = await request('/user/profileSettings',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<dynamic> getTrendingPosts() async {
    var result = await request('/post/trending',
        headers: headerWithToken, method: 'GET');
    return result;
  }

  Future<dynamic> searchPosts(Map<String, dynamic> body) async {
    print(body);
    var result = await request('/post/searchPosts',
        headers: headerWithToken, method: 'GET', body: body);
    return result;
  }

  Future<dynamic> searchComments(Map<String, dynamic> body) async {
    var result = await request('/comment/searchComments',
        headers: headerWithToken, method: 'GET', body: body);
    return result;
  }

  Future<dynamic> searchCommentsInSubreddit(Map<String, dynamic> body) async {
    var result = await request('/comment/subreddit/searchComment',
        headers: headerWithToken, method: 'GET', body: body);
    return result;
  }

  Future<dynamic> searchPostsInSubreddit(Map<String, dynamic> body) async {
    var result = await request('/post/subreddit/searchPosts',
        headers: headerWithToken, method: 'GET', body: body);
    return result;
  }

  Future<dynamic> searchCommentsInProfile(Map<String, dynamic> body) async {
    var result = await request('/user/searchComments',
        headers: headerWithToken, method: 'GET', body: body);
    return result;
  }

  Future<dynamic> searchPostsInProfile(Map<String, dynamic> body) async {
    var result = await request('/user/searchPosts',
        headers: headerWithToken, method: 'GET', body: body);
    return result;
  }

  Future<dynamic> getPostFromId(String postId) async {
    Map<String, dynamic> sentData;
    sentData = {"postId": postId};
    var result = await request('/post/get',
        headers: headerWithToken, method: 'GET', body: sentData);
    return result;
  }

  Future<dynamic> getCommentsFromPostId(Map<String, dynamic> body) async {
    var result = await request('/post/comments',
        headers: headerWithToken, method: 'GET', body: body);
    print("BOS HENAA");
    print(result);
    return result;
  }

  Future<dynamic> banUser(String subRedditName, String userName, String reason,
      String note, bool isPermanent) async {
    Map<String, dynamic> sentData;
    sentData = {
      "subredditName": subRedditName,
      "userName": userName,
      "reasonForBan": reason,
      "modNote": note,
      "permanent": isPermanent,
    };
    var result = await request('/subreddit/user/ban',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<dynamic> unbanUser(String subRedditName, String userName) async {
    Map<String, dynamic> sentData;
    sentData = {
      "subredditName": subRedditName,
      "userName": userName,
    };
    var result = await request('/subreddit/user/unban',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  // Future<List> getSavedPosts(String username, int page, int limit) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse(
  //           '$baseURL/user/savedPosts?username=$username&page=$page&limit=$limit'),
  //       headers: headerWithToken,
  //     );

  //     if (response.statusCode == 200) {
  //       final List<dynamic> responseData = jsonDecode(response.body);
  //       final List savedPosts =
  //           responseData.map((postJson) => Post.fromJson(postJson)).toList();
  //       return savedPosts;
  //     } else if (response.statusCode == 404) {
  //       throw Exception('User not found');
  //     } else {
  //       throw Exception('Failed to load saved posts: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to load saved posts: $e');
  //   }
  // }

  Future<dynamic> markAsSpoiler(String postId) async {
    Map<String, dynamic> sentData;
    sentData = {
      "postId": postId,
    };
    var result = await request('/post/markAsSpoiler',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    print(result);

    return result;
  }

  Future<dynamic> unmarkAsSpoiler(String postId) async {
    Map<String, dynamic> sentData;
    sentData = {
      "postId": postId,
    };
    var result = await request('/post/unmarkAsSpoiler',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    print(result);
    return result;
  }

  Future<dynamic> markAsNSFW(String postId) async {
    Map<String, dynamic> sentData;
    sentData = {
      "postId": postId,
    };
    var result = await request('/post/markAsNSFW',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    print(result);
    return result;
  }

  Future<dynamic> unmarkAsNSFW(String postId) async {
    Map<String, dynamic> sentData;
    sentData = {
      "postId": postId,
    };
    var result = await request('/post/unmarkAsNSFW',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    print(result);
    return result;
  }

  Future<dynamic> lockPost(String postId) async {
    Map<String, dynamic> sentData;
    sentData = {
      "postId": postId,
    };
    var result = await request('/post/lockPost',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<dynamic> unlockPost(String postId) async {
    Map<String, dynamic> sentData;
    sentData = {
      "postId": postId,
    };
    var result = await request('/post/unlockPost',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<dynamic> approvePost(String postId) async {
    Map<String, dynamic> sentData;
    sentData = {
      "postId": postId,
    };
    var result = await request('/post/approvePost',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    print(result);
    return result;
  }

  Future<dynamic> getPostDetails(String postId) async {
    Map<String, dynamic> sentData;
    sentData = {"postId": postId};
    var result = await request('/post/get',
        headers: headerWithToken, method: 'GET', body: sentData);
    return result;
  }

  Future<dynamic> getSubredditFeed(
      String subredditName, String sortType, String page, String limit) async {
    Map<String, dynamic> sentData;
    sentData = {
      "subredditName": subredditName,
      "sort": sortType,
      "page": page,
      "limit": limit
    };
    var result = await request('/subreddit/feed',
        headers: headerWithToken, method: 'GET', body: sentData);
    return result;
  }

  Future<dynamic> upvotePost(String postId) async {
    Map<String, dynamic> sentData;
    sentData = {
      "postId": postId,
    };
    var result = await request('/post/upvote',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<dynamic> downvotePost(String postId) async {
    Map<String, dynamic> sentData;
    sentData = {
      "postId": postId,
    };
    var result = await request('/post/downvote',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<dynamic> cancelUpvote(String postId) async {
    Map<String, dynamic> sentData;
    sentData = {
      "postId": postId,
    };
    var result = await request('/post/cancelUpvote',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<dynamic> cancelDownvote(String postId) async {
    Map<String, dynamic> sentData;
    sentData = {
      "postId": postId,
    };
    var result = await request('/post/cancelDownvote',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<dynamic> upvoteComment(String commentId) async {
    Map<String, dynamic> sentData;
    sentData = {
      "commentId": commentId,
    };
    var result = await request('/comment/upvote',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<dynamic> cancelCommentUpvote(String commentId) async {
    Map<String, dynamic> sentData;
    sentData = {
      "commentId": commentId,
    };
    var result = await request('/comment/cancelUpvote',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<dynamic> downvoteComment(String commentId) async {
    Map<String, dynamic> sentData;
    sentData = {
      "commentId": commentId,
    };
    var result = await request('/comment/downvote',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<dynamic> cancelCommentDownvote(String commentId) async {
    Map<String, dynamic> sentData;
    sentData = {
      "commentId": commentId,
    };
    var result = await request('/comment/cancelDownvote',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<dynamic> addVoteToPoll(String postId, String option) async {
    Map<String, dynamic> sentData;
    sentData = {
      "postId": postId,
      "option": option,
    };
    var result = await request('/post/votePoll',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<dynamic> addComment(Map<String, dynamic> body) async {
    var result = await request('/comment/addComment',
        headers: headerWithToken, method: 'POST', body: body);
    return result;
  }

  Future<dynamic> editPost(Map<String, dynamic> body) async {
    var result = await request('/post/editPost',
        headers: headerWithToken, method: 'PATCH', body: body);
    return result;
  }

  Future<dynamic> savePost(String postId) async {
    Map<String, dynamic> sentData;
    sentData = {
      "postId": postId,
    };
    var result = await request('/post/save',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<dynamic> unsavePost(String postId) async {
    Map<String, dynamic> sentData;
    sentData = {
      "postId": postId,
    };
    var result = await request('/post/unsave',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<dynamic> getAvatarImage() async {
    var result = await request('/user/avatarImage',
        headers: headerWithToken, method: 'GET');
    return result;
  }

  Future<dynamic> getBannerImage() async {
    var result =
        await request('/user/banner', headers: headerWithToken, method: 'GET');
    return result;
  }

  Future<dynamic> getAllActivity() async {
    var result = await request('/notification/user',
        headers: headerWithToken, method: 'GET');
    return result;
  }

  Future<dynamic> followUser(String username) async {
    var result = await request('/user/followUser',
        headers: headerWithToken,
        method: 'PATCH',
        body: {"usernameToFollow": username});
    return result;
  }

  Future<dynamic> unfollowUser(String username) async {
    var result = await request('/user/unfollowUser',
        headers: headerWithToken,
        method: 'PATCH',
        body: {"usernameToUnfollow": username});
    return result;
  }

  Future<dynamic> getProfileFeed(
      String username, String page, String limit) async {
    Map<String, dynamic> sentData;
    sentData = {"username": username, "page": page, "limit": limit};
    var result = await request('/user/posts',
        headers: headerWithToken, method: 'GET', body: sentData);
    return result;
  }

  Future<dynamic> getUserComments(
      String username, String page, String limit) async {
    Map<String, dynamic> sentData;
    sentData = {"username": username, "page": page, "limit": limit};
    var result = await request('/user/comments',
        headers: headerWithToken, method: 'GET', body: sentData);
    return result;
  }

  Future<dynamic> removePost(String postId) async {
    Map<String, dynamic> sentData;
    sentData = {
      "postId": postId,
    };
    var result = await request('/post/removePost',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<dynamic> addApprovedUser(String communityName, String userName) async {
    Map<String, dynamic> sentData;
    sentData = {
      "subredditName": communityName,
      "userName": userName,
    };
    var result = await request('/subreddit/user/forcedApproved',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<dynamic> removeApprovedUser(
      String communityName, String userName) async {
    Map<String, dynamic> sentData;
    sentData = {
      "subredditName": communityName,
      "userName": userName,
    };
    var result = await request('/subreddit/user/forcedRemove',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<dynamic> changeCommunityType(
      String communityName, bool ageRestriction, String privacyType) async {
    var result = await request(
        '/subreddit/type?subredditName=$communityName&ageRestriction=$ageRestriction&privacyType=$privacyType',
        headers: headerWithToken,
        method: 'PATCH',
        body: {});
    return result;
  }

  Future<dynamic> inviteModerator(String communityName, String username) async {
    Map<String, dynamic> sentData;
    sentData = {
      "subredditName": communityName,
      "invitedModeratorUsername": username,
    };
    var result = await request('/subreddit/mod/invite',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<dynamic> getHomeFeed(
      String sortType, String page, String limit) async {
    Map<String, dynamic> sentData;
    sentData = {"sort": sortType, "page": page, "limit": limit};
    var response = await request('/post/homepage/feed',
        headers: headerWithToken, method: 'GET', body: sentData);
    return response;
  }

  Future<dynamic> getUserHistory() async {
    var result = await request('/user/history/get',
        headers: headerWithToken, method: 'GET');
    return result;
  }
  Future<dynamic> getUpvotedPosts(
      String username, String page, String limit) async {
    Map<String, dynamic> sentData;
    sentData = {"username": username, "page": page, "limit": limit};
    var response = await request('/user/upvotedPosts',
        headers: headerWithToken, method: 'GET', body: sentData);
    return response;
  }
  Future<dynamic> getDownVotedPosts(
      String username, String page, String limit) async {
    Map<String, dynamic> sentData;
    sentData = {"username": username, "page": page, "limit": limit};
    var response = await request('/user/downvotedPosts',
        headers: headerWithToken, method: 'GET', body: sentData);
    return response;
  }

  Future<dynamic> getCommunityType(String communityName) async {
    Map<String, dynamic> sentData;
    sentData = {
      "subredditName": communityName,
    };
    var result = await request('/subreddit/type',
        headers: headerWithToken, method: 'GET', body: sentData);
    return result;
  }

  Future<dynamic> removeModerator(String communityName, String userName) async {
    Map<String, dynamic> sentData;
    sentData = {
      "subredditName": communityName,
      "moderatorName": userName,
    };
    var result = await request('/subreddit/mod/remove',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

  Future<dynamic> getYourCommunities() async {
    var result = await request('/user/community',
        headers: headerWithToken, method: 'GET');
    return result;
  }

  Future<dynamic> getFavouriteCommunities() async {
    var result = await request('/subreddit/user/favourite',
        headers: headerWithToken, method: 'GET');
    return result;
  }

  Future<dynamic> favouriteSubreddit(String subredditID) async {
    var result = await request('/user/favouriteSubreddit',
        headers: headerWithToken,
        method: 'PATCH',
        body: {"subRedditId": subredditID});
    return result;
  }

  Future<dynamic> unfavouriteSubreddit(String subredditID) async {
    var result = await request('/user/unfavouriteSubreddit',
        headers: headerWithToken,
        method: 'PATCH',
        body: {"subRedditId": subredditID});
    return result;
  }

  Future<dynamic> logout(String? fcmToken) async {
    var result = await request('/auth/logout',
        headers: headerWithToken, method: 'POST', body: {"fcmToken": fcmToken});
    return result;
  }
  Future<dynamic> acceptModeratorInvitation(String communityName) async {
      Map<String, dynamic> sentData;
    sentData = {
      "subredditName":communityName,
    };
    var result = await request('/subreddit/mod/invite/accept',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

    Future<dynamic> declineModeratorInvitation(String communityName) async {
      Map<String, dynamic> sentData;
    sentData = {
      "subredditName":communityName,
    };
    var result = await request('/subreddit/mod/invite/decline',
        headers: headerWithToken, method: 'PATCH', body: sentData);
    return result;
  }

}
