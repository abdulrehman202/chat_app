import 'dart:async';

import 'package:chat_app/Model/ChatRoom.dart';
import 'package:chat_app/Model/Message.dart';
import 'package:chat_app/Model/User.dart';
import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  User user, receiver;

  ChatScreen({super.key, required this.user, required User this.receiver});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _msgController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  late ChatRoom chatRoom;

  StreamController _streamController = StreamController<List<Message>>();
  late IO.Socket socket;

  Widget messageBubble(Message message) {
    DateTime msgTime = message.time;
    double radius = 30.0;

    String timeContent = Constants.get12hrsTime(msgTime);

    CrossAxisAlignment cAlignment = timeContent.length < message.content.length
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;

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
      alignment: message.sender == chatRoom.sender.id
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        decoration:
            message.sender == chatRoom.sender.id ? senderDec : receiverDec,
        child: Column(
          crossAxisAlignment: cAlignment,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 10, bottom: 10),
              child: Text(
                message.content,
                overflow: TextOverflow.clip,
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  timeContent,
                ))
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
                    onTap: () async {
                      await Future.delayed(const Duration(milliseconds: 500));
                      _scrollController.jumpTo(
                        _scrollController.position.maxScrollExtent,
                      );
                    },
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
  void initState() {
    // TODO: implement initState
    super.initState();

    chatRoom = ChatRoom(widget.user.id+widget.receiver.id, widget.user, widget.receiver, []);

    socket = IO.io(Constants.SERVER_URL, <String, dynamic>{
      'transports': ['websocket'],
    });

    // Event listener for 'connect' event
    socket.on('connect', (_) {
      print('Connected to server');
    });

    // Listen for messages from the server
    socket.on('message', (data) {
      try {
          if(data['chatId'].toString().contains(chatRoom.sender.id) && data['chatId'].toString().contains(chatRoom.receiver.id)){
          chatRoom.messages.add(Message(data['id'], data['content'],
              DateTime.now(), data['sender'], data['receiver'],data['chatId']));
          _streamController.sink.add(chatRoom.messages);}
      } catch (e) {
        print('');
      }
    });

    socket.connect();
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();
    _streamController.sink.add(chatRoom.messages);

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
          chatRoom.receiver.name,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 158, 46, 46),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            dateRow(currentTime),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 20),
              child: StreamBuilder(
                  stream: _streamController.stream,
                  builder: (context, snapshot) {
                    List<Message> msgs = snapshot.data ?? [];
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: msgs.length,
                        itemBuilder: (context, index) {
                          return messageBubble(msgs[index]);
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void sendMsg() {
    if (socket.connected) {
      var msg = {
        'id': 'abc',
        'content': _msgController.text,
        'time': DateTime.now().toString(),
        'sender': chatRoom.sender.id,
        'receiver': chatRoom.receiver.id,
        'chatId':chatRoom.id,
      };
      socket.emit('message', msg);
      _msgController.clear();
    }
  }

  Widget dateRow(DateTime currentTime) {
    return Row(
      children: [
        Expanded(
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Divider(
                  color: Colors.black,
                ))),
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Text(
                '${currentTime.day.toString()} ${Constants.getMonth(currentTime.month)} ${currentTime.year.toString()}')),
        Expanded(
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Divider(
                  color: Colors.black,
                ))),
      ],
    );
  }
}
