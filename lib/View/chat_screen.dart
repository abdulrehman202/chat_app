import 'package:chat_app/Model/ChatRoom.dart';
import 'package:chat_app/Model/Message.dart';
import 'package:chat_app/Model/User.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  ChatRoom chatRoom =
      ChatRoom('abc', User('sabc', 'Sender'), User('rabc', 'Receiver'), []);

    

  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _msgController = TextEditingController();

  Widget messageBubble(bool isSender)
  {
    double radius = 20.0;
    BoxDecoration senderDec = BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(radius),topRight: Radius.circular(radius),bottomLeft: Radius.circular(radius), ),
      );

    BoxDecoration receiverDec = BoxDecoration(
        color: const Color.fromARGB(255, 108, 208, 238),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(radius),topRight: Radius.circular(radius),bottomRight: Radius.circular(radius), ),
      );
    String temp = '0jcacbdghcdsgvydsgyudsgcsgcbxhzcbvhzvch VCHcvycvs';
    return Align(
      
          alignment: isSender?Alignment.centerRight:Alignment.centerLeft,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: isSender? senderDec:receiverDec,
        child: Wrap(
          children: [
            Text('Sample messagef'+temp,overflow: TextOverflow.clip,),
          ],
        ),
      ),
    );
  }

  Widget messageWriter() {
    return Container(
        color: const Color.fromARGB(255, 196, 213, 241),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 9,
                child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
              ),
              child: TextField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    hintText: 'Write a message...',
                    border: InputBorder.none),
                controller: _msgController,
              ),
            )),
            Expanded(
              flex: 1,
                child: Center(
                  child: IconButton(
                    onPressed: sendMsg,
                    icon: const Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                  ),
                ))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentTime  = DateTime.now();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          messageWriter(),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(
          widget.chatRoom.receiver.name,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child:  Text('${currentTime.day.toString()}/${currentTime.month.toString()}/${currentTime.year.toString()}')),
          messageBubble(true),
          messageBubble(false),
        ],
      ),
    ),
    );
  }

  void sendMsg() {
    _msgController.clear();
  }
}
