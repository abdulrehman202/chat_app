import 'package:chat_app/Model/ChatRoom.dart';
import 'package:chat_app/Model/Message.dart';
import 'package:chat_app/Model/User.dart';
import 'package:chat_app/constants.dart';
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

  Widget messageBubble(Message message) {
    DateTime msgTime = message.time;
    double radius = 30.0;
    BoxDecoration senderDec = BoxDecoration(
      color: Colors.orangeAccent,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
        bottomLeft: Radius.circular(radius),
      ),
    );

    BoxDecoration receiverDec = BoxDecoration(
      color: const Color.fromARGB(255, 108, 208, 238),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
        bottomRight: Radius.circular(radius),
      ),
    );
    return Align(
      alignment: message.sender == widget.chatRoom.sender.id ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10,left: 10,right: 10),
        decoration: message.sender == widget.chatRoom.sender.id  ? senderDec : receiverDec,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                message.content,
                overflow: TextOverflow.clip,
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.bottomRight,
                child: Text( get12hrsTime(msgTime) //'${msgTime.hour.toString().padLeft(2,'0')}:${msgTime.minute.toString().padLeft(2,'0')}'
                ))
          ],
        ),
      ),
    );
  }

  String get12hrsTime(DateTime dtime)
  {
    String time = '';
    String unit = dtime.hour>12 ?'pm':'am';
    String min = dtime.minute.toString(), hour = dtime.hour.toString();
    
    if(dtime.hour>12)
    {
      hour = (dtime.hour-12).toString();
    }

    time = '$hour:$min $unit';
    return time;
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
                      color: Color.fromARGB(255, 158, 46, 46),
                    ),
                  ),
                ))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();
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
        backgroundColor: const Color.fromARGB(255, 158, 46, 46),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Text(
                    '${currentTime.day.toString()} ${Constants.getMonth(currentTime.month)} ${currentTime.year.toString()}')),
            messageBubble(Message('abc', 'Hello!', DateTime.now(), 'sabc', 'rabc')),
            messageBubble(Message('abc', 'Hi!', DateTime.now(), 'rabc', 'sabc')),
            messageBubble(Message('abc', 'How you doing?', DateTime.now(), 'sabc', 'rabc')),
            
          ],
        ),
      ),
    );
  }

  void sendMsg() {
    _msgController.clear();
  }
}
