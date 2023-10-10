import 'package:flutter/material.dart';
import '/model/convowidget.dart';

/// ChatPage for Direct Messages,
/// Holds models ChatMessage (for messaging screen) and ChatUsers (for chat list screen)

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

/* MODELS */
class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}

class ChatUsers {
  String name;
  String messageText;
  String icon;
  String time;
  ChatUsers(
      {required this.name,
      required this.messageText,
      required this.icon,
      required this.time});
}
/* END MODELS */

class _ChatPageState extends State<ChatPage> {
  //Hard-coding information for users to call on
  List<ChatUsers> chatUsers = [
    ChatUsers(
        name: "PersonA",
        messageText: "This app is the best",
        icon: 'assets/images/Person 1.jpg',
        time: "Now"),
    ChatUsers(
        name: "PersonB",
        messageText: "I'm really hungry",
        icon: 'assets/images/Person 2.jpg',
        time: "Yesterday"),
    ChatUsers(
        name: "PersonC",
        messageText: "I'm in class",
        icon: 'assets/images/Person 3.jpg',
        time: "31 Mar"),
    ChatUsers(
        name: "PersonD",
        messageText: "Why is everything expensive",
        icon: 'assets/images/Person4.jpg',
        time: "28 Mar"),
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
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  //TODO ADD FUNCTIONALITY
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ConversationList(
                  name: chatUsers[index].name,
                  messageText: chatUsers[index].messageText,
                  icon: chatUsers[index].icon,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
