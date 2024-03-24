import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit_bel_ham/constants.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> searchHistory = [
    'Flutter',
    'Dart',
    'Mobile Development',
  ];

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          style: TextStyle(color: Colors.white),
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: kHintTextColor),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text('Cancel',
                  style: TextStyle(color: Color.fromARGB(255, 81, 81, 81))),
            ),
          ),
        ],
        backgroundColor: kBackgroundColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: searchHistory.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: GestureDetector(
                        child: Icon(Icons.history),
                        onTap: () {
                          _searchController.text = searchHistory[index];
                        },
                      ),
                      title: Text(searchHistory[index]),
                      trailing: GestureDetector(
                        child: Icon(Icons.cancel_outlined),
                        onTap: () {
                          setState(() {
                            searchHistory.removeAt(index);
                          });
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: kBackgroundColor,
    );
  }
}