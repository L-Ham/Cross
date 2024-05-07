import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/time_ago.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import '../components/general_components/reddit_loading_indicator.dart';
import '../components/home_page_components/mark_all_as_read.dart';
import '../components/messaging_components/message_tile.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  static const id = "messages_screen";

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  bool isLoading = false;

  List<String> senders = [];
  List<String> subjects = [];
  List<String> messages = [];
  List<bool> isReads = [];
  List<String> publishedFrom = [];
  List<List<dynamic>> repliesList = [];
  List<String> id = [];
  List<String> actualDates = [];
  ApiService apiService = ApiService(TokenDecoder.token);

  void sortMessages() {
    List<Map<String, dynamic>> combined = List.generate(
        actualDates.length,
        (i) => {
              'sender': senders[i],
              'subject': subjects[i],
              'message': messages[i],
              'isRead': isReads[i],
              'publishedFrom': publishedFrom[i],
              'replies': repliesList[i],
              'id': id[i],
              'actualDate': DateTime.parse(actualDates[i]),
            });

    combined.sort((a, b) => b['actualDate'].compareTo(a['actualDate']));
    for (int i = 0; i < combined.length; i++) {
      senders[i] = combined[i]['sender'];
      subjects[i] = combined[i]['subject'];
      messages[i] = combined[i]['message'];
      isReads[i] = combined[i]['isRead'];
      publishedFrom[i] = combined[i]['publishedFrom'].toString();
      repliesList[i] = combined[i]['replies'];
      id[i] = combined[i]['id'];
      actualDates[i] = combined[i]['actualDate'].toIso8601String();
    }
  }

  Future<void> getAllInboxMessages() async {
    setState(() {
      isLoading = true;
      senders.clear();
      subjects.clear();
      messages.clear();
      isReads.clear();
      publishedFrom.clear();
      id.clear();
      actualDates.clear();
      repliesList.clear();
    });

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

    for (int i = 0; i < inboxResponse.length; i++) {
      id.add(inboxResponse[i]["messageId"]);
      senders.add(inboxResponse[i]["sender"]);
      subjects.add(inboxResponse[i]["subject"]);
      List? replies = inboxResponse[i]["replies"] ?? [];
      replies!.insert(0, {
        "messageId": id[i],
        "sender": senders[i],
        "subject": subjects[i],
        "createdAt": inboxResponse[i]["createdAt"],
        "message": inboxResponse[i]["message"],
        "isRead": inboxResponse[i]["isRead"],
      });
      messages.add(replies.last["message"]);
      repliesList.add(replies);
      actualDates.add(replies.last["createdAt"]);
      publishedFrom.add(timeAgo(replies.last["createdAt"]));
      if (replies.last["sender"] != TokenDecoder.username) {
        isReads.add(replies.last["isRead"]);
      } else {
        isReads.add(true);
      }
    }
    sortMessages();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void waitForGetAllInboxMessages() async {
    await getAllInboxMessages();
  }

  @override
  void didChangeDependencies() {
    final markAllAsRead = Provider.of<MarkAllAsRead>(context);
    if (!markAllAsRead.isMarkingAllAsRead) {
      waitForGetAllInboxMessages();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MarkAllAsRead>(
      builder: (context, markAllAsRead, child) {
        if (isLoading || markAllAsRead.isMarkingAllAsRead) {
          return const Align(
              alignment: Alignment.topCenter, child: RedditLoadingIndicator());
        } else {
          return RefreshIndicator(
            color: Colors.blue,
            onRefresh: getAllInboxMessages,
            child: Scaffold(
              backgroundColor: Colors.black,
              body: ListView.builder(
                itemCount: senders.length,
                itemBuilder: (context, i) {
                  return MessageTile(
                    key: ValueKey(i),
                    userName: senders[i],
                    isRead: isReads[i],
                    publishedWhen: publishedFrom[i],
                    subject: subjects[i],
                    message: messages[i],
                    replies: repliesList[i],
                    messageId: id[i],
                    onTap: () {
                      getAllInboxMessages();
                    },
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
