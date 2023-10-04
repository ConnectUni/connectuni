import 'package:flutter/material.dart';
import 'chatpage.dart';

///ChatDetailPage goes into personal direct message

class ChatDetailPage extends StatefulWidget{
  final ChatUsers chatUser;
  const ChatDetailPage({required this.chatUser, Key? key}) : super(key: key);

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {

  //hardcoded conversation
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hey are you at CC?", messageType: "receiver"),
    ChatMessage(messageContent: "I'm gonna get food.", messageType: "receiver"),
    ChatMessage(messageContent: "Im headed over, let's meet up.", messageType: "sender"),
    ChatMessage(messageContent: "OK, I have class in an hour jsyk.", messageType: "receiver"),
    ChatMessage(messageContent: "Dude we have the same class.", messageType: "sender"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back,color: Colors.white,),
                  ),
                  const SizedBox(width: 2,),
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.chatUser.icon),
                    maxRadius: 20,
                  ),
                  const SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(widget.chatUser.name, style: TextStyle(color: Colors.white, fontSize: 16 ,fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6,),
                        Text("Online",style: TextStyle(color: Colors.grey.shade50, fontSize: 13),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
          body: Stack(
            children: <Widget>[
              ListView.builder(
                itemCount: messages.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return Container(
                    padding: const EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                    child: Align(
                      alignment: (messages[index].messageType == "receiver"?Alignment.topLeft:Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (messages[index].messageType  == "receiver"?Colors.grey.shade200:Colors.blue[200]),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Text(messages[index].messageContent, style: TextStyle(fontSize: 15),),
                      ),
                    ),
                  );
                },
              ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.grey,
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 10,),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Write message...",
                          hintStyle: const TextStyle(color: Colors.black54),
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(25), ),
                          enabledBorder: UnderlineInputBorder( borderRadius: BorderRadius.circular(25),),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5,),
                  FloatingActionButton(
                    onPressed: (){},
                    elevation: 0,
                    child: const Icon(Icons.send,color: Colors.white,size: 18,),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}