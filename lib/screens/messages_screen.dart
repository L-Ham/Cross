import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import '../components/general_components/reddit_loading_indicator.dart';
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
  ApiService apiService = ApiService(TokenDecoder.token);

  Future<void> getAllInboxMessages() async {
    setState(() {
      isLoading = true;
    });
    senders.clear();
    subjects.clear();
    messages.clear();
    isReads.clear();
    publishedFrom.clear();
    List response = await apiService.getAllInbox();
    for (int i = 0; i < response.length; i++) {
      senders.add(response[i]["sender"]);
      subjects.add(response[i]["subject"]);
      isReads.add(response[i]["isRead"]);
      publishedFrom.add("1d");
      List? replies = response[i]["replies"] ?? [];
      replies!.insert(0, {
        "sender": senders[i],
        "subject": subjects[i],
        "publishedFrom": publishedFrom[i],
        "message": response[i]["message"]
      });
      messages.add(replies.last["message"]);
      repliesList.add(replies);
    }
    senders = senders.reversed.toList();
    subjects = subjects.reversed.toList();
    messages = messages.reversed.toList();
    isReads = isReads.reversed.toList();
    publishedFrom = publishedFrom.reversed.toList();
    repliesList = repliesList.reversed.toList();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    getAllInboxMessages();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Align(
            alignment: Alignment.topCenter, child: RedditLoadingIndicator())
        : Scaffold(
            backgroundColor: Colors.black,
            body: RefreshIndicator(
              color: Colors.blue,
              onRefresh: getAllInboxMessages,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0; i < senders.length; i++)
                      MessageTile(
                        userName: senders[i],
                        isRead: isReads[i],
                        publishedWhen: publishedFrom[i],
                        subject: subjects[i],
                        message: messages[i],
                        replies: repliesList[i],
                      )
                  ],
                ),
              ),
            ),
          );
  }
}
