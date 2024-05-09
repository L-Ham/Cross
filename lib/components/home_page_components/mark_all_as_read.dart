import 'package:flutter/foundation.dart';

import '../../services/api_service.dart';
import '../../utilities/token_decoder.dart';

class MarkAllAsRead extends ChangeNotifier {
  bool isMarkingAllAsRead = false;
  bool isFinished = false;

  Future<void> markAllAsRead() async {
    ApiService apiService = ApiService(TokenDecoder.token);
    List inboxResponse = await apiService.getAllInbox();
    List sentResponse = await apiService.getAllSent();

    for (var sentMessage in sentResponse) {
      bool exists = false;
      for (var inboxMessage in inboxResponse) {
        if (inboxMessage["messageId"] == sentMessage["messageId"]) {
          exists = true;
          break;
        }
      }
      if (!exists) {
        sentMessage["sender"] = sentMessage["receiver"];
        sentMessage["isRead"] = true;
        inboxResponse.add(sentMessage);
      }
    }

    inboxResponse = inboxResponse
        .where((message) => message["parentMessage"] == null)
        .toList();

    List repliesList = [];
    for (int i = 0; i < inboxResponse.length; i++) {
      List? replies = inboxResponse[i]["replies"] ?? [];
      replies!.insert(0, {
        "messageId": inboxResponse[i]["messageId"],
        "sender": inboxResponse[i]["sender"],
        "subject": inboxResponse[i]["subject"],
        "createdAt": inboxResponse[i]["createdAt"],
        "message": inboxResponse[i]["message"],
        "isRead": inboxResponse[i]["isRead"],
      });
      repliesList.add(replies);
    }
    for (int i = 0; i < repliesList.length; i++) {
      if (!repliesList[i].last["isRead"]) {
        await apiService.markAsRead(repliesList[i].last["messageId"]);
      }
    }
  }

  Future<void> notify() async {
    isMarkingAllAsRead = true;
    notifyListeners();
    await markAllAsRead();
    isMarkingAllAsRead = false;
    isFinished = true;
    notifyListeners();
    isFinished = false;
  }
}
