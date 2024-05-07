import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit_bel_ham/components/chat_screen_components/conversation_tile.dart';
import 'package:reddit_bel_ham/components/chat_screen_components/discover_channel_card.dart';
import 'package:reddit_bel_ham/screens/inside_chat_screen.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

class ChattingScreen extends StatefulWidget {
  const ChattingScreen({Key? key}) : super(key: key);
  static const id = 'chatting_screen';

  @override
  _ChattingScreenState createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  ApiService apiService = ApiService(TokenDecoder.token);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<dynamic> conversations = [];

  @override
  void initState() {
    super.initState();
    _fetchConversations();
  }

  Future<void> _fetchConversations() async {
    // Call the API and get the conversations
    Map<String, dynamic>? fetchedResponse = await apiService.getUserChats();
    var fetchedConversations = fetchedResponse?['conversations'];

    // Check if the response is null
    if (fetchedConversations != null) {
      // Update the state of the widget
      setState(() {
        conversations = fetchedConversations;
      });
    } else {
      print('getUserChats returned null');
    }
  }

  void refreshConversations() {
    _fetchConversations();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Row(
            children: [
              Text('Chatting'),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin:
                  EdgeInsets.only(left: ScreenSizeHandler.screenWidth * 0.04),
              child: Text('Discover Channels',
                  style: TextStyle(
                      fontSize: ScreenSizeHandler.screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 151, 151, 160))),
            ),
            Container(
              height: ScreenSizeHandler.screenHeight * 0.13,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return channelCard();
                },
              ),
            ),
            TabBar(
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    ScreenSizeHandler.screenWidth *
                        0.05), // <-- Set the border radius
                color:
                    const Color.fromARGB(255, 81, 81, 82), // <-- Set the color
              ),
              labelColor: Colors.white, // <-- Set the label color
              unselectedLabelColor: const Color.fromARGB(
                  255, 158, 157, 157), // <-- Set the unselected label color
              tabs: [
                Padding(
                  padding: EdgeInsets.only(
                      right: ScreenSizeHandler.screenWidth * 0.02,
                      left: ScreenSizeHandler.screenWidth * 0.02),
                  child: Tab(text: 'Messages'),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: ScreenSizeHandler.screenWidth * 0.02,
                      left: ScreenSizeHandler.screenWidth * 0.02),
                  child: Tab(text: 'Threads'),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: ScreenSizeHandler.screenWidth * 0.02,
                      left: ScreenSizeHandler.screenWidth * 0.02),
                  child: Tab(text: 'Requests'),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView.builder(
                    itemCount: conversations.length,
                    itemBuilder: (context, index) {
                      var conversation = conversations[index];
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InsideChattingScreen(
                                  conversation:
                                      conversation, // Pass the conversation parameter here
                                  refreshConversations: refreshConversations,
                                ),
                              ),
                            );
                          },
                          child: ChatTile(conversation: conversation));
                    },
                  ),
                  // Replace these with your actual widgets for Threads and Requests
                  Container(child: Text('Threads Content')),
                  Container(child: Text('Requests Content')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
