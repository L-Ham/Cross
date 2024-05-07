import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/components/chat_screen_components/user_message_card.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class InsideChattingScreen extends StatefulWidget {
  final dynamic conversation;
  final VoidCallback refreshConversations; // Corrected type
  const InsideChattingScreen(
      {Key? key,
      required this.conversation,
      required this.refreshConversations})
      : super(key: key); // Added 'required' keyword
  static const id = 'chatting_screen';

  @override
  _InsideChattingScreenState createState() => _InsideChattingScreenState();
}

class _InsideChattingScreenState extends State<InsideChattingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  ApiService apiService = ApiService(TokenDecoder.token);

  List<Message> messages = [];
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();

    fetchInitialMessages();
    print('zzzzzzzzzzzzzzzzzzzzzzzzzzz');

    //setupWebSocket();
    initializeSocket();

    print('ssssssssssssssssssssssssss');
  }

  // void setupWebSocket() async {
  //   try {
  //     final wsUrl = Uri.parse('wss://reddit-bylham.me/api');
  //      WebSocketChannel channel= IOWebSocketChannel.connect(wsUrl);
  //     await channel.ready;
  //     print('gowa');
  //     print('beofore listening');
  //     channel.stream.listen((message) {
  //       var decodedMessage = jsonDecode(message);
  //       print('after listening');
  //       print(decodedMessage);
  //       setState(() {
  //         messages.add(Message(
  //           userName: decodedMessage['senderName'],
  //           avatarUrl: 'assets/images/avatarDaniel.png',
  //           message: decodedMessage['message'],
  //           time: DateFormat('hh:mm').format(DateTime.now()),
  //         ));
  //       });
  //     });
  //   } catch (e) {
  //     print('Failed to set up WebSocket: $e');
  //   }
  // }
  void initializeSocket() {
    try {
      socket = IO.io('http://api.reddit-bylham.me/', <String, dynamic>{
        'transports': ['websocket'],
        'query': {'token': 'Bearer ${TokenDecoder.token}'},
      });

      socket.on('connect', (_) {
        print('connected');
      });

      socket.on('newMessage', (data) {
        try {
          print('received message');
          print(data);
          setState(() {
            print('in set state');
            messages.add(Message(
              userName: data['senderName'],
              avatarUrl: 'assets/images/avatarDaniel.png',
              message: data['message'],
              time: DateFormat('hh:mm').format(DateTime.now()),
            ));
          });
        } catch (e) {
          print('Failed to decode message: $e');
        }
      });

      socket.on('disconnect', (_) => print('disconnected'));
      socket.on('error', (data) => print('error: $data'));

      socket.connect();
    } catch (e) {
      print('Failed to initialize socket: $e');
    }
  }

  void sendMessage() async {
    String text = _controller.text;
    if (text.isNotEmpty) {
      var response = await apiService.sendMessage(
          widget.conversation['_id'], text, "text");
      print(widget.conversation['_id']);
      if (response['message'] == "Message Sent Successfully") {
        setState(() {
          messages.add(
            Message(
              userName: 'You',
              avatarUrl: 'assets/images/avatarYou.png',
              message: text,
              time: TimeOfDay.now().format(context),
            ),
          );
        });
        _controller.clear();
        widget.refreshConversations();
      }
    }
  }

  void fetchInitialMessages() {
    print('fetchInitialMessages called');
    List<Message> newMessages = [];

    for (var msg in widget.conversation['messages']) {
      try {
        DateTime createdAt = DateTime.parse(msg['createdAt']);
        String formattedTime = DateFormat('hh:mm').format(createdAt);

        newMessages.add(Message(
          userName: msg['senderName'] == TokenDecoder.username
              ? 'You'
              : msg['senderName'],
          avatarUrl: 'assets/images/avatarDaniel.png',
          message: msg['message'],
          time: formattedTime,
        ));
      } catch (e) {
        print('Failed to fetch message: $e');
      }
    }

    setState(() {
      messages = newMessages;
    });
  }

  // @override
  // void dispose() {
  //   // Close the WebSocket connection
  //   channel.sink.close();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                radius: ScreenSizeHandler.screenWidth * 0.038,
                backgroundImage:
                    AssetImage('assets/images/elham_final_logo.png'),
              ),
              SizedBox(width: ScreenSizeHandler.screenWidth * 0.02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.conversation['chatName'] != null
                        ? widget.conversation['chatName']
                        : 'chatName',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenSizeHandler.screenWidth * 0.035,
                    ),
                  ),
                  Text(
                    'r/TookAPicturePH',
                    style: TextStyle(
                      color: Color.fromARGB(255, 151, 151, 160),
                      fontSize: ScreenSizeHandler.screenWidth * 0.03,
                    ),
                  ),
                ],
              )
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.ios_share_rounded),
              onPressed: () {},
            ),
          ]),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return UserMessageCard(
                  message: messages[index],
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(ScreenSizeHandler.screenWidth * 0.02),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.camera_alt_outlined),
                  onPressed: sendMessage,
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send_rounded),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
