import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit_bel_ham/constants.dart';
class SearchScreen extends StatelessWidget {
  final List<String> searchHistory = [
    'Flutter',
    'Dart',
    'Mobile Development',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          style:TextStyle(color: Colors.white),
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
      body: ListView.builder(
        itemCount: searchHistory.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: kBackgroundColor,
            ),
            child: ListTile(
              title: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        //real search logic :(((
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.history),
                          ),
                          Text(searchHistory[index],
                              style: TextStyle(
                                color: const Color.fromARGB(255, 81, 81, 81),
                              )),
                        ],
                      )),
                  GestureDetector(
                      onTap: () {
                        searchHistory.removeAt(index);
                      },
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.clear)))
                ],
              ),
            ),
          );
        },
      ),
      backgroundColor: kBackgroundColor,
    );
  }
}