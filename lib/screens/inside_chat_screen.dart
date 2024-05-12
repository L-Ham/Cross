import 'dart:convert'; 
import 'dart:io'; 
 
import 'package:flutter/material.dart'; 
import 'package:flutter/widgets.dart'; 
import 'package:image_picker/image_picker.dart'; 
import 'package:intl/intl.dart'; 
import 'package:provider/provider.dart'; 
import 'package:reddit_bel_ham/screens/chatting_screen.dart'; 
import 'package:reddit_bel_ham/services/api_service.dart'; 
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart'; 
import 'package:reddit_bel_ham/components/chat_screen_components/user_message_card.dart'; 
import 'package:reddit_bel_ham/utilities/token_decoder.dart'; 
import 'package:web_socket_channel/io.dart'; 
import 'package:web_socket_channel/web_socket_channel.dart'; 
import 'package:socket_io_client/socket_io_client.dart' as IO; 
import 'package:flutter_image_compress/flutter_image_compress.dart'; 
 
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
  File? pickedImage; 
 
  @override 
  void initState() { 
    super.initState(); 
 
    fetchInitialMessages(); 
    print('zzzzzzzzzzzzzzzzzzzzzzzzzzz'); 
 
    //setupWebSocket(); 
    initializeSocket(); 
 
    print('ssssssssssssssssssssssssss'); 
  } 
 
  void initializeSocket() { 
    try { 
      socket = IO.io('https://api.reddit-bylham.me/', <String, dynamic>{
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
              avatarUrl: data['senderAvatar'], 
              message: data['type'] == 'image' ? '' : data['message'], 
              time: DateFormat('hh:mm').format(DateTime.now()), 
              isImage: data['type'] == 'text' ? false : true,  
              imageURL: data['type'] == 'image' ? data['imageUrl'] : '', 
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
 
  Future<void> pickImage() async { 
    final ImagePicker _picker = ImagePicker(); 
    final XFile? pickedFile = 
        await _picker.pickImage(source: ImageSource.gallery); 
 
    if (pickedFile != null) { 
      setState(() { 
        pickedImage = File(pickedFile.path); 
      }); 
    } else { 
      print('No image selected.'); 
    } 
  } 
 
  Future<File> compressImage(File file) async { 
    final filePath = file.absolute.path; 
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jpg')); 
    final newPath = filePath.substring(0, lastIndex) + '_compressed.jpg'; 
    final result = await FlutterImageCompress.compressAndGetFile( 
      filePath, 
      newPath, 
      quality: 50, 
    ); 
 
    return result!; 
  } 
 
  void sendImageMessage() async { 
    if (pickedImage != null) { 
      var compressedImage = await compressImage(pickedImage!); 
      var response = await apiService.sendImageMessage( 
          compressedImage, widget.conversation['_id']); 
      if (response != null) { 
        // Check if response is not null 
        print('Image uploaded successfully'); 
        setState(() { 
          messages.add( 
            Message( 
                userName: 'You', 
                avatarUrl: response['chatMessage']['senderAvatar'], 
                message: '', // Display the local file path 
                time: TimeOfDay.now().format(context), 
                isImage: true, 
                imageURL: response['chatMessage'] 
                    ['imageUrl'] // Use the server returned file path 
                ), 
          ); 
        }); 
        pickedImage = null; 
        widget.refreshConversations(); 
      } else { 
        print('Image upload failed'); 
      } 
    } 
  } 
 
  void sendMessage() async { 
    String text = _controller.text; 
    if (text.isNotEmpty) { 
      var response = 
          await apiService.sendTextMessage(widget.conversation['_id'], text); 
      print(widget.conversation['_id']); 
      if (response['message'] == "Message Sent Successfully") { 
        setState(() { 
          messages.add( 
            Message( 
                userName: 'You', 
                avatarUrl: response['chatMessage']['senderAvatar'], 
                message: text, 
                time: TimeOfDay.now().format(context), 
                isImage: false, 
                imageURL: ''), 
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
            avatarUrl: msg['senderAvatar'], 
            message: msg['type'] == 'image' ? '' : msg['message'], 
            time: formattedTime, 
            isImage: msg['type'] == 'text' ? false : true, 
            imageURL: msg['type'] == 'image' ? msg['imageUrl'] : '')); 
      } catch (e) { 
        print('Failed to fetch message: $e'); 
      } 
    } 
 
    setState(() { 
      messages = newMessages; 
    }); 
  } 
   
  @override 
  Widget build(BuildContext context) { 
    // ignore: deprecated_member_use 
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
          if (pickedImage != null) // If an image is picked, display it
            Container(
              height: 200,
              child: Image.file(pickedImage!),
            ),
          Container(
            padding: EdgeInsets.all(ScreenSizeHandler.screenWidth * 0.02),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.camera_alt_outlined),
                  onPressed: pickImage,
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
                  onPressed:
                      pickedImage != null ? sendImageMessage : sendMessage,
                ),
              ],
            ),
          ),
        ],
     ),
);
}
} 
