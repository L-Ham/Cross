// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  String communityType = 'Public';
  String communityTypeDescription =
      'Anyone can view, post and comment to this community';
  bool isSwitched = false;
  bool activated = false;
  String errorText = '';

  String validateInput(String value) {
    if (value != null && value.contains(new RegExp(r'[^\w\s]'))) {
      return 'Community names must be between 3-21 characters, and can only contain letters, numbers, and underscores';

    }
    return '';
  }


  void createCommunity() {
    print('Community created');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Create a community',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(9.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.005,
            ),
            Text('Community name',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixText: 'r/',
                hintText: 'Community_name',
                suffixText: '${21 - _controller.text.length}',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _controller.clear();
                    });
                  },
                ),
              ),
              onChanged: (value) {
                if (value.length > 21) {
                  setState(() {
                    _controller.text = value.substring(0, 21);
                    _controller.selection = TextSelection.fromPosition(
                        TextPosition(offset: _controller.text.length));
                  });
                }

                setState(() {
                  errorText = validateInput(value);
                  if (value.isNotEmpty && errorText == '') {
                    activated = true;
                  } else {
                    activated = false;
                  }
                });
              },
            ),
            Text(
              errorText,
              style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.height * 0.018,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.01),
              child: Text('Community type',
                  style: TextStyle(

                    fontSize: MediaQuery.of(context).size.height * 0.02,
                  )),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SafeArea(
                      child: Container(
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.35),
                        child: Center(
                          child: Column(
                            children: [
                              ListTile(
                                title: Text('Public'),
                                subtitle: Text(
                                    'Anyone can view, post and comment to this community'),
                                leading: Icon(Icons.account_circle_outlined),
                                onTap: () {
                                  setState(() {
                                    communityType = 'Public';
                                    communityTypeDescription =
                                        'Anyone can view, post and comment to this community';
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: Text('Restricted'),
                                subtitle: Text(
                                    'Anyone can view this community, but only approved users can post'),
                                leading: Icon(Icons.check_circle_outline),
                                onTap: () {
                                  setState(() {
                                    communityType = 'Restricted';
                                    communityTypeDescription =
                                        'Anyone can view this community, but only approved users can post';
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: Text('Private'),
                                subtitle: Text(
                                    'Only approved users can view and submit to this community'),
                                leading: Icon(Icons.lock_outline),
                                onTap: () {
                                  setState(() {
                                    communityType = 'Private';
                                    communityTypeDescription =
                                        'Only approved users can view and submit to this community';
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Row(children: [
                Text(
                  communityType,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  size: MediaQuery.of(context).size.height * 0.045,
                )
              ]),
            ),
            Text(communityTypeDescription,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.018,
                  color: Colors.grey,
                )),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '18+ community',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Switch(
                  value: isSwitched,
                  thumbColor: MaterialStateProperty.all(Colors.white),
                  activeColor: Colors.blueAccent,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                ElevatedButton(
                  onPressed: (activated) ? createCommunity : null,
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(100, 60)),
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (states) => (activated)
                          ? Colors.blueAccent
                          : Colors.grey,
                    ),
                  ),
                  child: Text(
                    'Create community',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * 0.033,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
