import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/screens/inside_chat_screen.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

class NewConversationScreen extends StatefulWidget {
  @override
  _NewConversationScreenState createState() => _NewConversationScreenState();
}

class _NewConversationScreenState extends State<NewConversationScreen> {
  ApiService apiService = ApiService(TokenDecoder.token);
  final List<String> _allUsers = []; // Replace with your list of users
  final List<String> _selectedUsers = [];
  String _searchQuery = '';
  String _groupName = '';
  final List<String> _searchedUsers = [];

  void onUserSelected(String userName) {
    setState(() {
      if (!_selectedUsers.contains(userName)) {
        _selectedUsers.add(userName);
      }
    });
  }

  void searchPeople() async {
    Map<String, dynamic> response =
        await apiService.getSearchedForBlockedUsers(_searchQuery);
    print(response);
    List<dynamic> resultsList = response['matchingUsernames'];

    _searchedUsers.clear();
    for (int i = 0; i < resultsList.length; i++) {
      if (mounted) {
        setState(() {
          String userName = resultsList[i]["userName"];
          _searchedUsers.add(userName);
          if (!_allUsers.contains(userName)) {
            _allUsers.add(userName);
          }
        });
      }
    }
  }

  void startConversation() async {
    try {
      var response =
          await apiService.startNewConversation(_groupName, _selectedUsers);
      print(response);
     Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InsideChattingScreen(
          conversation: response, // Pass the response as the conversation
          refreshConversations: () {}, // Pass a function to refresh conversations
        ),
      ),
    );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final suggestionList = _searchedUsers
        .where(
            (user) => user.toLowerCase().startsWith(_searchQuery.toLowerCase()))
        .toList();

    // Add selected users to the suggestion list
    for (String user in _selectedUsers) {
      if (!suggestionList.contains(user)) {
        suggestionList.add(user);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('New Chat',
            style: TextStyle(fontSize: ScreenSizeHandler.screenWidth * 0.05)),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: ScreenSizeHandler.smaller * 0.1),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Search for people by username',
                  style: TextStyle(
                    fontSize: ScreenSizeHandler.screenWidth * 0.03,
                    color: Colors.white,
                  )),
            ),
          ),
          if (_selectedUsers.length > 1) ...[
            // Add this line
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: TextEditingController(text: _groupName),
                onChanged: (value) {
                  setState(() {
                    _groupName = value;
                  });
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Group Name',
                  hintStyle: TextStyle(
                      fontSize: ScreenSizeHandler.screenWidth * 0.035),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenSizeHandler.smaller * 0.1)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  fillColor: Colors.black,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenSizeHandler.smaller * 0.1)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenSizeHandler.smaller * 0.1)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: ScreenSizeHandler.screenHeight * 0.015),
                ),
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autofocus: true,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                  searchPeople();
                });
              },
              decoration: InputDecoration(
                hintText: "Search for a username",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenSizeHandler.smaller * 0.1)),
                  borderSide: BorderSide(color: Colors.black),
                ),
                fillColor: Colors.black,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenSizeHandler.smaller * 0.1)),
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenSizeHandler.smaller * 0.1)),
                  borderSide: BorderSide(color: Colors.black),
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: ScreenSizeHandler.screenHeight * 0.015),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: suggestionList.length,
              itemBuilder: (context, index) {
                final user = suggestionList[index];
                final isChecked = _selectedUsers.contains(user);
                return CheckboxListTile(
                  title: Text(user),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      if (value != null && value) {
                        _selectedUsers.add(user);
                      } else {
                        _selectedUsers.remove(user);
                      }
                    });
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: startConversation,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 35, 35, 36),
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.4,
                vertical: 10.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(ScreenSizeHandler.smaller * 0.1),
              ),
            ),
            child: Text(
              'Start Chat',
              style: TextStyle(
                fontSize: ScreenSizeHandler.screenWidth * 0.035,
                color: Color.fromARGB(255, 145, 144, 144),
              ),
            ),
          )
        ],
      ),
    );
  }
}
