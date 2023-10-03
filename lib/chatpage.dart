import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'model/convowidget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class ChatUsers{
  String name;
  String messageText;
  String imageURL;
  String time;
  ChatUsers({required this.name, required this.messageText, required this.imageURL, required this.time});
}

class _ChatPageState extends State<ChatPage> {
  List<ChatUsers> chatUsers = [
    ChatUsers(name:"PersonA", messageText: "This app is the best", imageURL: "assets/images/Person 1.jpg", time: "Now"),
    ChatUsers(name: "PersonB", messageText: "I'm really hungry", imageURL: "images/Person 2.jpg", time: "Yesterday"),
    ChatUsers(name: "PersonC", messageText: "I'm in class", imageURL: "images/Person 3.jpg", time: "31 Mar"),
    ChatUsers(name: "PersonD", messageText: "Why is everything expensive", imageURL: "images/Person4.jpg", time: "28 Mar"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Direct Messages'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.notifications,
              semanticLabel: 'notifications',
            ),
            onPressed: () {
              print('Notifications?');
            },
          ),
        ],
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 16,left: 16,right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.grey.shade100
                      )
                  ),
                ),
              ),
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return ConversationList(
                  name: chatUsers[index].name,
                  messageText: chatUsers[index].messageText,
                  imageUrl: chatUsers[index].imageURL,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 0 || index == 3)?true:false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}