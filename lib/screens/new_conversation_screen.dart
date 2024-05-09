import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class NewConversationScreen extends StatefulWidget {
  @override
  _NewConversationScreenState createState() => _NewConversationScreenState();
}

class _NewConversationScreenState extends State<NewConversationScreen> {
  final List<String> _allUsers = [
    'User1',
    'User2',
    'User3',
    'User4'
  ]; // Replace with your list of users
  final List<String> _selectedUsers = [];
  String _searchQuery = '';
  String _groupName = ''; // Add this line

  @override
  Widget build(BuildContext context) {
    final suggestionList = _searchQuery.isEmpty
        ? _allUsers
        : _allUsers
            .where((user) =>
                user.toLowerCase().startsWith(_searchQuery.toLowerCase()))
            .toList();

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
                onChanged: (value) {
                  setState(() {
                    _groupName = value;
                  });
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintText: 'Group Name',
                    hintStyle: TextStyle(fontSize: ScreenSizeHandler.screenWidth*0.035),
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
            onPressed: () {},
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
