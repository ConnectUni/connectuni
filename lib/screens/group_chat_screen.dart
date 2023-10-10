import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/group.dart';
import '../model/message_model.dart';
import '../model/user.dart';
import 'groupinfo.dart';

class GroupChatScreen extends StatefulWidget {
  final String id;

  const GroupChatScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  @override
  Widget build(BuildContext context) {
    Group groupData = groupsDB.getGroupById(widget.id);
    Iterable<User> groupMembers = usersDB.getGroupMembers(groupData.userIds);
    Iterable<Message> messageData =
        messagesDB.getGroupMessages(groupData.groupID);
    String currentUID = 'user-001';

    return Scaffold(
      appBar: AppBar(
        title: Text("${groupData.groupName} | ${groupData.professor}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => const GroupInfo()),
              );
            },
          ),
        ],
      ),
      body: Stack(children: <Widget>[
        ListView.builder(
          itemCount: messageData.length,
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.only(
                  left: 14, right: 14, top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment:
                    (messageData.elementAt(index).senderId == currentUID
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start),
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:
                            (messageData.elementAt(index).senderId == currentUID
                                ? Colors.blue[200]
                                : Colors.grey.shade200),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        messageData.elementAt(index).messageContent,
                        style: const TextStyle(fontSize: 15),
                      )),
                  Text(
                    groupMembers
                        .firstWhere((user) =>
                            user.uid == messageData.elementAt(index).senderId)
                        .displayName,
                    style: const TextStyle(fontSize: 12),
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage(groupMembers
                        .firstWhere((user) =>
                            user.uid == messageData.elementAt(index).senderId)
                        .pfp),
                    maxRadius: 20,
                  )
                ],
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            height: 60,
            width: double.infinity,
            color: Colors.grey,
            child: Row(children: <Widget>[
              const SizedBox(width: 15),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Write message...",
                    hintStyle: const TextStyle(color: Colors.black54),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              FloatingActionButton(
                onPressed: () {},
                elevation: 0,
                child: const Icon(Icons.send, color: Colors.white, size: 18),
              ),
            ]),
          ),
        )
      ]),
    );
  }
}